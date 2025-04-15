#ifndef WYZER_PARSER_HPP
#define WYZER_PARSER_HPP

#include "../lexer/lexer.hpp"
#include <vector>
#include <memory>
#include <optional>
#include <iostream>

struct ASTNode {
    virtual ~ASTNode() = default;
};
struct Program : ASTNode {
    std::vector<std::shared_ptr<ASTNode>> declarations;
};

class Stmt : public ASTNode {
public:
    virtual ~Stmt() = default;
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

struct BinaryExpr : Expr {
    std::string op;
    std::unique_ptr<Expr> left;
    std::unique_ptr<Expr> right;

    BinaryExpr(std::string op, std::unique_ptr<Expr> left, std::unique_ptr<Expr> right)
        : op(std::move(op)), left(std::move(left)), right(std::move(right)) {}
};


struct LoopStmt : public Stmt {
    std::vector<std::unique_ptr<Stmt>> body;
    explicit LoopStmt(std::vector<std::unique_ptr<Stmt>> b) : body(std::move(b)) {}
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

struct IfStmt : Stmt {
    std::unique_ptr<Expr> condition;
    std::vector<std::unique_ptr<Stmt>> thenBranch;
    std::vector<std::unique_ptr<Stmt>> elseBranch;

    IfStmt(std::unique_ptr<Expr> cond,
           std::vector<std::unique_ptr<Stmt>> thenB,
           std::vector<std::unique_ptr<Stmt>> elseB)
        : condition(std::move(cond)), thenBranch(std::move(thenB)), elseBranch(std::move(elseB)) {}
};

struct VariableDeclStmt : Stmt {
    std::string name;
    std::string type;
    std::unique_ptr<Expr> initializer;

    VariableDeclStmt(std::string n, std::string t, std::unique_ptr<Expr> init)
        : name(std::move(n)), type(std::move(t)), initializer(std::move(init)) {}
};



class Parser {
    public:
        explicit Parser(std::vector<Token> toks);
        std::unique_ptr<FunctionDecl> parseFunction();
        std::unique_ptr<Stmt> parseStatement();
        std::shared_ptr<Program> parse();
        
        std::unique_ptr<Expr> parseExpr();
        std::vector<std::unique_ptr<Stmt>> parseBlock();
        std::unique_ptr<Stmt> parseVariableDecl();
        
        void consumeWithValue(TokenType type, const std::string& value, const std::string& errorMessage);

    
    private:
        std::vector<Token> tokens;
        size_t pos;
    
        Token peek() const;
        const Token& advance();
        Token get();
        bool match(TokenType type);
        bool match(TokenType type, const std::string& subType);
        void expect(TokenType type, const std::string& message);
        void expect(TokenType type, const std::string& subType, const std::string& message);
        std::unique_ptr<Expr> parseBinaryExpr(int minPrecedence);
        std::unique_ptr<Expr> parsePrimary();
        int getPrecedence(const Token& tok);
        std::unique_ptr<Stmt> parseIfStmt();
        void consume(TokenType type, const std::string& errorMessage);

        std::unique_ptr<Stmt> parseLoop();
        void checkForMain(const std::shared_ptr<Program>& program);
    };
    

#endif // WYZER_PARSER_HPP