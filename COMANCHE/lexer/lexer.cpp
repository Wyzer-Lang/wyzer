#include "lexer.hpp"
#include <cctype>
#include <stdexcept>

Lexer::Lexer(const std::string& src) : source(src), pos(0) {}

char Lexer::peek() const {
    return pos < source.size() ? source[pos] : '\0';
}

char Lexer::advance() {
    if (pos >= source.length()) return '\0';
    char c = source[pos++];
    if (c == '\n') line++;
    return c;
}

char Lexer::get() {
    return pos < source.size() ? source[pos++] : '\0';
}

bool Lexer::isAlpha(char c) const {
    return std::isalpha(static_cast<unsigned char>(c)) || c == '_';
}

bool Lexer::isDigit(char c) const {
    return std::isdigit(static_cast<unsigned char>(c));
}

bool Lexer::isAlnum(char c) const {
    return isAlpha(c) || isDigit(c);
}

void Lexer::skipWhitespace() {
    while (std::isspace(peek())) advance();
}

Token Lexer::identifier() {
    std::string value;
    while (isAlnum(peek())) value += get();

    if (value == "fnc" || value == "let" || value == "var" || value == "return" ||
        value == "log" || value == "logln" || value == "loop") {
        return {TokenType::KEYWORD, value, value, line};
    }

    if (value == "string" || value == "int") {
        return {TokenType::KEYWORD, value, value, line};
    }

    return {TokenType::IDENTIFIER, value, "", line};
}

Token Lexer::stringLiteral() {
    std::string value;
    advance(); 

    while (true) {
        char c = peek();
        if (c == '\0') {
            throw std::runtime_error("Unterminated string literal at line " + std::to_string(line));
        }
        if (c == '"') {
            advance(); 
            break;
        }

        value += advance();
    }

    return {TokenType::STRING_LITERAL, value, "", line};
}


Token Lexer::numberLiteral() {
    std::string num;
    while (isDigit(peek())) {
        num += get();
    }
    return {TokenType::NUMBER_LITERAL, num, "", line};
}

std::vector<Token> Lexer::tokenize() {
    std::vector<Token> tokens;

    while (true) {
        skipWhitespace();
        char c = peek();
        if (c == '\0') break;

        if (isAlpha(c)) {
            tokens.push_back(identifier());
        } else if (c == '"') {
            tokens.push_back(stringLiteral());
        } else if (isDigit(c)) {
            tokens.push_back(numberLiteral());
        } else {
            switch (get()) {
                case ':':
                    tokens.push_back({TokenType::COLON, ":", "colon", line});
                    break;
                case '(':
                    tokens.push_back({TokenType::LPAREN, "(", "lparen", line});
                    break;
                case ')':
                    tokens.push_back({TokenType::RPAREN, ")", "rparen", line});
                    break;
                case '{':
                    tokens.push_back({TokenType::LBRACE, "{", "lbrace", line});
                    break;
                case '}':
                    tokens.push_back({TokenType::RBRACE, "}", "rbrace", line});
                    break;
                case '+':
                    tokens.push_back({TokenType::PLUS, "+", "plus", line});
                    break;
                case ',':
                    tokens.push_back({TokenType::COMMA, ",", "comma", line});
                    break;
                case ';':
                    tokens.push_back(Token{TokenType::SEMICOLON, ";", "", line});
                    break;
                case '-':
                    if (peek() == '>') {
                        get();
                        tokens.push_back({TokenType::ARROW, "->", "arrow", line});
                    } else {
                        tokens.push_back({TokenType::UNKNOWN, "-", "", line});
                    }
                    break;
                default:
                    tokens.push_back({TokenType::UNKNOWN, std::string(1, c), "", line});
                    break;
            }
        }
    }

    tokens.push_back({TokenType::END_OF_FILE, "", "", line});
    return tokens;
}
