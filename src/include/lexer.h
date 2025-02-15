#ifndef WYZER_LEXER_H
#define WYZER_LEXER_H

#include <string>
#include <vector>
#include <unordered_map>
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
    EOF_TOK, EQUAL_EQUAL, BANG_EQUAL
};


struct Token {
    TokenType type;
    std::string lexeme;
    int line;
};


class Lexer {
private:
    std::string source;
public:
    std::vector<Token> tokens;
    int start = 0;
    int current = 0;
    int line = 1;

    std::unordered_map<std::string, TokenType> keywords;

    bool isAtEnd();
    char advance();
    char peek();
    char peekNext();
    void addToken(TokenType type, std::string lexeme);
    void scanToken();
    void scanString();
    void scanChar();
    void scanNumber();
    void scanIdentifier();


    std::vector<Token> getTokens() { return tokens; }
    explicit Lexer(const std::string& source);
    std::vector<Token> scanTokens(); 
};

#endif // WYZER_LEXER_H
