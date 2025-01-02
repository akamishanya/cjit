#include "BenchRunner.h"
#include <chrono>

using namespace llvm;
using namespace tr;

double BenchRunner::runIter(unsigned IterNum, unsigned Duration,
                            llvm::function_ref<bool()> IterJob) {
  outs() << "Iteration #" << IterNum << ": ";
  using ClockTy = std::chrono::high_resolution_clock;
  auto TimeLimit = std::chrono::seconds(Duration);
  auto TimeLimitS =
      std::chrono::duration_cast<std::chrono::seconds>(TimeLimit).count();

  std::size_t NumTimesCalled = 0;
  auto Start = ClockTy::now();

  while (true) {
    if (!IterJob())
      break;
    NumTimesCalled++;
    if (ClockTy::now() - Start >= TimeLimit)
      break;
  }

  auto ElapsedTime = ClockTy::now() - Start;
  auto ElapsedTimeMS =
      std::chrono::duration_cast<std::chrono::milliseconds>(ElapsedTime)
          .count();
  double Score = static_cast<double>(NumTimesCalled) * 1000 / ElapsedTimeMS;
  outs() << format("%15.1lf", Score) << " ops/s\n";
  return Score;
}
