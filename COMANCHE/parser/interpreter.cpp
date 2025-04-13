#include "interpreter.hpp"
#include "ast_prt.hpp"
#include <iostream>

void Interpreter::executeFunction(const FunctionDecl* fn) {
    for (const auto& stmt : fn->body) {
        executeStmt(stmt.get());
    }
}

void Interpreter::executeStmt(const Stmt* stmt) {
    if (auto print = dynamic_cast<const PrintStmt*>(stmt)) {
        std::cout << evaluateExpr(print->expr.get());
        if (print->newline) std::cout << std::endl;
    } else if (auto ret = dynamic_cast<const ReturnStmt*>(stmt)) {
        std::cout << evaluateExpr(ret->expr.get()) << std::endl;
    } else if (auto loop = dynamic_cast<const LoopStmt*>(stmt)) {
        while (true) {
            for (const auto& innerStmt : loop->body) {
                executeStmt(innerStmt.get());
            }
        }
    }
    
}

std::string Interpreter::evaluateExpr(const Expr* expr) {
    if (auto lit = dynamic_cast<const LiteralExpr*>(expr)) {
        return lit->value;
    }
    return "";
}
