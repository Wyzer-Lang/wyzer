// For if you're dumb or a newbie contributor: The lexer turns source text into a list of tokens.
// A token is the smallest meaningful piece: a name, a number, a symbol.

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Tok {
    Ident,
    Number,
    Str,
    KwStruct,
    KwLet,
    KwFn,
    KwReturn,
    Tilde,
    Amp,
    Bang,
    LBrace,
    RBrace,
    LParen,
    RParen,
    LBracket,
    RBracket,
    Lt,
    Gt,
    Semi,
    Colon,
    Comma,
    Dot,
    Eq,
    Arrow,
    End,
    Error,
}

#[derive(Debug, Clone)]
pub struct Token {
    pub kind: Tok,
    pub text: String,
    pub line: usize, // starts at 1
    pub col: usize,  // starts at 1
}

struct Lexer {
    chars: Vec<char>,
    i: usize,
    line: usize,
    col: usize,
}

impl Lexer {
    // The character `off` places ahead, or '\0' past the end.
    fn peek(&self, off: usize) -> char {
        *self.chars.get(self.i + off).unwrap_or(&'\0')
    }

    // Move forward one character and keep line and column up to date.
    fn advance(&mut self) {
        if self.chars[self.i] == '\n' {
            self.line += 1;
            self.col = 1;
        } else {
            self.col += 1;
        }
        self.i += 1;
    }

    fn done(&self) -> bool {
        self.i >= self.chars.len()
    }
}

// Reads the whole source and returns every token, ending with Tok::End.
// A character it does not recognise becomes a Tok::Error token.
pub fn lex(src: &str) -> Vec<Token> {
    let mut lx = Lexer { chars: src.chars().collect(), i: 0, line: 1, col: 1 };
    let mut out: Vec<Token> = Vec::new();

    while !lx.done() {
        let c = lx.peek(0);

        if c.is_whitespace() {
            lx.advance();
            continue;
        }

        if c == '/' && lx.peek(1) == '/' {
            while !lx.done() && lx.peek(0) != '\n' {
                lx.advance();
            }
            continue;
        }

        let (line, col) = (lx.line, lx.col);


        if c.is_ascii_alphabetic() || c == '_' {
            let mut word = String::new();
            while !lx.done() && (lx.peek(0).is_ascii_alphanumeric() || lx.peek(0) == '_') {
                word.push(lx.peek(0));
                lx.advance();
            }
            // Only these words are reserved. Vec, Option, Int, ... are ordinary names.
            let kind = match word.as_str() {
                "struct" => Tok::KwStruct,
                "let" => Tok::KwLet,
                "fn" => Tok::KwFn,
                "ret" => Tok::KwReturn,
                _ => Tok::Ident,
            };
            out.push(Token { kind, text: word, line, col });
            continue;
        }

        //NOTE: WE ONLY HAVE WHOLE NUMBERS FOR NOW 

         if c.is_ascii_digit() {
            let mut num = String::new();
            while !lx.done() && lx.peek(0).is_ascii_digit() {
                num.push(lx.peek(0));
                lx.advance();
            }
            out.push(Token { kind: Tok::Number, text: num, line, col });
            continue;
        }

        if c == '"' {
            let mut text = String::new();
            lx.advance(); // opening quote
            while !lx.done() && lx.peek(0) != '"' && lx.peek(0) != '\n' {
                text.push(lx.peek(0));
                lx.advance();
            }
            if lx.peek(0) == '"' {
                lx.advance(); // closing quote
                out.push(Token { kind: Tok::Str, text, line, col });
            } else {
                out.push(Token { kind: Tok::Error, text: "unterminated string".to_string(), line, col });
            }
            continue;
        }

        
        if c == '-' && lx.peek(1) == '>' {
            lx.advance();
            lx.advance();
            out.push(Token { kind: Tok::Arrow, text: "->".to_string(), line, col });
            continue;
        }

        // One-character symbols.
        let kind = match c {
            '~' => Tok::Tilde,
            '&' => Tok::Amp,
            '!' => Tok::Bang,
            '{' => Tok::LBrace,
            '}' => Tok::RBrace,
            '(' => Tok::LParen,
            ')' => Tok::RParen,
            '[' => Tok::LBracket,
            ']' => Tok::RBracket,
            '<' => Tok::Lt,
            '>' => Tok::Gt,
            ';' => Tok::Semi,
            ':' => Tok::Colon,
            ',' => Tok::Comma,
            '.' => Tok::Dot,
            '=' => Tok::Eq,
            _ => Tok::Error,
        };
        lx.advance();
        let text = if kind == Tok::Error {
            format!("unexpected character '{}'", c)
        } else {
            c.to_string()
        };
        out.push(Token { kind, text, line, col });
    }

    out.push(Token { kind: Tok::End, text: String::new(), line: lx.line, col: lx.col });
    out
}
