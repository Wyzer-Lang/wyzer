#include "parser.hpp"
#include <stdexcept>
#include <iostream>

Parser::Parser(std::vector<Token> toks) : tokens(std::move(toks)), pos(0) {}

Token Parser::peek() const {
    if (pos < tokens.size()) return tokens[pos];
    return Token{TokenType::END_OF_FILE, "", "", -1};
}

const Token& Parser::advance() {
    if (pos < tokens.size()) return tokens[pos++];
    return tokens.back();
}

Token Parser::get() {
    return peek();
}

bool Parser::match(TokenType type) {
    if (peek().type == type) {
        advance();
        return true;
    }
    return false;
}

bool Parser::match(TokenType type, const std::string& subType) {
    const Token& tok = peek();
    if (tok.type == type && tok.subType == subType) {
        advance();
        return true;
    }
    return false;
}

void Parser::expect(TokenType type, const std::string& message) {
    if (!match(type)) {
        throw std::runtime_error("Expected " + message + " at line " + std::to_string(peek().line));
    }
}

void Parser::expect(TokenType type, const std::string& subType, const std::string& message) {
    const Token& tok = peek();
    if (tok.type != type || tok.subType != subType) {
        throw std::runtime_error("Expected " + message + " at line " + std::to_string(tok.line));
    }
    advance();
}

std::unique_ptr<FunctionDecl> Parser::parseFunction() {
    const Token& funcTok = advance();
    expect(TokenType::IDENTIFIER, "function name");

    std::string funcName = tokens[pos - 1].value;

    expect(TokenType::LPAREN, "opening parenthesis '('");

    std::vector<Param> params;
    while (!match(TokenType::RPAREN)) {
        const Token& nameTok = peek();
        if (nameTok.type != TokenType::IDENTIFIER) {
            throw std::runtime_error("Expected parameter name (identifier) at line " + std::to_string(nameTok.line) + ", got '" + nameTok.value + "'");
        }
        advance();
        std::string paramName = nameTok.value;
    
        expect(TokenType::COLON, "colon ':' after parameter name");
    
        const Token& typeTok = peek();
        if (typeTok.type != TokenType::IDENTIFIER && typeTok.type != TokenType::KEYWORD) {
            throw std::runtime_error("Expected parameter type at line " + std::to_string(typeTok.line) + ", got '" + typeTok.value + "'");
        }
        advance();
        std::string paramType = typeTok.value;
    
        params.push_back({paramName, paramType});
    
        if (!match(TokenType::COMMA)) {
            expect(TokenType::RPAREN, "closing parenthesis ')' after parameters");
            break;
        }
    }

    std::string returnType = "void";

    if (match(TokenType::ARROW)) {
        if (peek().type != TokenType::IDENTIFIER && peek().type != TokenType::KEYWORD) {
            throw std::runtime_error("Expected return type after '->' at line " + std::to_string(peek().line));
        }
        advance();
        returnType = tokens[pos - 1].value;
    }

    expect(TokenType::LBRACE, "function body '{'");

    std::vector<std::unique_ptr<Stmt>> body;
    while (!match(TokenType::RBRACE)) {
        body.push_back(parseStatement());
    }

    return std::make_unique<FunctionDecl>(funcName, params, returnType, std::move(body));
}

void Parser::consume(TokenType type, const std::string& errorMessage) {
    if (!match(type)) {
        throw std::runtime_error(errorMessage);
    }
}

std::unique_ptr<Stmt> Parser::parseVariableDecl() {
    //expect(TokenType::KEYWORD, "let");

    
    const Token& varNameTok = peek();
    if (varNameTok.type != TokenType::IDENTIFIER) {
        throw std::runtime_error("Expected variable name after 'let' at line " + std::to_string(varNameTok.line));
    }
    std::string varName = varNameTok.value;
    advance();
    expect(TokenType::ASSIGN, "Expected '=' after variable name");
    auto expr = parseExpr();
    expect(TokenType::SEMICOLON, "Expected semicolon ';' after variable declaration");

    return std::make_unique<VariableDeclStmt>(varName, std::move(expr));
}

std::unique_ptr<Stmt> Parser::parseStatement() {
    if (match(TokenType::KEYWORD, "return")) {
        auto expr = parseExpr();
        expect(TokenType::SEMICOLON, "semicolon ';' after return statement");
        return std::make_unique<ReturnStmt>(std::move(expr));
    } else if (peek().type == TokenType::KEYWORD && (peek().value == "log" || peek().value == "logln")) {
        bool newline = peek().value == "logln";
        advance();

        expect(TokenType::LPAREN, "opening '(' after log/logln");
        auto expr = parseExpr();
        expect(TokenType::RPAREN, "closing ')' after log/logln argument");
        expect(TokenType::SEMICOLON, "semicolon ';' after log/logln");

        return std::make_unique<PrintStmt>(std::move(expr), newline);
    } else if (peek().type == TokenType::KEYWORD && peek().value == "loop") {
        return parseLoop();
    } else if (match(TokenType::KEYWORD, "let")) {
        return parseVariableDecl();
    } else if (peek().type == TokenType::IF) {
        return parseIfStmt();
    }

    throw std::runtime_error("Unexpected token '" + peek().value + "' at line " + std::to_string(peek().line));
}

std::unique_ptr<Expr> Parser::parseBinaryExpr(int minPrecedence) {
    auto left = parsePrimary();

    while (true) {
        Token op = peek();
        int precedence = getPrecedence(op);

        if (precedence < minPrecedence) break;

        advance();

        Token next = peek();
        if (next.type == TokenType::SEMICOLON || next.type == TokenType::RBRACE || next.type == TokenType::END_OF_FILE) break;

        auto right = parseBinaryExpr(precedence + 1);
        left = std::make_unique<BinaryExpr>(op.value, std::move(left), std::move(right));

    }

    return left;
}

std::unique_ptr<Expr> Parser::parsePrimary() {
    const Token& tok = peek();
    
    if (tok.type == TokenType::NUMBER_LITERAL) {
        advance();
        return std::make_unique<LiteralExpr>(std::to_string(std::stoi(tok.value)));

    }

    if (tok.type == TokenType::STRING_LITERAL) {
        advance();
        return std::make_unique<LiteralExpr>(tok.value);
    }

    throw std::runtime_error("Unexpected primary expression at line " + std::to_string(tok.line));
}

std::shared_ptr<Program> Parser::parse() {
    auto program = std::make_shared<Program>();
    
    while (peek().type != TokenType::END_OF_FILE) {
        if (peek().type == TokenType::KEYWORD && peek().value == "function") {
            program->declarations.push_back(parseFunction());
        }
        else {
            parseStatement();
        }
    }

    checkForMain(program);

    return program;
}

void Parser::checkForMain(const std::shared_ptr<Program>& program) {
    for (const auto& decl : program->declarations) {
        if (auto funcDecl = std::dynamic_pointer_cast<FunctionDecl>(decl)) {
            if (funcDecl->name == "main") {
                return;
            }
        }
    }
    std::cerr << "Error: No main function found." << std::endl;
}



