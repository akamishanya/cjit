#include "FloatMMBenchmark.h"

#include <llvm/ADT/Sequence.h>
#include <math.h>
#include <numeric>

using namespace llvm;

namespace tr {
static bool DoubleEq(double X, double Y, double Eps = 1e-9) {
  return fabs(X - Y) < Eps;
}

std::optional<double> FloatMMBenchmark::run(unsigned NumIters,
                                            unsigned IterLength) {
  FunctionExecutor Exec(std::move(TheModule), std::move(Ctx), JIT);

  auto FloatMM = Exec.lookupFunc<double()>("floatmm");
  auto Init = Exec.lookupFunc<int(int)>("init");
  auto Deinit = Exec.lookupFunc<void()>("deinit");
  if (!Init(120)) {
    errs() << "Failed to init floatmm benchmark\n";
    return std::nullopt;
  }

  double ExpectedRes = 2142.222222222;
  bool GotUnexpectedRes = false;

  auto IterJob = [&]() {
    double Res = FloatMM();
    if (!DoubleEq(Res, ExpectedRes, 1e-9)) {
      errs() << "Got unexpected result: expected "
             << llvm::format("%.9lf", ExpectedRes) << ", got "
             << llvm::format("%.9lf", Res) << "\n";
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
