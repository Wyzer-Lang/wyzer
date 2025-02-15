#ifndef LLVM_CODEGEN_H
#define LLVM_CODEGEN_H

#include "parser.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include <map>

class LLVMCodeGen : public Visitor {
public:
void visitBlockStmt(BlockStmt& stmt) override {}
void visitIfStmt(IfStmt& stmt) override {}
    llvm::LLVMContext context;
    llvm::Module module;
    llvm::IRBuilder<> builder;
    std::map<std::string, llvm::Value*> namedValues;

    LLVMCodeGen() : module("MyModule", context), builder(context) {}

    void generate(std::vector<std::unique_ptr<Stmt>>& statements);

    void visitBinaryExpr(BinaryExpr& expr) override;
    void visitLiteralExpr(LiteralExpr& expr) override;
    void visitVariableExpr(VariableExpr& expr) override;
    void visitVarStmt(VarStmt& stmt) override;
    void visitPrintStmt(PrintStmt& stmt) override;
};

#endif // LLVM_CODEGEN_H