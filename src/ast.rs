/* 
    NEWBIE NOTE: 
    The syntax tree: what the parser produces.
    Later passes (containment, placement, marking) walk this tree.
*/
#[derive(Debug, Clone, Copy)]
pub struct Pos {
    pub line: usize,
    pub col: usize,
}

#[derive(Debug, Clone)]
pub struct Program {
    pub items: Vec<Item>,
}

#[derive(Debug, Clone)]
pub enum Item {
    Struct(StructDecl),
    Fn(FnDecl),
}

#[derive(Debug, Clone)]
pub struct StructDecl {
    pub name: String,
    pub fields: Vec<Field>,
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub struct Field {
    pub name: String,
    pub ty: Type,
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub struct FnDecl {
    pub name: String,
    pub params: Vec<Param>,
    pub ret: Option<Type>,
    pub body: Block,
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub struct Param {
    pub name: String,
    pub ty: Type,
    pub mutates: bool, // written with !
    pub pos: Pos,
}

// [~ or &] Name [< args >]
#[derive(Debug, Clone)]
pub struct Type {
    pub name: String,
    pub args: Vec<Type>,
    pub is_ref: bool, // written with &
    pub shared: bool, // written with ~
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub struct Block {
    pub stmts: Vec<Stmt>,
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub enum Stmt {
    Let { name: String, value: Expr, pos: Pos },
    Return { value: Option<Expr>, pos: Pos },
    Expr(Expr),
    Block(Block),
}

#[derive(Debug, Clone)]
pub struct Expr {
    pub kind: ExprKind,
    pub pos: Pos,
}

#[derive(Debug, Clone)]
pub enum ExprKind {
    Name(String),
    Number(String),
    Str(String),
    Member(Box<Expr>, String),   // a.b
    Call(Box<Expr>, Vec<Expr>),  // f(args)
    Index(Box<Expr>, Box<Expr>), // a[i]
    Ref(Box<Expr>),              // &a
    Assign(Box<Expr>, Box<Expr>), // a = b
}

// NEWBIE NOTE: we print the tree, one node per line

fn out(depth: usize, text: String) {
    println!("{}{}", "  ".repeat(depth), text);
}

pub fn dump(p: &Program) {
    out(0, "Program".to_string());
    for item in &p.items {
        match item {
            Item::Struct(s) => dump_struct(s, 1),
            Item::Fn(f) => dump_fn(f, 1),
        }
    }
}

fn dump_type(t: &Type, d: usize) {
    let prefix = if t.shared { "~" } else if t.is_ref { "&" } else { "" };
    out(d, format!("Type  {}{}", prefix, t.name));
    for a in &t.args {
        dump_type(a, d + 1);
    }
}

fn dump_struct(s: &StructDecl, d: usize) {
    out(d, format!("Struct  {}", s.name));
    for f in &s.fields {
        out(d + 1, format!("Field  {}", f.name));
        dump_type(&f.ty, d + 2);
    }
}

fn dump_fn(f: &FnDecl, d: usize) {
    out(d, format!("Fn  {}", f.name));
    out(d + 1, "ParamList".to_string());
    for p in &f.params {
        let flag = if p.mutates { "  (!)" } else { "" };
        out(d + 2, format!("Param  {}{}", p.name, flag));
        dump_type(&p.ty, d + 3);
    }
    match &f.ret {
        Some(t) => dump_type(t, d + 1),
        None => out(d + 1, "None".to_string()),
    }
    dump_block(&f.body, d + 1);
}

fn dump_block(b: &Block, d: usize) {
    out(d, "Block".to_string());
    for s in &b.stmts {
        dump_stmt(s, d + 1);
    }
}

fn dump_stmt(s: &Stmt, d: usize) {
    match s {
        Stmt::Let { name, value, .. } => {
            out(d, format!("Let  {}", name));
            dump_expr(value, d + 1);
        }
        Stmt::Return { value, .. } => {
            out(d, "Return".to_string());
            if let Some(v) = value {
                dump_expr(v, d + 1);
            }
        }
        Stmt::Expr(e) => {
            out(d, "ExprStmt".to_string());
            dump_expr(e, d + 1);
        }
        Stmt::Block(b) => dump_block(b, d),
    }
}

fn dump_expr(e: &Expr, d: usize) {
    match &e.kind {
        ExprKind::Name(n) => out(d, format!("Name  {}", n)),
        ExprKind::Number(n) => out(d, format!("Number  {}", n)),
        ExprKind::Str(s) => out(d, format!("String  {}", s)),
        ExprKind::Member(obj, name) => {
            out(d, format!("Member  {}", name));
            dump_expr(obj, d + 1);
        }
        ExprKind::Call(callee, args) => {
            out(d, "Call".to_string());
            dump_expr(callee, d + 1);
            for a in args {
                dump_expr(a, d + 1);
            }
        }
        ExprKind::Index(obj, idx) => {
            out(d, "Index".to_string());
            dump_expr(obj, d + 1);
            dump_expr(idx, d + 1);
        }
        ExprKind::Ref(operand) => {
            out(d, "Ref".to_string());
            dump_expr(operand, d + 1);
        }
        ExprKind::Assign(target, value) => {
            out(d, "Assign".to_string());
            dump_expr(target, d + 1);
            dump_expr(value, d + 1);
        }
    }
}
