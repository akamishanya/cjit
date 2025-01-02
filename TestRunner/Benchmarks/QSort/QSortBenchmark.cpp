#include "QSortBenchmark.h"

#include <llvm/ADT/Sequence.h>
#include <math.h>
#include <numeric>

using namespace llvm;

namespace tr {
static bool DoubleEq(double X, double Y, double Eps = 1e-9) {
  return fabs(X - Y) < Eps;
}

std::optional<double> QSortBenchmark::run(unsigned NumIters,
                                          unsigned IterLength) {
  FunctionExecutor Exec(std::move(TheModule), std::move(Ctx), JIT);

  auto QSort = Exec.lookupFunc<int()>("Quick");

  int ExpectedRes = 15527;
  bool GotUnexpectedRes = false;

  auto IterJob = [&]() {
    int Res = QSort();
    if (Res != ExpectedRes) {
      errs() << "Got unexpected result: expected " << ExpectedRes << ", got "
             << Res << "\n";
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

  double Avg =
      std::accumulate(Scores.begin(), Scores.end(), 0.0) / Scores.size();
  return Avg;
}
} // namespace tr
