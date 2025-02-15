#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>
#include <cctype>

enum class TokenType {
    IDENTIFIER, NUMBER, STRING, CHAR,
    FN, RETURN, LET, CONST, VAR,
    IF, ELSE, MATCH, CASE,
    LOOP, FOR, WHILE, CONTINUE, BREAK,
    PRINT, PRINTLN,
    ASM, COMPTIME, INCLUDE,
    INT, FLOAT, BOOL, STR, CHAR_T, LIST, DICT, STRUCT, ENUM,
    ASSIGN, PLUS, MINUS, STAR, SLASH, MODULO,
    EQUAL, NOT_EQUAL, GREATER, GREATER_EQUAL, LESS, LESS_EQUAL,
    AND, OR, NOT, BIT_AND, BIT_OR, BIT_XOR, BIT_NOT, LSHIFT, RSHIFT,
    LEFT_PAREN, RIGHT_PAREN, LEFT_BRACE, RIGHT_BRACE,
    LEFT_BRACKET, RIGHT_BRACKET, COMMA, DOT, COLON, SEMICOLON, ARROW,
    COMMENT, WHITESPACE,
    EOF_TOK
};

struct Token {
    TokenType type;
    std::string lexeme;
    int line;
};

class Lexer {
public:
    std::string source;
    std::vector<Token> tokens;
    int start = 0;
    int current = 0;
    int line = 1;

    std::unordered_map<std::string, TokenType> keywords = {
        {"fn", TokenType::FN}, {"return", TokenType::RETURN},
        {"let", TokenType::LET}, {"const", TokenType::CONST},
        {"var", TokenType::VAR}, {"if", TokenType::IF},
        {"else", TokenType::ELSE}, {"match", TokenType::MATCH},
        {"case", TokenType::CASE}, {"loop", TokenType::LOOP},
        {"for", TokenType::FOR}, {"while", TokenType::WHILE},
        {"continue", TokenType::CONTINUE}, {"break", TokenType::BREAK},
        {"print", TokenType::PRINT}, {"println", TokenType::PRINTLN},
        {"asm", TokenType::ASM}, {"comptime", TokenType::COMPTIME},
        {"include", TokenType::INCLUDE},
        {"int", TokenType::INT}, {"float", TokenType::FLOAT},
        {"bool", TokenType::BOOL}, {"str", TokenType::STR},
        {"char", TokenType::CHAR_T}, {"list", TokenType::LIST},
        {"dict", TokenType::DICT}, {"struct", TokenType::STRUCT},
        {"enum", TokenType::ENUM}
    };

    bool isAtEnd() { return current >= source.length(); }
    char advance() { return source[current++]; }
    char peek() { return isAtEnd() ? '\0' : source[current]; }
    char peekNext() { return (current + 1 < source.length()) ? source[current + 1] : '\0'; }
    void addToken(TokenType type, std::string lexeme) { tokens.push_back({type, lexeme, line}); }

    void scanToken() {
        char c = advance();
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
    }

    void scanString() {
        std::string value;
        while (peek() != '"' && !isAtEnd()) {
            if (peek() == '\n') line++;
            value += advance();
        }
        if (isAtEnd()) return;
        advance();
        addToken(TokenType::STRING, value);
    }

    void scanChar() {
        char value = advance();
        if (peek() != '\'') return;
        advance();
        addToken(TokenType::CHAR, std::string(1, value));
    }

    void scanNumber() {
        std::string value;
        while (isdigit(peek())) value += advance();
        addToken(TokenType::NUMBER, value);
    }

    void scanIdentifier() {
        std::string value;
        while (isalnum(peek()) || peek() == '_') value += advance();
        auto type = keywords.count(value) ? keywords[value] : TokenType::IDENTIFIER;
        addToken(type, value);
    }

public:
    Lexer(const std::string& source) : source(source) {}
    std::vector<Token> scanTokens() {
        while (!isAtEnd()) {
            start = current;
            scanToken();
        }
        tokens.push_back({TokenType::EOF_TOK, "", line});
        return tokens;
    }
};
