// NEWBIE NOTE: The parser reads tokens left to right. Each grammar rule is one function
// that reads the tokens for that rule and returns a piece of the tree.

use crate::ast::*;
use crate::lexer::{Tok, Token};

pub struct ParseError {
    pub msg: String,
    pub line: usize,
    pub col: usize,
}

type R<T> = Result<T, ParseError>;

pub fn parse(tokens: &[Token]) -> R<Program> {
    let mut p = Parser { toks: tokens, pos: 0 };
    p.program()
}

struct Parser<'a> {
    toks: &'a [Token],
    pos: usize,
}

impl<'a> Parser<'a> {
    fn cur(&self) -> &Token {
        &self.toks[self.pos]
    }

    fn at(&self, k: Tok) -> bool {
        self.cur().kind == k
    }

    fn here(&self) -> Pos {
        Pos { line: self.cur().line, col: self.cur().col }
    }

    fn next(&mut self) -> Token {
        let t = self.toks[self.pos].clone();
        if t.kind != Tok::End {
            self.pos += 1;
        }
        t
    }

    fn accept(&mut self, k: Tok) -> bool {
        if self.at(k) {
            self.next();
            true
        } else {
            false
        }
    }

    fn fail<T>(&self, msg: &str) -> R<T> {
        let t = self.cur();
        let found = if t.kind == Tok::End {
            "end of file".to_string()
        } else {
            format!("'{}'", t.text)
        };
        Err(ParseError { msg: format!("{}, found {}", msg, found), line: t.line, col: t.col })
    }

    fn expect(&mut self, k: Tok, what: &str) -> R<Token> {
        if !self.at(k) {
            return self.fail(&format!("expected {}", what));
        }
        Ok(self.next())
    }

    fn program(&mut self) -> R<Program> {
        let mut items = Vec::new();
        while !self.at(Tok::End) {
            if self.at(Tok::KwStruct) {
                items.push(Item::Struct(self.struct_decl()?));
            } else if self.at(Tok::KwFn) {
                items.push(Item::Fn(self.fn_decl()?));
            } else {
                return self.fail("expected 'struct' or 'fn'");
            }
        }
        Ok(Program { items })
    }

    // struct Name { field: Type; ... }
    fn struct_decl(&mut self) -> R<StructDecl> {
        let pos = self.here();
        self.next(); // 'struct'
        let name = self.expect(Tok::Ident, "a struct name")?.text;
        self.expect(Tok::LBrace, "'{'")?;
        let mut fields = Vec::new();
        while !self.at(Tok::RBrace) {
            let fpos = self.here();
            let fname = self.expect(Tok::Ident, "a field name")?.text;
            self.expect(Tok::Colon, "':'")?;
            let ty = self.ty()?;
            self.expect(Tok::Semi, "';'")?;
            fields.push(Field { name: fname, ty, pos: fpos });
        }
        self.expect(Tok::RBrace, "'}'")?;
        Ok(StructDecl { name, fields, pos })
    }

    // fn name(param: Type, param: Type!) -> Type { ... }
    fn fn_decl(&mut self) -> R<FnDecl> {
        let pos = self.here();
        self.next(); // 'fn'
        let name = self.expect(Tok::Ident, "a function name")?.text;
        self.expect(Tok::LParen, "'('")?;
        let mut params = Vec::new();
        while !self.at(Tok::RParen) {
            let ppos = self.here();
            let pname = self.expect(Tok::Ident, "a parameter name")?.text;
            self.expect(Tok::Colon, "':'")?;
            let ty = self.ty()?;
            let mutates = self.accept(Tok::Bang);
            params.push(Param { name: pname, ty, mutates, pos: ppos });
            if !self.accept(Tok::Comma) {
                break;
            }
        }
        self.expect(Tok::RParen, "')'")?;
        let ret = if self.accept(Tok::Arrow) { Some(self.ty()?) } else { None };
        let body = self.block()?;
        Ok(FnDecl { name, params, ret, body, pos })
    }

    // [~ or &] Name [< Type, Type >]
    fn ty(&mut self) -> R<Type> {
        let pos = self.here();
        let shared = self.accept(Tok::Tilde);
        let is_ref = if shared { false } else { self.accept(Tok::Amp) };
        let name = self.expect(Tok::Ident, "a type name")?.text;
        let mut args = Vec::new();
        if self.accept(Tok::Lt) {
            loop {
                args.push(self.ty()?);
                if !self.accept(Tok::Comma) {
                    break;
                }
            }
            self.expect(Tok::Gt, "'>'")?;
        }
        Ok(Type { name, args, is_ref, shared, pos })
    }

    fn block(&mut self) -> R<Block> {
        let pos = self.here();
        self.expect(Tok::LBrace, "'{'")?;
        let mut stmts = Vec::new();
        while !self.at(Tok::RBrace) {
            if self.at(Tok::End) {
                return self.fail("expected '}'");
            }
            stmts.push(self.statement()?);
        }
        self.expect(Tok::RBrace, "'}'")?;
        Ok(Block { stmts, pos })
    }

    fn statement(&mut self) -> R<Stmt> {
        let pos = self.here();
        if self.at(Tok::KwLet) {
            self.next();
            let name = self.expect(Tok::Ident, "a variable name")?.text;
            self.expect(Tok::Eq, "'='")?;
            let value = self.expr()?;
            self.expect(Tok::Semi, "';'")?;
            return Ok(Stmt::Let { name, value, pos });
        }
        if self.at(Tok::KwReturn) {
            self.next();
            let value = if self.at(Tok::Semi) { None } else { Some(self.expr()?) };
            self.expect(Tok::Semi, "';'")?;
            return Ok(Stmt::Return { value, pos });
        }
        if self.at(Tok::LBrace) {
            return Ok(Stmt::Block(self.block()?));
        }
        let e = self.expr()?;
        self.expect(Tok::Semi, "';'")?;
        Ok(Stmt::Expr(e))
    }

    fn expr(&mut self) -> R<Expr> {
        self.assignment()
    }

    // target = value
    fn assignment(&mut self) -> R<Expr> {
        let left = self.unary()?;
        if self.at(Tok::Eq) {
            let pos = self.here();
            self.next();
            let right = self.assignment()?;
            return Ok(Expr { kind: ExprKind::Assign(Box::new(left), Box::new(right)), pos });
        }
        Ok(left)
    }

    // &expr
    fn unary(&mut self) -> R<Expr> {
        if self.at(Tok::Amp) {
            let pos = self.here();
            self.next();
            let operand = self.unary()?;
            return Ok(Expr { kind: ExprKind::Ref(Box::new(operand)), pos });
        }
        self.postfix()
    }

    // a.b   a(args)   a[i]   chained any number of times
    fn postfix(&mut self) -> R<Expr> {
        let mut e = self.primary()?;
        loop {
            if self.at(Tok::Dot) {
                let pos = self.here();
                self.next();
                let name = self.expect(Tok::Ident, "a field name after '.'")?.text;
                e = Expr { kind: ExprKind::Member(Box::new(e), name), pos };
            } else if self.at(Tok::LParen) {
                let pos = self.here();
                self.next();
                let mut args = Vec::new();
                while !self.at(Tok::RParen) {
                    args.push(self.expr()?);
                    if !self.accept(Tok::Comma) {
                        break;
                    }
                }
                self.expect(Tok::RParen, "')'")?;
                e = Expr { kind: ExprKind::Call(Box::new(e), args), pos };
            } else if self.at(Tok::LBracket) {
                let pos = self.here();
                self.next();
                let idx = self.expr()?;
                self.expect(Tok::RBracket, "']'")?;
                e = Expr { kind: ExprKind::Index(Box::new(e), Box::new(idx)), pos };
            } else {
                return Ok(e);
            }
        }
    }

    fn primary(&mut self) -> R<Expr> {
        let pos = self.here();
        if self.at(Tok::Ident) {
            return Ok(Expr { kind: ExprKind::Name(self.next().text), pos });
        }
        if self.at(Tok::Number) {
            return Ok(Expr { kind: ExprKind::Number(self.next().text), pos });
        }
        if self.at(Tok::Str) {
            return Ok(Expr { kind: ExprKind::Str(self.next().text), pos });
        }
        if self.accept(Tok::LParen) {
            let e = self.expr()?;
            self.expect(Tok::RParen, "')'")?;
            return Ok(e);
        }
        self.fail("expected an expression")
    }
}
