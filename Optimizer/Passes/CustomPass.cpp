#include "CustomPass.h"
#include <llvm/IR/PassManager.h>
#include <llvm/IR/Function.h>

using namespace llvm;
using namespace opt;

PreservedAnalyses CustomPass::run(Function &F, FunctionAnalysisManager &FAM) {
  return PreservedAnalyses::all();
}
