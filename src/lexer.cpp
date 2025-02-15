#include "include/lexer.h"
#include <iostream>
#include <cctype>

Lexer::Lexer(const std::string& source) : source(source) {}

bool Lexer::isAtEnd() { 
    return current >= source.length(); 
}

char Lexer::advance() { 
    return source[current++]; 
}

char Lexer::peek() { 
    if (isAtEnd())
  return '\0';
else
  return source[current];


}

char Lexer::peekNext() { 
    return (current + 1 < source.length()) ? source[current + 1] : '\0'; 
}

void Lexer::addToken(TokenType type, std::string lexeme) { 
    tokens.push_back({type, lexeme, line}); 
}

void Lexer::scanToken() {
    char c = peek();
    switch (c) {
        case '(': addToken(TokenType::LEFT_PAREN, "("); break;
        case ')': addToken(TokenType::RIGHT_PAREN, ")"); break;
        case '{': addToken(TokenType::LEFT_BRACE, "{"); break;
        case '}': addToken(TokenType::RIGHT_BRACE, "}"); break;
        case '[': addToken(TokenType::LEFT_BRACKET, "["); break;
        case ']': addToken(TokenType::RIGHT_BRACKET, "]"); break;
        case '+': addToken(TokenType::PLUS, "+"); break;
        case '-': addToken(TokenType::MINUS, "-"); break;
        case '*': addToken(TokenType::STAR, "*"); break;
        case '/':
            if (peek() == '/') {
                while (peek() != '\n' && !isAtEnd()) advance();
            } else if (peek() == '*') {
                advance();
                while (!(peek() == '*' && peekNext() == '/') && !isAtEnd()) {
                    if (peek() == '\n') line++;
                    advance();
                }
                if (!isAtEnd()) { advance(); advance(); }
            } else {
                addToken(TokenType::SLASH, "/");
            }
            break;
        case '=':
            addToken(peek() == '=' ? (advance(), TokenType::EQUAL) : TokenType::ASSIGN, "=");
            break;
        case '!':
            addToken(peek() == '=' ? (advance(), TokenType::NOT_EQUAL) : TokenType::NOT, "!");
            break;
        case '>':
            addToken(peek() == '=' ? (advance(), TokenType::GREATER_EQUAL) : TokenType::GREATER, ">");
            break;
        case '<':
            addToken(peek() == '=' ? (advance(), TokenType::LESS_EQUAL) : TokenType::LESS, "<");
            break;
        case '&':
            addToken(peek() == '&' ? (advance(), TokenType::AND) : TokenType::BIT_AND, "&");
            break;
        case '|':
            addToken(peek() == '|' ? (advance(), TokenType::OR) : TokenType::BIT_OR, "|");
            break;
        case ';': addToken(TokenType::SEMICOLON, ";"); break;
        case ':': addToken(TokenType::COLON, ":"); break;
        case '"': scanString(); break;
        case '\'': scanChar(); break;
        default:
            if (isdigit(c)) {
                scanNumber();
            } else if (isalpha(c) || c == '_') {
                scanIdentifier();
            }
            break;
    }
    advance();
}

void Lexer::scanString() {
    std::string value;
    while (peek() != '"' && !isAtEnd()) {
        if (peek() == '\n') line++;
        value += advance();
    }

    if (isAtEnd()) {
        std::cerr << "Unterminated string.\n";
        return;
    }

    advance();
    addToken(TokenType::STRING, value);
}


void Lexer::scanChar() {
    char value = advance();
    if (peek() != '\'') return;
    advance();
    addToken(TokenType::CHAR, std::string(1, value));
}

void Lexer::scanNumber() {
    std::string value;
    while (isdigit(peek())) value += advance();
    addToken(TokenType::NUMBER, value);
}

void Lexer::scanIdentifier() {
    std::string value;
    while (isalnum(peek()) || peek() == '_') value += advance();
    if (keywords.find(value) != keywords.end()) { 
        addToken(keywords[value], value);
    } else {
        addToken(TokenType::IDENTIFIER, value);
    }
}


std::vector<Token> Lexer::scanTokens() {
    while (!isAtEnd()) {
        start = current;
        scanToken();
    }
    tokens.push_back({TokenType::EOF_TOK, "", line});
    std::cout << "Tokens:\n";
    for (const auto& token : tokens) {
        std::cout << "Lexeme: " << token.lexeme << ", Type: " << static_cast<int>(token.type) << std::endl;
    }
    return tokens;
}
