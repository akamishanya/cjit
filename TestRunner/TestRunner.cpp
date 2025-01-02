#include "TestRunner.h"
#include "Benchmarks/BenchRunner.h"
#include "Benchmarks/FloatMM/FloatMMBenchmark.h"
#include "Benchmarks/IntMM/IntMMBenchmark.h"
#include "Benchmarks/PI/PIBenchmark.h"
#include "Benchmarks/QSort/QSortBenchmark.h"
#include "Benchmarks/Sink/SinkBenchmark.h"
#include "Benchmarks/Sum1/Sum1Benchmark.h"
#include "Benchmarks/Sum2/Sum2Benchmark.h"
#include "Benchmarks/Sum3/Sum3Benchmark.h"
#include "Benchmarks/Sum4/Sum4Benchmark.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ADT/StringSwitch.h"

#include <llvm/ExecutionEngine/Orc/DebugUtils.h>
#include <llvm/ExecutionEngine/Orc/LLJIT.h>
#include <llvm/ExecutionEngine/Orc/ObjectTransformLayer.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/StandardInstrumentations.h>
#include <llvm/Support/InitLLVM.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/TargetParser/Host.h>

#include <Optimizer.h>

#include <cassert>
#include <memory>
#include <numeric>

using namespace llvm;
using namespace llvm::orc;
using namespace tr;
using namespace opt;
namespace fs = std::filesystem;

extern cl::OptionCategory TestRunnerCat;

cl::opt<unsigned>
    IterationDuration("iter-duration",
                      cl::desc("Number of seconds to run each iteration"),
                      cl::cat(TestRunnerCat), cl::init(1));

cl::opt<unsigned>
    Iterations("iters", cl::desc("Number of iterations to run each benchmark"),
               cl::cat(TestRunnerCat), cl::init(10));

bool tr::initLLVM() {
  if (InitializeNativeTarget()) {
    errs() << "Failed to initialize native target\n";
    return false;
  }
  if (InitializeNativeTargetAsmPrinter()) {
    errs() << "Failed to initialize native target asm printer\n";
    return false;
  }
  if (InitializeNativeTargetAsmParser()) {
    errs() << "Failed to initialize native target asm parser\n";
    return false;
  }
  return true;
}

static std::unique_ptr<llvm::Module> parseIRFromFile(LLVMContext &Ctx,
                                                     std::filesystem::path P) {
  SMDiagnostic Err;
  auto TheModule = llvm::parseIRFile(P.string(), Err, Ctx);
  if (!TheModule) {
    errs() << "Failed to parse IR file " << P << ": ";
    Err.print("cjit", errs());
    return nullptr;
  }
  return TheModule;
}

static std::string dumpModuleToString(std::unique_ptr<Module> Mod) {
  std::string ModuleStr;
  llvm::raw_string_ostream OS(ModuleStr);
  Mod->print(OS, /*AAW=*/nullptr);
  return ModuleStr;
}

TestRunner::TestRunner(std::vector<fs::path> &&Benchmarks)
    : Benchmarks(std::move(Benchmarks)),
      JIT(ExitOnErr(LLJITBuilder().create())) {}

std::unique_ptr<BenchRunner> TestRunner::getBenchRunner(StringRef Name) {
  if (Name == "sink")
    return std::make_unique<SinkBenchmark>(*JIT);
  if (Name == "pi")
    return std::make_unique<PIBenchmark>(*JIT);
  if (Name == "qsort")
    return std::make_unique<QSortBenchmark>(*JIT);
  if (Name == "floatmm")
    return std::make_unique<FloatMMBenchmark>(*JIT);
  if (Name == "intmm")
    return std::make_unique<IntMMBenchmark>(*JIT);
  if (Name == "sum-1")
    return std::make_unique<Sum1Benchmark>(*JIT);
  if (Name == "sum-2")
    return std::make_unique<Sum2Benchmark>(*JIT);
  if (Name == "sum-3")
    return std::make_unique<Sum3Benchmark>(*JIT);
  if (Name == "sum-4")
    return std::make_unique<Sum4Benchmark>(*JIT);
  return nullptr;
}

bool TestRunner::run() {
  for (auto B : Benchmarks)
    if (!runBenchmark(B))
      return false;
  return true;
}

bool TestRunner::runBenchmark(std::filesystem::path BenchDir) {
  auto Context = std::make_unique<LLVMContext>();

  auto BenchName = BenchDir.filename().string();

  auto Runner = getBenchRunner(BenchName);
  if (!Runner) {
    errs() << "Runner not found for benchmark '" << BenchName << "'\n";
    return false;
  }

  auto IRName = BenchName + ".ll";
  auto IRPath = BenchDir / IRName;
  assert(fs::exists(IRPath) && "IR must exist");

  outs() << "Preparing to run benchmark '" << BenchName << "'...\n";
  auto BenchModule = parseIRFromFile(*Context, IRPath);
  if (!BenchModule)
    return false;

  BenchModule->setTargetTriple(sys::getProcessTriple());

  outs() << "Optimizing '" << BenchName << "'...\n";
  Optimizer Opt(*BenchModule);
  if (!Opt.optimizeIR()) {
    errs() << "Failed to optimize IR\n";
    return false;
  }

  Runner->init(std::move(BenchModule), std::move(Context));

  outs() << "Running '" << BenchName << "':\n";
  auto ScoreOpt = Runner->run(Iterations, IterationDuration);
  if (!ScoreOpt) {
    errs() << "Benchmark run failed.\n";
    return false;
  }
  outs() << "Average score: " << format("%15.1lf", *ScoreOpt) << " ops/s\n";
  return true;
}
