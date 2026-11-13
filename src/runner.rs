/* 
    The test runner. For every .wyz file it reads the expectations written in
    the comments, runs the checker, and compares.

   // expect: accept | reject
   // place: <value> -> <owner>
   ... // ERROR(code)          (on the line where the error must be reported)

 A test is skipped when it needs something the checker cannot do yet.
*/
use std::fs;
use std::path::{Path, PathBuf};

use crate::{checker, lexer, parser};

struct Expect {
    accept: Option<bool>,
    places: Vec<(String, String)>,
    errors: Vec<(usize, String)>,
}

enum Verdict {
    Pass { unchecked: usize },
    Fail(Vec<String>),
    Skip(String),
}

fn read_expectations(src: &str) -> Expect {
    let mut e = Expect { accept: None, places: Vec::new(), errors: Vec::new() };
    for (i, line) in src.lines().enumerate() {
        let trimmed = line.trim();
        if let Some(rest) = trimmed.strip_prefix("// expect:") {
            let rest = rest.trim();
            if rest.starts_with("accept") {
                e.accept = Some(true);
            } else if rest.starts_with("reject") {
                e.accept = Some(false);
            }
        }
        if let Some(rest) = trimmed.strip_prefix("// place:") {
            if let Some((name, owner)) = rest.split_once("->") {
                e.places.push((name.trim().to_string(), owner.trim().to_string()));
            }
        }
        if let Some(idx) = line.find("// ERROR(") {
            let rest = &line[idx + 9..];
            if let Some(code) = rest.split(')').next() {
                e.errors.push((i + 1, code.to_string()));
            }
        }
    }
    e
}

/// If the source has `// status: pending`, return the reason.
fn pending_reason(src: &str) -> Option<String> {
    for line in src.lines() {
        let trimmed = line.trim();
        if let Some(rest) = trimmed.strip_prefix("// status: pending") {
            let reason = rest.trim_start_matches(|c: char| c == ' ' || c == '(');
            let reason = reason.trim_end_matches(')').trim();
            if reason.is_empty() {
                return Some("pending".to_string());
            }
            return Some(format!("pending: {}", reason));
        }
        // also check `// status: undecided`
        if let Some(rest) = trimmed.strip_prefix("// expect: undecided") {
            let _ = rest;
            return Some("undecided".to_string());
        }
    }
    None
}

fn run_file(path: &Path) -> Verdict {
    let src = match fs::read_to_string(path) {
        Ok(s) => s,
        Err(_) => return Verdict::Fail(vec!["cannot read the file".to_string()]),
    };

    let tokens = lexer::lex(&src);
    for t in &tokens {
        if t.kind == lexer::Tok::Error {
            return Verdict::Fail(vec![format!("{}:{}: {}", t.line, t.col, t.text)]);
        }
    }
    let program = match parser::parse(&tokens) {
        Ok(p) => p,
        Err(e) => return Verdict::Fail(vec![format!("{}:{}: {}", e.line, e.col, e.msg)]),
    };

    // skip tests whose semantics are still undecided / pending.
    if let Some(reason) = pending_reason(&src) {
        return Verdict::Skip(reason);
    }

    let exp = read_expectations(&src);
    let report = checker::check(&program);
    let actual: Vec<(usize, String)> =
        report.errors.iter().map(|d| (d.line, d.code.to_string())).collect();

    let mut problems: Vec<String> = Vec::new();

    match exp.accept {
        Some(true) => {
            for (l, c) in &actual {
                problems.push(format!("unexpected {} at line {}", c, l));
            }
        }
        Some(false) => {
            if actual.is_empty() {
                problems.push("expected a rejection but found no errors".to_string());
            }
        }
        None => {}
    }
    for (l, c) in &exp.errors {
        if !actual.contains(&(*l, c.clone())) {
            problems.push(format!("missing {} at line {}", c, l));
        }
    }
    if exp.accept == Some(false) && !exp.errors.is_empty() {
        for a in &actual {
            if !exp.errors.contains(a) {
                problems.push(format!("unexpected {} at line {}", a.1, a.0));
            }
        }
    }

    let mut unchecked = 0;
    for (name, owner) in &exp.places {
        match report.places.iter().find(|(n, _)| n == name) {
            Some((_, got)) => {
                if got != owner {
                    problems.push(format!("place {}: expected {}, got {}", name, owner, got));
                }
            }
            None => unchecked += 1,
        }
    }

    if problems.is_empty() {
        Verdict::Pass { unchecked }
    } else {
        Verdict::Fail(problems)
    }
}

fn collect(dir: &Path, out: &mut Vec<PathBuf>) {
    let entries = match fs::read_dir(dir) {
        Ok(e) => e,
        Err(_) => return,
    };
    for entry in entries.flatten() {
        let p = entry.path();
        if p.is_dir() {
            if let Some(name) = p.file_name().and_then(|n| n.to_str()) {
                if name.starts_with('.') || name == "target" {
                    continue;
                }
            }
            collect(&p, out);
        } else if p.extension().map(|e| e == "wyz").unwrap_or(false) {
            out.push(p);
        }
    }
}

pub fn run_all(dir: &Path) -> usize {
    let mut files = Vec::new();
    if dir.is_file() {
        if dir.extension().map(|e| e == "wyz").unwrap_or(false) {
            files.push(dir.to_path_buf());
        } else {
            eprintln!("{}: not a .wyz file", dir.display());
            return 1;
        }
    } else {
        collect(dir, &mut files);
    }
    files.sort_by(|a, b| {
        let num = |p: &Path| -> Option<usize> {
            p.file_stem()?
                .to_str()?
                .strip_prefix("test")?
                .parse::<usize>()
                .ok()
        };
        match (num(a), num(b)) {
            (Some(na), Some(nb)) => na.cmp(&nb),
            _ => a.cmp(b),
        }
    });
    if files.is_empty() {
        println!("no .wyz files found in {}", dir.display());
        return 1;
    }

    let (mut pass, mut fail, mut skip) = (0, 0, 0);
    for f in &files {
        match run_file(f) {
            Verdict::Pass { unchecked } => {
                pass += 1;
                if unchecked > 0 {
                    println!("pass  {}  ({} place expectations unchecked)", f.display(), unchecked);
                } else {
                    println!("pass  {}", f.display());
                }
            }
            Verdict::Fail(problems) => {
                fail += 1;
                println!("FAIL  {}", f.display());
                for p in problems {
                    println!("        {}", p);
                }
            }
            Verdict::Skip(why) => {
                skip += 1;
                println!("skip  {}  ({})", f.display(), why);
            }
        }
    }
    println!("\n{} passed, {} failed, {} skipped", pass, fail, skip);
    fail
}
