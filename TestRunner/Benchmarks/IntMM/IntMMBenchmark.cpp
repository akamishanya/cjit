#include "IntMMBenchmark.h"

#include <llvm/ADT/Sequence.h>
#include <math.h>
#include <numeric>
#include <optional>

using namespace llvm;

namespace tr {
static bool DoubleEq(double X, double Y, double Eps = 1e-9) {
  return fabs(X - Y) < Eps;
}

std::optional<double> IntMMBenchmark::run(unsigned NumIters,
                                          unsigned IterLength) {
  FunctionExecutor Exec(std::move(TheModule), std::move(Ctx), JIT);

  auto IntMM = Exec.lookupFunc<int()>("intmm");
  auto Init = Exec.lookupFunc<int(int)>("init");
  auto Deinit = Exec.lookupFunc<void()>("deinit");
  if (!Init(400)) {
    errs() << "Failed to init intmm benchmark\n";
    return std::nullopt;
  }

  int ExpectedRes = -19840;
  bool GotUnexpectedRes = false;

  auto IterJob = [&]() {
    int Res = IntMM();
    if (Res != ExpectedRes) {
      errs() << "Got unexpected result: expected "
             << llvm::format("%d", ExpectedRes) << ", got "
             << llvm::format("%d", Res) << "\n";
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
