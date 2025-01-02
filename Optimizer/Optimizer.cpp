#include "Optimizer.h"
#include "Passes/CustomPass.h"

#include "llvm/ADT/Twine.h"
#include "llvm/Transforms/IPO/ModuleInliner.h"
#include "llvm/Transforms/Scalar/EarlyCSE.h"
#include "llvm/Transforms/Scalar/IndVarSimplify.h"
#include "llvm/Transforms/Scalar/LICM.h"
#include "llvm/Transforms/Scalar/LoopUnrollPass.h"
#include "llvm/Transforms/Vectorize/LoopVectorize.h"
#include <llvm-19/llvm/Passes/OptimizationLevel.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Verifier.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/MC/TargetRegistry.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/StandardInstrumentations.h>
#include <llvm/Support/CommandLine.h>
#include <llvm/Support/Debug.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Support/MemoryBufferRef.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/TargetParser/Host.h>
#include <llvm/Transforms/InstCombine/InstCombine.h>
#include <llvm/Transforms/Scalar/GVN.h>
#include <llvm/Transforms/Scalar/LICM.h>
#include <llvm/Transforms/Scalar/LoopPassManager.h>
#include <llvm/Transforms/Scalar/LoopRotation.h>
#include <llvm/Transforms/Scalar/LoopSimplifyCFG.h>
#include <llvm/Transforms/Scalar/SROA.h>
#include <llvm/Transforms/Scalar/SimpleLoopUnswitch.h>
#include <llvm/Transforms/Scalar/SimplifyCFG.h>
#include <llvm/Transforms/Scalar/Sink.h>
#include <llvm/Transforms/Utils/LoopSimplify.h>
#include <llvm/Transforms/Scalar/LICM.h>

#include <optional>
#include <string>

using namespace llvm;
using namespace opt;

#define SUCCESS 0
#define ERR_INCORRECT_ARGS 1
#define ERR_FILE_DOESNT_EXIST 2
#define ERR_INITIAL_IR_PARSE_FAILURE 3
#define ERR_LLVM_INIT 4
#define ERR_OPT 5

static cl::opt<bool> Verbose("verbose", cl::init(false));

static cl::alias VerboseAlias("v", cl::desc("alias for --verbose"),
                              cl::aliasopt(Verbose));

static cl::opt<bool> DumpIR("dump-ir", cl::init(false));

static cl::opt<bool> O3("O3", cl::init(false));

static cl::opt<bool>
    DebugPM("debug-pass-manager", cl::Hidden,
            cl::desc("Print pass management debugging information"),
            cl::init(false));

bool Optimizer::optimizeIR() {
  if (!createTargetMachine())
    return false;

  if (DumpIR && !dumpIR("init"))
    return false;

  PipelineTuningOptions PTO;

  LoopAnalysisManager LAM;
  FunctionAnalysisManager FAM;
  CGSCCAnalysisManager CGAM;
  ModuleAnalysisManager MAM;

  PassInstrumentationCallbacks PIC;
  PrintPassOptions PrintPassOpts;

  StandardInstrumentations SI(Ctx, /*DebugLogging=*/DebugPM,
                              /*VerifyEach=*/false, PrintPassOpts);
  SI.registerCallbacks(PIC, &MAM);
  PassBuilder PB(&*TheTargetMachine, PTO, /*PGOOpt=*/std::nullopt, &PIC);

  // Register all the basic analyses with the managers.
  PB.registerModuleAnalyses(MAM);
  PB.registerCGSCCAnalyses(CGAM);
  PB.registerFunctionAnalyses(FAM);
  PB.registerLoopAnalyses(LAM);
  PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);

  ModulePassManager MPM;

  MPM.addPass(VerifierPass());

  if (O3) {
    if (auto Err = PB.parsePassPipeline(MPM, "default<O3>")) {
      errs() << toString(std::move(Err)) << "\n";
      return false;
    }
  } else {
    /// TODO: Extend pipeline here (extend \c MPM).
    FunctionPassManager FPM;
    FPM.addPass(SROAPass(SROAOptions::ModifyCFG));
    FPM.addPass(InstCombinePass());

    MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
  }

  MPM.addPass(VerifierPass());

  if (Verbose) {
    if (O3)
      errs() << "Running O3 optimization pipeline on module...\n";
    else
      errs() << "Running custom optimization pipeline on module...\n";
  }

  MPM.run(TheModule, MAM);

  if (Verbose)
    errs() << "Successfully ran optimization pipeline on module\n";

  if (DumpIR) {
    if (O3 && !dumpIR("opt-O3"))
      return false;
    else if (!dumpIR("opt"))
      return false;
  }
  return true;
}

bool Optimizer::createTargetMachine() {
  auto TargetTriple = TheModule.getTargetTriple();

  std::string Error;
  auto Target = TargetRegistry::lookupTarget(TargetTriple, Error);

  // Print an error and exit if we couldn't find the requested target.
  // This generally occurs if we've forgotten to initialise the
  // TargetRegistry or we have a bogus target triple.
  if (!Target) {
    errs() << "Failed to find target with target triple " << TargetTriple
           << ": " << Error << "\n";
    return false;
  }

  /// TODO: Figure out CPU and features for the current processor.
  auto CPU = llvm::sys::getHostCPUName();
  std::string Features = "";
  auto FeatMap = sys::getHostCPUFeatures();
  for (auto It = FeatMap.begin(), EndIt = FeatMap.end(); It != EndIt; ++It) {
    if (It->getValue())
      Features += "+";
    else
      Features += "-";
    Features += It->getKey();
    if (It != EndIt)
      Features += ",";
  }

  TargetOptions TO;
  auto *TM =
      Target->createTargetMachine(TargetTriple, CPU, Features, TO, Reloc::PIC_);
  if (!TM) {
    errs() << "Failed to create target machine\n";
    return false;
  }
  TheTargetMachine.reset(TM);
  DL = TheTargetMachine->createDataLayout();
  TheModule.setTargetTriple(TheTargetMachine->getTargetTriple().str());
  TheModule.setDataLayout(*DL);
  Ctx.setDefaultTargetCPU(CPU);
  Ctx.setDefaultTargetFeatures(Features);
  for (auto &F : TheModule) {
    F.addFnAttr("target-cpu", CPU);
    if (!Features.empty())
      F.addFnAttr("target-features", Features);
  }
  return true;
}

void Optimizer::printModule(llvm::raw_ostream &OS) {
  TheModule.print(OS, /*AAW=*/nullptr);
}

bool Optimizer::dumpIR(StringRef Suffix) {
  std::string FileName = (TheModule.getName().str() + "." + Suffix).str();
  std::error_code EC;
  llvm::raw_fd_ostream OS(FileName, EC);
  if (EC) {
    errs() << "Failed to dump " << Suffix << " to " << FileName << ": "
           << EC.message() << "\n";
    return false;
  }
  printModule(OS);
  errs() << " -- " << FileName << "\n";
  return true;
}
