#include "ast_prt.hpp"
#include <iostream>

void printIndent(int indent) {
    for (int i = 0; i < indent; ++i) std::cout << "  ";
}

void printExpr(const std::unique_ptr<Expr>& expr, int indent) {
    if (auto lit = dynamic_cast<LiteralExpr*>(expr.get())) {
        printIndent(indent);
        std::cout << "Literal: \"" << lit->value << "\"\n";
    } else if (auto var = dynamic_cast<VariableExpr*>(expr.get())) {
        printIndent(indent);
        std::cout << "Variable: " << var->name << "\n";
    } else if (auto bin = dynamic_cast<BinaryExpr*>(expr.get())) {
        printIndent(indent);
        std::cout << "BinaryExpr\n";
        printExpr(bin->left, indent + 1);
        printIndent(indent + 1);
        std::cout << "Operator: " << bin->op << "\n";
        printExpr(bin->right, indent + 1);
    }
}

void printStmt(const std::unique_ptr<Stmt>& stmt, int indent) {
    if (auto ret = dynamic_cast<ReturnStmt*>(stmt.get())) {
        printIndent(indent);
        std::cout << "Return\n";
        printExpr(ret->expr, indent + 1);
    } else if (auto print = dynamic_cast<PrintStmt*>(stmt.get())) {
        printIndent(indent);
        std::cout << (print->newline ? "Println" : "Print") << "\n";
        printExpr(print->expr, indent + 1);
    }else if (auto loop = dynamic_cast<LoopStmt*>(stmt.get())) {
        printIndent(indent);
        std::cout << "Loop\n";
        for (const auto& s : loop->body) {
            printStmt(s, indent + 1);
        }
    }
     
    else {
        printIndent(indent);
        std::cout << "Unknown Statement\n";
    }
    
}


void printFunction(const FunctionDecl* fn) {
    std::cout << "Function " << fn->name << "(";
    for (size_t i = 0; i < fn->params.size(); ++i) {
        std::cout << fn->params[i].name << ": " << fn->params[i].type;
        if (i < fn->params.size() - 1) std::cout << ", ";
    }
    std::cout << ") -> " << fn->returnType << "\n";

    for (const auto& stmt : fn->body) {
        printStmt(stmt, 2);

    }
}



void printAST(const std::shared_ptr<Program>& program) {
    for (const auto& decl : program->declarations) {
        if (auto fn = dynamic_cast<FunctionDecl*>(decl.get())) {
            printFunction(fn);
        }
    }
}
