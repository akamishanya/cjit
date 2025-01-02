#include "SinkBenchmark.h"

#include <llvm/ADT/Sequence.h>

#include <math.h>
#include <random>

using namespace llvm;

namespace tr {
static std::vector<int> generateInput(unsigned Size) {
  static std::random_device RD;
  std::mt19937 Gen(RD());
  std::uniform_int_distribution<> Distr;

  std::vector<int> Input;
  Input.reserve(Size);
  for (auto I : llvm::seq(Size))
    Input.push_back(Distr(Gen));
  return Input;
}

static double expectedResult(const llvm::ArrayRef<int> Input) {
  double Res = 0;
  for (int i = 0; i < Input.size(); i++) {
    double PartialRes = sin(Input[i]) * cos(Input[i]);
    if (Input[i] < 0)
      Res += PartialRes;
    Res += Input[i];
  }
  return Res;
}

static bool DoubleEq(double X, double Y, double Eps = 1e-9) {
  return fabs(X - Y) < Eps;
}

std::optional<double> SinkBenchmark::run(unsigned NumIters,
                                         unsigned IterLength) {
  FunctionExecutor Exec(std::move(TheModule), std::move(Ctx), JIT);

  auto Test = Exec.lookupFunc<double(int *, unsigned)>("test");

  std::vector<int> Input = generateInput(10000);
  double ExpectedRes = expectedResult(Input);
  bool GotUnexpectedRes = false;

  auto IterJob = [&]() {
    double Res = Test(Input.data(), Input.size());
    if (!DoubleEq(Res, ExpectedRes)) {
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
