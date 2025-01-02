#ifndef OPTIMIZER_PASSES_CUSTOMPASS_H
#define OPTIMIZER_PASSES_CUSTOMPASS_H

#include <llvm/IR/PassManager.h>

namespace opt {
struct CustomPass : llvm::PassInfoMixin<CustomPass> {
  CustomPass() = default;

  llvm::PreservedAnalyses run(llvm::Function &F,
                              llvm::FunctionAnalysisManager &FAM);
};
} // namespace opt

#endif // OPTIMIZER_PASSES_CUSTOMPASS_H
