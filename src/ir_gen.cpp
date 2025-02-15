#include "include/ir_gen.h"
#include <iostream>

void LLVMCodeGen::generate(std::vector<std::unique_ptr<Stmt>>& statements) {
    for (auto& stmt : statements) {
        stmt->accept(*this);
    }
}

void LLVMCodeGen::visitBinaryExpr(BinaryExpr& expr) {
    expr.left->accept(*this);
    llvm::Value* leftVal = namedValues["tmp"];
    
    expr.right->accept(*this);
    llvm::Value* rightVal = namedValues["tmp"];
    
    llvm::Value* result = nullptr;
    if (expr.op.type == TokenType::PLUS) {
        result = builder.CreateFAdd(leftVal, rightVal, "addtmp");
    } else if (expr.op.type == TokenType::MINUS) {
        result = builder.CreateFSub(leftVal, rightVal, "subtmp");
    }
    namedValues["tmp"] = result;
}

void LLVMCodeGen::visitLiteralExpr(LiteralExpr& expr) {
    namedValues["tmp"] = llvm::ConstantFP::get(context, llvm::APFloat(std::stod(expr.token.lexeme)));
}

void LLVMCodeGen::visitVariableExpr(VariableExpr& expr) {
    namedValues["tmp"] = namedValues[expr.name.lexeme];
}

void LLVMCodeGen::visitVarStmt(VarStmt& stmt) {
    stmt.initializer->accept(*this);
    llvm::Value* initVal = namedValues["tmp"];
    namedValues[stmt.name.lexeme] = initVal;
}

void LLVMCodeGen::visitPrintStmt(PrintStmt& stmt) {
    stmt.expression->accept(*this);
    llvm::Value* value = namedValues["tmp"];
    
    llvm::Function* printfFunc = module.getFunction("printf");
    if (!printfFunc) {
        llvm::FunctionType* printfType = llvm::FunctionType::get(builder.getInt32Ty(), true);
        printfFunc = llvm::Function::Create(printfType, llvm::Function::ExternalLinkage, "printf", module);
    }
    
    llvm::Value* formatStr = builder.CreateGlobalStringPtr("%f\n");
    builder.CreateCall(printfFunc, {formatStr, value});
}
