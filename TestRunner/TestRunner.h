#ifndef TESTRUNNER_TESTRUNNER_H
#define TESTRUNNER_TESTRUNNER_H

#include "Benchmarks/BenchRunner.h"
#include "llvm/ADT/StringRef.h"

#include <llvm/ExecutionEngine/Orc/LLJIT.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/Error.h>

#include <filesystem>
#include <memory>
#include <vector>

namespace tr {
bool initLLVM();

class TestRunner {
public:
  TestRunner(std::vector<std::filesystem::path> &&Benchmarks);

  bool run();

private:
  std::unique_ptr<BenchRunner> getBenchRunner(llvm::StringRef BenchName);

  bool runBenchmark(std::filesystem::path BenchDir);

  std::vector<std::filesystem::path> Benchmarks;
  llvm::ExitOnError ExitOnErr;
  std::unique_ptr<llvm::orc::LLJIT> JIT;
};
} // namespace tr

#endif // TESTRUNNER_TESTRUNNER_H
