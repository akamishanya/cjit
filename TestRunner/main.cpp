#include <llvm/Support/CommandLine.h>
#include <llvm/Support/Error.h>

#include "TestRunner.h"

#include <dlfcn.h>
#include <filesystem>
#include <memory>
#include <optional>
#include <sys/wait.h>
#include <unistd.h>

using namespace llvm;
using namespace tr;
namespace fs = std::filesystem;

enum {
  SUCCESS = 0,
  ERR_INCORRECT_ARGS,
  ERR_NO_BENCHMARKS,
  ERR_BENCHMARK_RUN_FAILED,
  ERR_LLVM_INIT
};

cl::OptionCategory TestRunnerCat("test-runner Options");

static cl::opt<std::string>
    BenchmarksDir("benchmarks-dir",
                  cl::desc("Path to directory with benchmarks"),
                  cl::cat(TestRunnerCat), cl::Optional);

static cl::opt<std::string>
    Benchmark("benchmark", cl::desc("Path to specific benchmark directory"),
              cl::cat(TestRunnerCat), cl::Optional);

static std::vector<fs::path> findBenchmarksToRun() {
  if (!BenchmarksDir.getNumOccurrences() && !Benchmark.getNumOccurrences()) {
    errs() << "Either --benchmarks-dir or --benchmark must be specified.\n";
    return {};
  }
  if (BenchmarksDir.getNumOccurrences() && Benchmark.getNumOccurrences()) {
    errs() << "Either only --benchmarks-dir or only --benchmark must be "
              "specified. Both are not supported.\n";
    return {};
  }
  auto FindSingleBenchmark = [](fs::path Dir) -> std::optional<fs::path> {
    assert(fs::is_directory(Dir) && "Must be directory");
    auto IRName = Dir.filename().string() + ".ll";
    auto IRPath = Dir / IRName;
    if (!fs::exists(IRPath)) {
      errs() << "Directory " << Dir << " doesn't contain " << IRName
             << ", skipping.\n";
      return std::nullopt;
    }
    outs() << "Found benchmark " << IRName << " in " << Dir << "\n";
    return Dir;
  };
  if (Benchmark.getNumOccurrences()) {
    if (!fs::exists(Benchmark.getValue()) ||
        !fs::is_directory(Benchmark.getValue())) {
      errs() << "Benchmark dir " << Benchmark
             << " doesn't exist or is not a directory\n";
      return {};
    }
    if (auto B = FindSingleBenchmark(Benchmark.getValue()))
      return {*B};
    return {};
  }
  if (!fs::exists(BenchmarksDir.getValue()) ||
      !fs::is_directory(BenchmarksDir.getValue())) {
    errs() << "Benchmarks dir " << BenchmarksDir
           << " doesn't exist or is not a directory\n";
    return {};
  }
  std::vector<fs::path> Benchmarks;
  for (auto &Entry : fs::directory_iterator(BenchmarksDir.getValue()))
    if (fs::is_directory(Entry))
      if (auto B = FindSingleBenchmark(Entry))
        Benchmarks.push_back(*B);
  return Benchmarks;
}

int main(int argc, char **argv) {
  std::string Errors;
  llvm::raw_string_ostream ErrS(Errors);
  if (!cl::ParseCommandLineOptions(argc, argv, "", &ErrS)) {
    errs() << "Failed to parse args: " << Errors << "\n";
    return ERR_INCORRECT_ARGS;
  }

  if (!initLLVM()) {
    errs() << "Failed to init LLVM\n";
    return ERR_LLVM_INIT;
  }

  auto Benchmarks = findBenchmarksToRun();

  if (Benchmarks.empty()) {
    errs() << "No benchmarks to run found.\n";
    return ERR_NO_BENCHMARKS;
  }

  TestRunner Runner(std::move(Benchmarks));

  bool Success = Runner.run();
  if (!Success)
    return ERR_BENCHMARK_RUN_FAILED;
  return SUCCESS;
}
