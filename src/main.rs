/* 
CMD USAGEE:
    wyzer <file>            prints the syntax tree
    wyzer --tokens <file>   prints the tokens
    wyzer check <file>      runs the checker on one file
    wyzer test [dir]        runs every .wyz test under dir (default: wyz_tests)
    Exit codes: 0 ok, 1 error in the program or a failed test, 2 bad usage.
    Set NO_QUOTES=1 to print errors without the quote.
*/
#![allow(dead_code)]

mod ast;
mod body;
mod checker;
mod diagnostics;
mod lexer;
mod parser;
mod runner;

use std::path::Path;
use std::{env, fs, process};

use diagnostics::Issue;

fn read(path: &str) -> String {
    let p = Path::new(path);
    if p.extension().and_then(|e| e.to_str()) != Some("wyz") {
        eprintln!("{}: not a .wyz file", path);
        process::exit(2);
    }
    match fs::read_to_string(path) {
        Ok(s) => s,
        Err(_) => {
            eprintln!("cannot open {}", path);
            process::exit(2);
        }
    }
}

// lex and parse a file, or print the errors and exit.
fn load(path: &str) -> ast::Program {
    let src = read(path);
    let tokens = lexer::lex(&src);

    let mut issues: Vec<Issue> = Vec::new();
    for t in &tokens {
        if t.kind == lexer::Tok::Error {
            issues.push(Issue {
                line: t.line,
                col: t.col,
                code: "lexer".to_string(),
                msg: t.text.clone(),
            });
        }
    }
    if !issues.is_empty() {
        diagnostics::print(path, &issues);
        process::exit(1);
    }

    match parser::parse(&tokens) {
        Ok(p) => p,
        Err(e) => {
            let issue = Issue { line: e.line, col: e.col, code: "syntax".to_string(), msg: e.msg };
            diagnostics::print(path, &[issue]);
            process::exit(1);
        }
    }
}

fn usage() -> ! {
    eprintln!("usage: wyzer [--tokens | check] <file.wyz> | wyzer test [dir]");
    process::exit(2);
}

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();
    match args.first().map(|s| s.as_str()) {
        Some("-h") | Some("--help") => usage(),
        Some("test") => {
            let dir = args.get(1).map(|s| s.as_str()).unwrap_or("wyz_tests");
            let failed = runner::run_all(Path::new(dir));
            process::exit(if failed > 0 { 1 } else { 0 });
        }
        Some("check") => {
            let path = match args.get(1) {
                Some(p) => p,
                None => usage(),
            };
            let program = load(path);
            let report = checker::check(&program);
            let issues: Vec<Issue> = report
                .errors
                .iter()
                .map(|d| Issue { line: d.line, col: d.col, code: d.code.to_string(), msg: d.msg.clone() })
                .collect();
            diagnostics::print(path, &issues);
            for (name, owner) in &report.places {
                println!("place  {} -> {}", name, owner);
            }
            if !issues.is_empty() {
                process::exit(1);
            }
        }
        Some("--tokens") => {
            let path = match args.get(1) {
                Some(p) => p,
                None => usage(),
            };
            let src = read(path);
            for t in lexer::lex(&src) {
                print!("{}:{}  {:?}", t.line, t.col, t.kind);
                if !t.text.is_empty() {
                    print!("  {}", t.text);
                }
                println!();
            }
        }
        Some(path) => {
            let program = load(path);
            ast::dump(&program);
        }
        None => usage(),
    }
}
