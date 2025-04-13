#ifndef WYZER_LEXER_H
#define WYZER_LEXER_H

#include <string>
#include <vector>

enum class TokenType {
    KEYWORD,
    IDENTIFIER,
    NUMBER_LITERAL,
    STRING_LITERAL,
    SYMBOL,
    COLON,
    SEMICOLON,
    ARROW,
    LPAREN,
    RPAREN,
    LBRACE,
    RBRACE,
    PLUS,
    COMMA,
    END_OF_FILE,
    UNKNOWN
};

struct Token {
    TokenType type;
    std::string value;
    std::string subType; 
    int line;
};

class Lexer {
public:
    explicit Lexer(const std::string& src);
    std::vector<Token> tokenize();

private:
    char peek() const;
    char advance();
    char get();
    bool isAlpha(char c) const;
    bool isDigit(char c) const;
    bool isAlnum(char c) const;
    void skipWhitespace();
    Token identifier();
    Token stringLiteral();
    Token numberLiteral();

    std::string source;
    size_t pos = 0;
    int line = 1;
};

#endif // WYZER_LEXER_H
