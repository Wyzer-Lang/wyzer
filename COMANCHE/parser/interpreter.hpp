#pragma once
#include "ast_prt.hpp"
#include <string>

class Interpreter {
    public:
        void executeFunction(const FunctionDecl* fn);
    private:
        void executeStmt(const Stmt* stmt);
        std::string evaluateExpr(const Expr* expr);
    };