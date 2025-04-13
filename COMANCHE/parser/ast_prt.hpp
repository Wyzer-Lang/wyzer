#ifndef WYZER_AST_PRINTER_HPP
#define WYZER_AST_PRINTER_HPP

#include "parser.hpp"

void printFunction(const std::unique_ptr<FunctionDecl>& fn, int indent = 0);

class VarDeclStmt : public Stmt {
public:
    std::string name;
    std::unique_ptr<Expr> initializer;

    VarDeclStmt(std::string name, std::unique_ptr<Expr> initializer)
        : name(std::move(name)), initializer(std::move(initializer)) {}
};
void printAST(const std::shared_ptr<Program>& program);


#endif // WYZER_AST_PRINTER_HPP

