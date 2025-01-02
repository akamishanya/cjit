#ifndef TESTRUNNER_BENCHMARKS_BENCHRUNNER_H
#define TESTRUNNER_BENCHMARKS_BENCHRUNNER_H

#include "llvm/ADT/StringRef.h"
#include "llvm/ExecutionEngine/Orc/Core.h"
#include "llvm/Support/raw_ostream.h"
#include <llvm/ExecutionEngine/Orc/LLJIT.h>
#include <llvm/ExecutionEngine/Orc/ThreadSafeModule.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>

#include <optional>

namespace tr {
class BenchRunner {
public:
  BenchRunner(llvm::orc::LLJIT &JIT) : JIT(JIT) {}

  void init(std::unique_ptr<llvm::Module> TheModule,
            std::unique_ptr<llvm::LLVMContext> Ctx) {
    this->TheModule = std::move(TheModule);
    this->Ctx = std::move(Ctx);
  }

  virtual std::optional<double> run(unsigned NumIters, unsigned IterLength) = 0;

  virtual ~BenchRunner() {
    if (JIT.getMainJITDylib().clear()) {
      llvm::errs() << "Failed to clear dylib\n";
      std::abort();
    }
  }

protected:
  double runIter(unsigned IterNum, unsigned Duration,
                 llvm::function_ref<bool()> IterJob);

  std::unique_ptr<llvm::Module> TheModule;
  std::unique_ptr<llvm::LLVMContext> Ctx;
  llvm::orc::LLJIT &JIT;
};

class FunctionExecutor {
public:
  FunctionExecutor(std::unique_ptr<llvm::Module> Module,
                   std::unique_ptr<llvm::LLVMContext> Ctx,
                   llvm::orc::LLJIT &JIT)
      : JIT(JIT) {
    llvm::orc::ThreadSafeModule TSM(std::move(Module), std::move(Ctx));
    ExitOnErr(JIT.addIRModule(std::move(TSM)));
  }

  template <typename FuncTy> auto lookupFunc(llvm::StringRef Name) -> FuncTy * {
    auto FuncAddr = ExitOnErr(JIT.lookup(Name));
    return FuncAddr.template toPtr<FuncTy>();
  }

private:
  llvm::orc::LLJIT &JIT;
  llvm::ExitOnError ExitOnErr;
};
} // namespace tr

#endif // TESTRUNNER_BENCHMARKS_BENCHRUNNER_H
