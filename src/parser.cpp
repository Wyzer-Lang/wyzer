#include "include/parser.h"
#include "include/lexer.h"
#include <vector>
#include <memory>
#include <initializer_list>
#include <stdexcept>

BinaryExpr::BinaryExpr(std::unique_ptr<Expr> left, Token op, std::unique_ptr<Expr> right)
    : left(std::move(left)), op(op), right(std::move(right)) {}

LiteralExpr::LiteralExpr(Token token) : token(token) {}

VariableExpr::VariableExpr(Token name) : name(name) {}

VarStmt::VarStmt(Token name, std::unique_ptr<Expr> initializer)
    : name(name), initializer(std::move(initializer)) {}

PrintStmt::PrintStmt(std::unique_ptr<Expr> expression)
    : expression(std::move(expression)) {}

BlockStmt::BlockStmt(std::vector<std::unique_ptr<Stmt>> statements)
    : statements(std::move(statements)) {}

IfStmt::IfStmt(std::unique_ptr<Expr> condition, std::unique_ptr<Stmt> thenBranch, std::unique_ptr<Stmt> elseBranch)
    : condition(std::move(condition)), thenBranch(std::move(thenBranch)), elseBranch(std::move(elseBranch)) {}

Parser::Parser(std::vector<Token> tokens) : tokens(std::move(tokens)), current(0) {}

Token Parser::advance() {
    if (!isAtEnd()) current++;
    return previous();
}

Token Parser::peek() {
    return tokens[current];
}

Token Parser::previous() {
    return tokens[current - 1];
}

bool Parser::isAtEnd() {
    return peek().type == TokenType::EOF_TOK;
}

bool Parser::match(std::initializer_list<TokenType> types) {
    for (auto type : types) {
        if (peek().type == type) {
            advance();
            return true;
        }
    }
    return false;
}

Token Parser::consume(TokenType type, const std::string& message) {
    if (peek().type == type) return advance();
    throw std::runtime_error("Parse Error: " + message);
}

std::unique_ptr<Expr> Parser::parseExpression() {
    return parseEquality();
}

std::unique_ptr<Stmt> Parser::parsePrintStatement() {
    Token keyword = previous();
    std::unique_ptr<Expr> value = parseExpression();
    consume(TokenType::SEMICOLON, "Expect ';' after value.");
    return std::make_unique<PrintStmt>(std::move(value));
}

std::unique_ptr<Stmt> Parser::parseVarDeclaration() {
    Token name = consume(TokenType::IDENTIFIER, "Expect variable name.");

    std::unique_ptr<Expr> initializer = nullptr;
    if (match({TokenType::EQUAL})) {
        initializer = parseExpression();
    }

    consume(TokenType::SEMICOLON, "Expect ';' after variable declaration.");
    return std::make_unique<VarStmt>(name, std::move(initializer));
}

std::unique_ptr<Expr> Parser::parseEquality() {
    auto expr = parseComparison();

    while (match({TokenType::EQUAL_EQUAL, TokenType::BANG_EQUAL})) {
        Token op = previous();
        auto right = parseComparison();
        expr = std::make_unique<BinaryExpr>(std::move(expr), op, std::move(right));
    }

    return expr;
}

std::unique_ptr<Expr> Parser::parseComparison() {
    auto expr = parseTerm();

    while (match({TokenType::GREATER, TokenType::GREATER_EQUAL, TokenType::LESS, TokenType::LESS_EQUAL})) {
        Token op = previous();
        auto right = parseTerm();
        expr = std::make_unique<BinaryExpr>(std::move(expr), op, std::move(right));
    }

    return expr;
}

std::unique_ptr<Expr> Parser::parseTerm() {
    auto expr = parseFactor();

    while (match({TokenType::PLUS, TokenType::MINUS})) {
        Token op = previous();
        auto right = parseFactor();
        expr = std::make_unique<BinaryExpr>(std::move(expr), op, std::move(right));
    }

    return expr;
}

std::unique_ptr<Expr> Parser::parseFactor() {
    auto expr = parsePrimary();

    while (match({TokenType::STAR, TokenType::SLASH})) {
        Token op = previous();
        auto right = parsePrimary();
        expr = std::make_unique<BinaryExpr>(std::move(expr), op, std::move(right));
    }

    return expr;
}

std::unique_ptr<Expr> Parser::parsePrimary() {
    if (match({TokenType::NUMBER, TokenType::STRING, TokenType::CHAR})) {
        return std::make_unique<LiteralExpr>(previous());
    }
    if (match({TokenType::IDENTIFIER})) {
        return std::make_unique<VariableExpr>(previous());
    }
    throw std::runtime_error("Expected expression.");
}

std::unique_ptr<Stmt> Parser::parseStatement() {
    if (match({TokenType::PRINT})) return parsePrintStatement();
    if (match({TokenType::LET, TokenType::VAR, TokenType::CONST})) return parseVarDeclaration();
    if (match({TokenType::LEFT_BRACE})) return std::make_unique<BlockStmt>(parseBlock());
    if (match({TokenType::IF})) return parseIfStatement();
    throw std::runtime_error("Unknown statement.");
}

std::unique_ptr<Stmt> Parser::parseIfStatement() {
    consume(TokenType::LEFT_PAREN, "Expected '(' after 'if'.");
    auto condition = parseExpression();
    consume(TokenType::RIGHT_PAREN, "Expected ')' after condition.");

    auto thenBranch = parseStatement();
    std::unique_ptr<Stmt> elseBranch = nullptr;
    if (match({TokenType::ELSE})) {
        elseBranch = parseStatement();
    }
    return std::make_unique<IfStmt>(std::move(condition), std::move(thenBranch), std::move(elseBranch));
}

std::vector<std::unique_ptr<Stmt>> Parser::parseBlock() {
    std::vector<std::unique_ptr<Stmt>> statements;
    while (!isAtEnd() && !match({TokenType::RIGHT_BRACE})) {
        statements.push_back(parseStatement());
    }
    return statements;
}

std::vector<std::unique_ptr<Stmt>> Parser::parse() {
    std::vector<std::unique_ptr<Stmt>> statements;
    while (!isAtEnd()) {
        statements.push_back(parseStatement());
    }
    return statements;
}
