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
        const Token& retTypeTok = peek();
        if (retTypeTok.type != TokenType::IDENTIFIER && retTypeTok.type != TokenType::KEYWORD) {
            throw std::runtime_error("Expected return type after '->' at line " + std::to_string(retTypeTok.line));
        }
        advance();
        returnType = retTypeTok.value;
    }

    expect(TokenType::LBRACE, "function body '{'");

    std::vector<std::unique_ptr<Stmt>> body;
    while (!match(TokenType::RBRACE)) {
        if (peek().type == TokenType::END_OF_FILE) {
            throw std::runtime_error("Unclosed function body (missing '}') starting at line " + std::to_string(funcTok.line));
        }
        body.push_back(parseStatement());
    }

    return std::make_unique<FunctionDecl>(funcName, params, returnType, std::move(body));
}

void Parser::consume(TokenType type, const std::string& errorMessage) {
    if (!match(type)) {
        throw std::runtime_error(errorMessage);
    }
}


void Parser::consumeWithValue(TokenType type, const std::string& value, const std::string& errorMessage) {
    if (peek().type == type && peek().value == value) {
        advance();
    } else {
        throw std::runtime_error("Expected " + errorMessage + " at line " + std::to_string(peek().line));
    }
}


std::unique_ptr<Stmt> Parser::parseVariableDecl() {
    const Token& varNameTok = peek();
    if (varNameTok.type != TokenType::IDENTIFIER) {
        throw std::runtime_error("Expected variable name after 'let' at line " + std::to_string(varNameTok.line));
    }
    std::string varName = varNameTok.value;
    advance();

    std::string varType = "auto";
    if (match(TokenType::COLON)) {
        const Token& typeTok = peek();
        if (typeTok.type != TokenType::IDENTIFIER && typeTok.type != TokenType::KEYWORD) {
            throw std::runtime_error("Expected type after ':' at line " + std::to_string(typeTok.line));
        }
        advance();
        varType = typeTok.value;
    }

    if (peek().value != "=") {
        throw std::runtime_error("Expected '=' after variable name at line " + std::to_string(peek().line));
    }
    advance();
    
    auto expr = parseExpr();
    expect(TokenType::SEMICOLON, "Expected semicolon ';' after variable declaration");

    return std::make_unique<VariableDeclStmt>(varName, varType, std::move(expr));

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
        return std::make_unique<LiteralExpr>(tok.value);
    }

    if (tok.type == TokenType::STRING_LITERAL) {
        advance();
        return std::make_unique<LiteralExpr>(tok.value);
    }

    if (tok.type == TokenType::IDENTIFIER) {
        advance();
        return std::make_unique<VariableExpr>(tok.value);
    }

    throw std::runtime_error("Unexpected primary expression at line " + std::to_string(tok.line));
}

std::shared_ptr<Program> Parser::parse() {
    auto program = std::make_shared<Program>();

    while (pos < tokens.size()) {
        if (peek().value == "fnc") {
            program->declarations.push_back(parseFunction());
        } else {
            std::cerr << "Parser error: Unexpected token '" << peek().value << "' at line " << peek().line << std::endl;
            throw std::runtime_error("Parser error");
        }
    }

    checkForMain(program);
    return program;
}


void Parser::checkForMain(const std::shared_ptr<Program>& program) {
    bool foundMain = false;
    for (const auto& decl : program->declarations) {
        if (auto funcDecl = std::dynamic_pointer_cast<FunctionDecl>(decl)) {
            if (funcDecl->name == "main") {
                foundMain = true;
                break;
            }
        }
    }
    if (!foundMain) {
        throw std::runtime_error("Where is the programming starting from? No 'main' function found.");
    }
}


std::unique_ptr<Expr> Parser::parseExpr() {
    return parseBinaryExpr(0);
}

std::unique_ptr<Stmt> Parser::parseLoop() {
    const Token& loopTok = advance(); 

    expect(TokenType::LBRACE, "opening brace '{' after loop");

    std::vector<std::unique_ptr<Stmt>> body;
    while (!match(TokenType::RBRACE)) {
        if (peek().type == TokenType::END_OF_FILE) {
            throw std::runtime_error("Unclosed loop block at line " + std::to_string(loopTok.line));
        }
        body.push_back(parseStatement());
    }

    return std::make_unique<LoopStmt>(std::move(body));
}


std::unique_ptr<Stmt> Parser::parseIfStmt() {
    const Token& ifTok = advance();
    
    expect(TokenType::LPAREN, "'(' after 'if'");
    auto cond = parseExpr(); 
    expect(TokenType::RPAREN, "')' after condition");
    
    expect(TokenType::LBRACE, "'{' after condition block"); 
    std::vector<std::unique_ptr<Stmt>> trueBranch;
    while (!match(TokenType::RBRACE)) {
        if (peek().type == TokenType::END_OF_FILE) {
            throw std::runtime_error("Unclosed 'if' block at line " + std::to_string(ifTok.line));
        }
        trueBranch.push_back(parseStatement());
    }

    std::vector<std::unique_ptr<Stmt>> falseBranch;
    if (match(TokenType::KEYWORD, "else")) {
        expect(TokenType::LBRACE, "'{' after 'else'");

        while (!match(TokenType::RBRACE)) {
            if (peek().type == TokenType::END_OF_FILE) {
                throw std::runtime_error("Unclosed 'else' block at line " + std::to_string(ifTok.line));
            }
            falseBranch.push_back(parseStatement());
        }
    }

    return std::make_unique<IfStmt>(std::move(cond), std::move(trueBranch), std::move(falseBranch));
}


int Parser::getPrecedence(const Token& token) {
    if (token.value == "+" || token.value == "-") return 1;
    if (token.value == "*" || token.value == "/") return 2;
    return -1;
}
