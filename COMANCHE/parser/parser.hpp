#ifndef WYZER_PARSER_HPP
#define WYZER_PARSER_HPP

#include "../lexer/lexer.hpp"
#include <vector>
#include <memory>
#include <optional>


struct ASTNode {
    virtual ~ASTNode() = default;
};

struct Program : ASTNode {
    std::vector<std::shared_ptr<ASTNode>> declarations;
};


struct Expr : public ASTNode {};

struct LiteralExpr : public Expr {
    std::string value;
    explicit LiteralExpr(std::string val) : value(std::move(val)) {}
};

struct VariableExpr : public Expr {
    std::string name;
    explicit VariableExpr(std::string n) : name(std::move(n)) {}
};

struct BinaryExpr : public Expr {
    std::string op;
    std::unique_ptr<Expr> left;
    std::unique_ptr<Expr> right;

    BinaryExpr(std::string op, std::unique_ptr<Expr> left, std::unique_ptr<Expr> right)
        : op(std::move(op)), left(std::move(left)), right(std::move(right)) {}
};


class Stmt : public ASTNode {
    public:
        virtual ~Stmt() = default;
    };

struct PrintStmt : public Stmt {
    std::unique_ptr<Expr> expr;
    bool newline;

    PrintStmt(std::unique_ptr<Expr> expr, bool newline)
        : expr(std::move(expr)), newline(newline) {}
};

struct ReturnStmt : public Stmt {
    std::unique_ptr<Expr> expr;
    explicit ReturnStmt(std::unique_ptr<Expr> e) : expr(std::move(e)) {}
};

struct LoopStmt : public Stmt {
    std::vector<std::unique_ptr<Stmt>> body;
    explicit LoopStmt(std::vector<std::unique_ptr<Stmt>> b) : body(std::move(b)) {}
};

struct Param {
    std::string name;
    std::string type;
};

struct FunctionDecl : public ASTNode {
    std::string name;
    std::vector<Param> params;
    std::string returnType;
    std::vector<std::unique_ptr<Stmt>> body;
    int line;

    FunctionDecl(std::string n, std::vector<Param> p, std::string r, std::vector<std::unique_ptr<Stmt>> b)
        : name(std::move(n)), params(std::move(p)), returnType(std::move(r)), body(std::move(b)) {}
};


class Parser {
public:
    explicit Parser(std::vector<Token> toks);

    std::unique_ptr<FunctionDecl> parseFunction();
    std::shared_ptr<Program> parse();
    std::unique_ptr<Stmt> parseLoop();
    std::unique_ptr<Stmt> parseStatement();


private:
    Token peek() const;
    const Token& advance();
    Token get();
    bool match(TokenType type);
    bool match(TokenType type, const std::string& subType);
    void expect(TokenType type, const std::string& message);
    void expect(TokenType type, const std::string& subType, const std::string& message);

    std::unique_ptr<Expr> parseExpr();
    std::unique_ptr<Expr> parsePrimary();
    std::unique_ptr<Expr> parseBinaryRHS(int precedence, std::unique_ptr<Expr> lhs);
    std::unique_ptr<Expr> parseBinaryExpr(int minPrecedence);
    int getPrecedence(const Token& tok);
    std::shared_ptr<ASTNode> parseDeclaration();
    void checkForMain(const std::shared_ptr<Program>& program);

    std::vector<Token> tokens;
    size_t pos;
};

#endif // WYZER_PARSER_HPP