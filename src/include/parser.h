#ifndef PARSER_H
#define PARSER_H

#include <vector>
#include <memory>
#include "lexer.h"

class Expr;
class BinaryExpr;
class LiteralExpr;
class VariableExpr;
class Stmt;
class BlockStmt;
class IfStmt;
class PrintStmt;
class VarStmt;

class Visitor {
public:
    virtual void visitBinaryExpr(BinaryExpr& expr) = 0;
    virtual void visitLiteralExpr(LiteralExpr& expr) = 0;
    virtual void visitVariableExpr(VariableExpr& expr) = 0;

    virtual void visitBlockStmt(BlockStmt& stmt) = 0;
    virtual void visitIfStmt(IfStmt& stmt) = 0;
    virtual void visitPrintStmt(PrintStmt& stmt) = 0;
    virtual void visitVarStmt(VarStmt& stmt) = 0;

    virtual ~Visitor() = default;
};

class Expr {
public:
    virtual void accept(Visitor& visitor) = 0;
    virtual ~Expr() = default;
};

class Stmt {
public:
    virtual void accept(Visitor& visitor) = 0;
    virtual ~Stmt() = default;
};

class BinaryExpr : public Expr {
public:
    std::unique_ptr<Expr> left;
    Token op;
    std::unique_ptr<Expr> right;

    BinaryExpr(std::unique_ptr<Expr> left, Token op, std::unique_ptr<Expr> right);
    void accept(Visitor& visitor) override { visitor.visitBinaryExpr(*this); }
};

class LiteralExpr : public Expr {
public:
    Token token;

    LiteralExpr(Token token);
    void accept(Visitor& visitor) override { visitor.visitLiteralExpr(*this); }
};

class VariableExpr : public Expr {
public:
    Token name;

    VariableExpr(Token name);
    void accept(Visitor& visitor) override { visitor.visitVariableExpr(*this); }
};

class BlockStmt : public Stmt {
public:
    std::vector<std::unique_ptr<Stmt>> statements;

    BlockStmt(std::vector<std::unique_ptr<Stmt>> statements);
    void accept(Visitor& visitor) override { visitor.visitBlockStmt(*this); }
};

class IfStmt : public Stmt {
public:
    std::unique_ptr<Expr> condition;
    std::unique_ptr<Stmt> thenBranch;
    std::unique_ptr<Stmt> elseBranch;

    IfStmt(std::unique_ptr<Expr> condition, std::unique_ptr<Stmt> thenBranch, std::unique_ptr<Stmt> elseBranch);
    void accept(Visitor& visitor) override { visitor.visitIfStmt(*this); }
};

class VarStmt : public Stmt {
public:
    Token name;
    std::unique_ptr<Expr> initializer;

    VarStmt(Token name, std::unique_ptr<Expr> initializer);
    void accept(Visitor& visitor) override { visitor.visitVarStmt(*this); }
};

class PrintStmt : public Stmt {
public:
    std::unique_ptr<Expr> expression;

    PrintStmt(std::unique_ptr<Expr> expression);
    void accept(Visitor& visitor) override { visitor.visitPrintStmt(*this); }
};

class Parser {
private:
    std::vector<Token> tokens;
    int current;

    Token advance();
    Token peek();
    Token previous();
    bool isAtEnd();
    bool match(std::initializer_list<TokenType> types);
    Token consume(TokenType type, const std::string& message);

    std::unique_ptr<Expr> parseExpression();
    std::unique_ptr<Expr> parseEquality();
    std::unique_ptr<Expr> parseComparison();
    std::unique_ptr<Expr> parseTerm();
    std::unique_ptr<Expr> parseFactor();
    std::unique_ptr<Expr> parsePrimary();
    std::unique_ptr<Stmt> parseStatement();
    std::unique_ptr<Stmt> parsePrintStatement();
    std::unique_ptr<Stmt> parseVarDeclaration();
    std::unique_ptr<Stmt> parseIfStatement();
    std::vector<std::unique_ptr<Stmt>> parseBlock();

public:
    explicit Parser(std::vector<Token> tokens);
    std::vector<std::unique_ptr<Stmt>> parse();
};

#endif // PARSER_H
