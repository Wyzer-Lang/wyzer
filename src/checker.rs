/* 
NEWBIE NOTE: The checker works on the syntax tree and reports where the model's rules
are broken. It checks struct declarations and function bodies:

   Names:        every type used must be a declared struct or a built-in.

   Containment:  which struct holds which by value.

   Rule M:       a reference (&T) into a value owned by an unrelated struct
                    needs ~. Shared values (~T) are placed in the nearest
                    struct that contains every holder (Rule P).
                    
  Bodies:       dangling-ref, shared-write, alias-conflict, stale-ref.
*/

use std::collections::{BTreeMap, BTreeSet, VecDeque};

use crate::body;

use crate::ast::*;

#[derive(Debug, Clone)]
pub struct Diag {
    pub line: usize,
    pub col: usize,
    pub code: &'static str,
    pub msg: String,
}

#[derive(Debug, Default)]
pub struct Report {
    pub errors: Vec<Diag>,
    // (value name, owner). For example ("data", "App").
    pub places: Vec<(String, String)>,
}

const BUILTINS: [&str; 6] = ["Int", "Float", "Bool", "Str", "Vec", "Option"];

type Structs<'a> = BTreeMap<String, &'a StructDecl>;
type Graph = BTreeMap<String, BTreeSet<String>>;
type Ancestors = BTreeMap<String, BTreeMap<String, usize>>;

fn diag(pos: Pos, code: &'static str, msg: String) -> Diag {
    Diag { line: pos.line, col: pos.col, code, msg }
}

pub fn check(program: &Program) -> Report {
    let mut report = Report::default();

    let mut structs: Structs<'_> = BTreeMap::new();
    for item in &program.items {
        if let Item::Struct(s) = item {
            if structs.contains_key(&s.name) {
                report.errors.push(diag(
                    s.pos,
                    "duplicate-struct",
                    format!("struct '{}' is declared twice", s.name),
                ));
            } else {
                structs.insert(s.name.clone(), s);
            }
        }
    }

    for s in structs.values() {
        for f in &s.fields {
            check_type_known(&f.ty, &structs, &mut report);
        }
    }
    for item in &program.items {
        if let Item::Fn(f) = item {
            for p in &f.params {
                check_type_known(&p.ty, &structs, &mut report);
            }
            if let Some(r) = &f.ret {
                check_type_known(r, &structs, &mut report);
            }
        }
    }

    // holds[S] = the structs that S holds by value (a ~T or &T field holds nothing).
    let mut holds: Graph = BTreeMap::new();
    // direct[S] = only plain by-value fields, used to find infinite size.
    let mut direct: Graph = BTreeMap::new();
    for s in structs.values() {
        let mut set = BTreeSet::new();
        let mut dset = BTreeSet::new();
        for f in &s.fields {
            collect_owned(&f.ty, &structs, &mut set);
            if let Some(name) = direct_child(&f.ty, &structs) {
                dset.insert(name);
            }
        }
        holds.insert(s.name.clone(), set);
        direct.insert(s.name.clone(), dset);
    }

    for s in structs.values() {
        if reaches(&direct, &s.name, &s.name) {
            report.errors.push(diag(
                s.pos,
                "infinite-size",
                format!("struct '{}' contains itself by value", s.name),
            ));
        }
    }

    // parents[T] = the structs that hold T by value.
    let mut parents: Graph = BTreeMap::new();
    for (holder, set) in &holds {
        for t in set {
            parents.entry(t.clone()).or_default().insert(holder.clone());
        }
    }

    // anc[S] = S and every struct that contains S, with how many steps away.
    let mut anc: Ancestors = BTreeMap::new();
    for name in structs.keys() {
        anc.insert(name.clone(), ancestors(name, &parents));
    }

    // Rule M for references
    for s in structs.values() {
        for f in &s.fields {
            let mut refs: Vec<(String, Pos)> = Vec::new();
            collect_refs(&f.ty, &mut refs);
            for (target, pos) in refs {
                let owners = match parents.get(&target) {
                    Some(o) => o,
                    None => continue, // nobody owns it in a struct: lives in a frame
                };
                let legal = owners.iter().any(|o| {
                    anc[&s.name].contains_key(o) || anc[o].contains_key(&s.name)
                });
                if !legal {
                    report.errors.push(diag(
                        pos,
                        "needs-tilde",
                        format!(
                            "'{}' in struct '{}' points at a {} owned by an unrelated struct; use ~",
                            f.name, s.name, target
                        ),
                    ));
                }
            }
        }
    }

    // Rule P for shared values
    // shared[T] = (structs holding a ~T, the field names that do)
    let mut shared: BTreeMap<String, (BTreeSet<String>, BTreeSet<String>)> = BTreeMap::new();
    for s in structs.values() {
        for f in &s.fields {
            let mut names: Vec<String> = Vec::new();
            collect_shared(&f.ty, &mut names);
            for t in names {
                let entry = shared.entry(t).or_default();
                entry.0.insert(s.name.clone());
                entry.1.insert(f.name.clone());
            }
        }
    }
    for (_, (holders, fields)) in &shared {
        let owner = common_owner(holders, &anc);
        for field in fields {
            report.places.push((field.clone(), owner.clone()));
        }
    }

    report.errors.sort_by_key(|d| (d.line, d.col));

    let (body_errors, body_places) = body::check_bodies(program, &structs);
    report.errors.extend(body_errors);
    report.places.extend(body_places);
    report.errors.sort_by_key(|d| (d.line, d.col));

    report
}

fn check_type_known(ty: &Type, structs: &Structs<'_>, report: &mut Report) {
    if !BUILTINS.contains(&ty.name.as_str()) && !structs.contains_key(&ty.name) {
        report.errors.push(diag(
            ty.pos,
            "unknown-type",
            format!("unknown type '{}'", ty.name),
        ));
    }
    for a in &ty.args {
        check_type_known(a, structs, report);
    }
}

// Structs held by value (not through & or ~) Type arguments such as Vec<Node> count.
fn collect_owned(ty: &Type, structs: &Structs<'_>, out: &mut BTreeSet<String>) {
    if ty.shared || ty.is_ref {
        return;
    }
    if structs.contains_key(&ty.name) {
        out.insert(ty.name.clone());
    }
    for a in &ty.args {
        collect_owned(a, structs, out);
    }
}

// A plain field of struct type, with no generics involved.
fn direct_child(ty: &Type, structs: &Structs<'_>) -> Option<String> {
    if ty.shared || ty.is_ref || !ty.args.is_empty() {
        return None;
    }
    if structs.contains_key(&ty.name) {
        Some(ty.name.clone())
    } else {
        None
    }
}

fn collect_refs(ty: &Type, out: &mut Vec<(String, Pos)>) {
    if ty.is_ref {
        out.push((ty.name.clone(), ty.pos));
    }
    for a in &ty.args {
        collect_refs(a, out);
    }
}

fn collect_shared(ty: &Type, out: &mut Vec<String>) {
    if ty.shared {
        out.push(ty.name.clone());
    }
    for a in &ty.args {
        collect_shared(a, out);
    }
}

// Can `target` be reached from `from` by following at least one edge?
fn reaches(map: &Graph, from: &str, target: &str) -> bool {
    let mut seen: BTreeSet<String> = BTreeSet::new();
    let mut stack: Vec<String> = match map.get(from) {
        Some(s) => s.iter().cloned().collect(),
        None => Vec::new(),
    };
    while let Some(cur) = stack.pop() {
        if cur == target {
            return true;
        }
        if seen.insert(cur.clone()) {
            if let Some(next) = map.get(&cur) {
                for n in next {
                    stack.push(n.clone());
                }
            }
        }
    }
    false
}

// `start` and everything that contains it, with the number of steps up.
fn ancestors(start: &str, parents: &Graph) -> BTreeMap<String, usize> {
    let mut dist: BTreeMap<String, usize> = BTreeMap::new();
    dist.insert(start.to_string(), 0);
    let mut queue: VecDeque<String> = VecDeque::new();
    queue.push_back(start.to_string());
    while let Some(cur) = queue.pop_front() {
        let d = dist[&cur];
        if let Some(ps) = parents.get(&cur) {
            for p in ps {
                if !dist.contains_key(p) {
                    dist.insert(p.clone(), d + 1);
                    queue.push_back(p.clone());
                }
            }
        }
    }
    dist
}

// The nearest struct that contains every holder (or "frame" if there is none).
fn common_owner(holders: &BTreeSet<String>, anc: &Ancestors) -> String {
    let first = match holders.iter().next() {
        Some(h) => h,
        None => return "frame".to_string(),
    };
    let mut best: Option<(usize, String)> = None;
    for cand in anc[first].keys() {
        let mut total: usize = 0;
        let mut ok = true;
        for h in holders {
            match anc[h].get(cand) {
                Some(d) => total += *d,
                None => {
                    ok = false;
                    break;
                }
            }
        }
        if ok {
            let better = match &best {
                None => true,
                Some((best_total, _)) => total < *best_total,
            };
            if better {
                best = Some((total, cand.clone()));
            }
        }
    }
    match best {
        Some((_, name)) => name,
        None => "frame".to_string(),
    }
}
