#include "Sum3Benchmark.h"

#include <llvm/ADT/Sequence.h>
#include <math.h>
#include <numeric>
#include <optional>

using namespace llvm;

namespace tr {
static bool DoubleEq(double X, double Y, double Eps = 1e-9) {
  return fabs(X - Y) < Eps;
}

std::optional<double> Sum3Benchmark::run(unsigned NumIters,
                                         unsigned IterLength) {
  FunctionExecutor Exec(std::move(TheModule), std::move(Ctx), JIT);

  auto Sum1 = Exec.lookupFunc<unsigned()>("sum_3");
  auto Init = Exec.lookupFunc<int(int)>("init");
  auto Deinit = Exec.lookupFunc<void()>("deinit");
  if (!Init(100000)) {
    errs() << "Failed to init sum-1 benchmark\n";
    return std::nullopt;
  }

  unsigned ExpectedRes = 4294865760;
  bool GotUnexpectedRes = false;

  auto IterJob = [&]() {
    unsigned Res = Sum1();
    if (Res != ExpectedRes) {
      errs() << "Got unexpected result: expected "
             << llvm::format("%u", ExpectedRes) << ", got "
             << llvm::format("%u", Res) << "\n";
      return false;
    }
    return true;
  };

  std::vector<double> Scores;

  for (auto I : llvm::seq(NumIters)) {
    double Score = runIter(I + 1, IterLength, IterJob);
    Scores.push_back(Score);
    if (GotUnexpectedRes)
      return std::nullopt;
  }

  Deinit();
  double Avg =
      std::accumulate(Scores.begin(), Scores.end(), 0.0) / Scores.size();
  return Avg;
}
} // namespace tr
