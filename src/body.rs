/*
Function-body analysis.

This pass walks each function body after the struct-level checker has run.
It enforces:
   dangling-ref: returning &local or &local.field (settled)
   needs-tilde: assigning a plain local to a &T struct field (settled)
   shared-write: writing through a ~T field (draft)
   alias-conflict: passing the same variable as mutable AND ref (draft)
   stale-ref: using a reference after the target was mutated (draft)

 Tests marked "pending" are skipped by the runner.
 */

use std::collections::{BTreeMap, BTreeSet};

use crate::ast::*;
use crate::checker::Diag;

fn diag(pos: Pos, code: &'static str, msg: String) -> Diag {
    Diag { line: pos.line, col: pos.col, code, msg }
}

pub fn check_bodies(
    program: &Program,
    structs: &BTreeMap<String, &StructDecl>,
) -> (Vec<Diag>, Vec<(String, String)>) {
    let mut fns: BTreeMap<String, &FnDecl> = BTreeMap::new();
    for item in &program.items {
        if let Item::Fn(f) = item {
            fns.insert(f.name.clone(), f);
        }
    }
    let mut out: Vec<Diag> = Vec::new();
    let mut places: Vec<(String, String)> = Vec::new();
    for item in &program.items {
        if let Item::Fn(f) = item {
            let (diags, ps) = check_fn(f, structs, &fns);
            out.extend(diags);
            places.extend(ps);
        }
    }
    out.sort_by_key(|d| (d.line, d.col, d.code));
    out.dedup_by(|a, b| a.line == b.line && a.col == b.col && a.code == b.code);
    (out, places)
}

pub fn check_fn(
    f: &FnDecl,
    structs: &BTreeMap<String, &StructDecl>,
    fns: &BTreeMap<String, &FnDecl>,
) -> (Vec<Diag>, Vec<(String, String)>) {
    let mut out: Vec<Diag> = Vec::new();
    // Seed the env with parameters.
    let mut env: Env = BTreeMap::new();
    for p in &f.params {
        env.insert(p.name.clone(), VarInfo {
            origins: BTreeSet::new(),
            mutated_after_ref: false,
            is_ref: p.ty.is_ref,
            is_shared: p.ty.shared,
            ty_name: Some(p.ty.name.clone()),
            pos: p.pos,
            depth: 0,
        });
    }
    let mut cx = Cx {
        structs,
        fns,
        fn_name: &f.name,
        fn_ret: f.ret.as_ref(),
        out: &mut out,
        scope: vec![format!("frame({})", f.name)],
        places: Vec::new(),
    };
    cx.block(&f.body, &mut env);
    let places = cx.places;
    (out, places)
}

struct Cx<'a> {
    structs: &'a BTreeMap<String, &'a StructDecl>,
    fns: &'a BTreeMap<String, &'a FnDecl>,
    fn_name: &'a str,
    fn_ret: Option<&'a Type>,
    out: &'a mut Vec<Diag>,
    /// The scopes we are inside, outermost first. The last one owns new locals.
    scope: Vec<String>,
    /// (local name, owner) for every local declared so far.
    places: Vec<(String, String)>,
}

impl<'a> Cx<'a> {
    fn err(&mut self, pos: Pos, code: &'static str, msg: String) {
        self.out.push(diag(pos, code, msg));
    }
}

#[derive(Clone, Debug)]
struct VarInfo {
    /// The origins this variable borrows from (if it is a reference).
    origins: BTreeSet<String>,
    /// Set to true when any origin has been mutated since the ref was taken.
    mutated_after_ref: bool,
    /// Was this variable introduced as / bound to a reference (&)?
    is_ref: bool,
    /// Is this a shared (~) value?
    is_shared: bool,
    /// Best effort inferred struct type name (for field-type lookup).
    ty_name: Option<String>,
    pos: Pos,
    /// How deep the scope that declared it is. Parameters are 0, the function body is 1.
    depth: usize,
}

impl VarInfo {
    fn owned(pos: Pos, ty_name: Option<String>) -> Self {
        VarInfo {
            origins: BTreeSet::new(),
            mutated_after_ref: false,
            is_ref: false,
            is_shared: false,
            ty_name,
            pos,
            depth: 0,
        }
    }
    fn reference(origins: BTreeSet<String>, pos: Pos) -> Self {
        VarInfo {
            origins,
            mutated_after_ref: false,
            is_ref: true,
            is_shared: false,
            ty_name: None,
            pos,
            depth: 0,
        }
    }
}

type Env = BTreeMap<String, VarInfo>;

impl<'a> Cx<'a> {
    fn block(&mut self, b: &Block, env: &mut Env) {
        for s in &b.stmts {
            self.stmt(s, env);
        }
    }

    fn stmt(&mut self, s: &Stmt, env: &mut Env) {
        match s {
            Stmt::Let { name, value, pos } => {
                let info = self.eval_expr(value, env);
                let mut var_info = match info {
                    ExprInfo::Ref { origins } => VarInfo::reference(origins, *pos),
                    ExprInfo::Owned { ty_name } => VarInfo::owned(*pos, ty_name),
                    ExprInfo::Unknown => VarInfo::owned(*pos, None),
                };
                var_info.depth = self.scope.len();
                let owner = self.scope.last().cloned().unwrap_or_default();
                self.places.push((name.clone(), owner));
                env.insert(name.clone(), var_info);
            }
            Stmt::Return { value, pos } => {
                self.check_return(value.as_ref(), *pos, env);
            }
            Stmt::Expr(e) => {
                if let ExprKind::Assign(target, value) = &e.kind {
                    self.check_assignment(target, value, e.pos, env);
                } else {
                    self.eval_expr(e, env);
                }
            }
            Stmt::Block(b) => {
                let mut inner = env.clone();
                self.scope.push(format!("block({}:{})", self.fn_name, b.pos.line));
                self.block(b, &mut inner);
                self.scope.pop();
                // Propagate mutation flags back to outer-scope locals.
                for (k, v) in &inner {
                    if let Some(outer) = env.get_mut(k) {
                        if v.mutated_after_ref {
                            outer.mutated_after_ref = true;
                        }
                    }
                }
            }
        }
    }

    fn check_return(&mut self, value: Option<&Expr>, pos: Pos, env: &Env) {
        let Some(ret_ty) = self.fn_ret else { return };
        let Some(expr) = value else { return };

        if ret_ty.is_ref {
            // Returning a reference: check that it isn't into a local.
            let root = match &expr.kind {
                ExprKind::Ref(inner) => expr_root_name(inner),
                _ => expr_root_name(expr),
            };
            if let Some(local_name) = root {
                if let Some(info) = env.get(&local_name) {
                    if !info.is_ref {
                        // A plain owned local: its owner ends with this function.
                        self.err(
                            pos,
                            "dangling-ref",
                            format!(
                                "function '{}' returns a reference to local variable '{}'",
                                self.fn_name, local_name
                            ),
                        );
                    } else {
                        // A reference variable: follow it back to what it points at.
                        for o in &info.origins {
                            if let Some(oi) = env.get(o) {
                                if !oi.is_ref {
                                    self.err(
                                        pos,
                                        "dangling-ref",
                                        format!(
                                            "function '{}' returns a reference that points at local variable '{}'",
                                            self.fn_name, o
                                        ),
                                    );
                                }
                            }
                        }
                    }
                }
            }
        } else if let ExprKind::Name(n) = &expr.kind {
            // Returning an owned local moves it out to the caller.
            if let Some(info) = env.get(n) {
                if !info.is_ref {
                    if let Some(p) = self.places.iter_mut().rev().find(|p| &p.0 == n) {
                        p.1 = "frame(caller)".to_string();
                    }
                }
            }
        }
    }

    fn check_assignment(&mut self, target: &Expr, value: &Expr, pos: Pos, env: &mut Env) {
        // shared-write: writing through a ~T field.
        if self.is_write_through_shared(target, env) {
            self.err(pos, "shared-write", "cannot write through a shared (~) value".to_string());
        }

        // needs-tilde: assigning a plain local to an &T struct field.
        //    E.g. `x.other = y` where `other: &Node`.
        self.check_needs_tilde_assign(target, value, pos, env);

        // stale-ref check on the value being read.
        self.check_stale_on_use(value, pos, env);

        // After mutation of target's root, mark refs into it as stale.
        if let Some(target_root) = expr_root_name(target) {
            self.mark_mutated(&target_root, env);
        }
        let info = self.eval_expr(value, env);

        // `name = <reference>`: the variable now points somewhere new.
        if let ExprKind::Name(tn) = &target.kind {
            self.rebind(tn, info, pos, env);
        }
    }

    // Assigning a reference to an existing variable. The variable must not outlive what it points at.
    fn rebind(&mut self, name: &str, info: ExprInfo, pos: Pos, env: &mut Env) {
        let ExprInfo::Ref { origins } = info else { return };
        let target_depth = match env.get(name) {
            Some(t) => t.depth,
            None => return,
        };
        for o in &origins {
            if let Some(oi) = env.get(o) {
                if !oi.is_ref && oi.depth > target_depth {
                    self.err(
                        pos,
                        "dangling-ref",
                        format!("reference to '{}' escapes the scope where '{}' lives", o, o),
                    );
                }
            }
        }
        if let Some(t) = env.get_mut(name) {
            t.origins = origins;
            t.is_ref = true;
            t.mutated_after_ref = false;
        }
    }

    // Check: is `value` a plain local being assigned to `target.field` where that field is typed `&T`?  If so, needs-tilde.
    fn check_needs_tilde_assign(&mut self, target: &Expr, value: &Expr, pos: Pos, env: &Env) {
        // The target must be a field access: `expr.field_name`
        let ExprKind::Member(obj, field_name) = &target.kind else { return };

        // Find the struct type of obj.
        let struct_name = match self.infer_type(obj, env) {
            Some(n) => n,
            None => return,
        };
        let Some(s) = self.structs.get(&struct_name) else { return };
        let Some(field) = s.fields.iter().find(|f| &f.name == field_name) else { return };

        // Only flag when the field is `&T` (bare reference, not ~T).
        if !field.ty.is_ref {
            return;
        }

        // The value being assigned must be a plain local (not a call). If `value` is a plain Name that is an owned local, it's being stored as a bare reference that requires ~ unless one contains the other.
        let value_root = match &value.kind {
            ExprKind::Name(n) => n.clone(),
            ExprKind::Ref(inner) => match expr_root_name(inner) {
                Some(r) => r,
                None => return,
            },
            _ => return,
        };
        // Both must be plain owned locals in the same frame.
        let Some(val_info) = env.get(&value_root) else { return };
        if val_info.is_ref {
            return; // assigning a ref-to-ref is OK structurally
        }

        let obj_root = match expr_root_name(obj) {
            Some(r) => r,
            None => return,
        };
        let Some(obj_info) = env.get(&obj_root) else { return };
        if obj_info.is_ref {
            return; // obj is itself a ref/param struct-level checker handles it
        }

        // Both holder and value are plain owned locals that don't contain each other assigning a bare &T here is flagged as needs-tilde.
        if obj_root != value_root {
            self.err(
                pos,
                "needs-tilde",
                format!(
                    "assigning '{}' to field '{}' of '{}' using '&' but they are unrelated locals; use ~",
                    value_root, field_name, obj_root
                ),
            );
        }
    }

    fn check_stale_on_use(&mut self, e: &Expr, pos: Pos, env: &Env) {
        // Walk the expression and check each reference variable encountered.
        self.check_stale_expr(e, pos, env);
    }

    fn check_stale_expr(&mut self, e: &Expr, pos: Pos, env: &Env) {
        match &e.kind {
            ExprKind::Name(n) => {
                if let Some(info) = env.get(n) {
                    if info.is_ref && info.mutated_after_ref {
                        self.err(
                            pos,
                            "stale-ref",
                            format!(
                                "reference '{}' may be stale: its target was mutated after the reference was taken",
                                n
                            ),
                        );
                    }
                }
            }
            ExprKind::Member(obj, _) => self.check_stale_expr(obj, pos, env),
            ExprKind::Index(obj, idx) => {
                self.check_stale_expr(obj, pos, env);
                self.check_stale_expr(idx, pos, env);
            }
            ExprKind::Ref(inner) => self.check_stale_expr(inner, pos, env),
            ExprKind::Call(callee, args) => {
                self.check_stale_expr(callee, pos, env);
                for a in args {
                    self.check_stale_expr(a, a.pos, env);
                }
            }
            ExprKind::Assign(t, v) => {
                self.check_stale_expr(t, pos, env);
                self.check_stale_expr(v, pos, env);
            }
            ExprKind::Number(_) | ExprKind::Str(_) => {}
        }
    }

    fn mark_mutated(&self, name: &str, env: &mut Env) {
        for (_var, info) in env.iter_mut() {
            if info.is_ref && info.origins.contains(name) {
                info.mutated_after_ref = true;
            }
        }
    }

    // Returns true if expression `e` evaluates to a shared (~T) value.
    fn is_shared_expr(&self, e: &Expr, env: &Env) -> bool {
        match &e.kind {
            ExprKind::Name(n) => {
                if let Some(info) = env.get(n) {
                    if info.is_shared {
                        return true;
                    }
                }
                false
            }
            ExprKind::Member(obj, field_name) => {
                if let Some(struct_name) = self.infer_type(obj, env) {
                    if let Some(s) = self.structs.get(&struct_name) {
                        if let Some(f) = s.fields.iter().find(|f| &f.name == field_name) {
                            if f.ty.shared {
                                return true;
                            }
                        }
                    }
                }
                self.is_shared_expr(obj, env)
            }
            ExprKind::Index(obj, _) => self.is_shared_expr(obj, env),
            _ => false,
        }
    }

    fn is_write_through_shared(&self, target: &Expr, env: &Env) -> bool {
        match &target.kind {
            ExprKind::Member(obj, _) => self.is_shared_expr(obj, env),
            ExprKind::Index(obj, _) => self.is_shared_expr(obj, env),
            _ => false,
        }
    }

    fn infer_type(&self, e: &Expr, env: &Env) -> Option<String> {
        match &e.kind {
            ExprKind::Name(n) => {
                // First check the environment (params / locals with known ty_name).
                if let Some(info) = env.get(n) {
                    if let Some(ref ty_name) = info.ty_name {
                        return Some(ty_name.clone());
                    }
                }
                // Fall back: if the name IS a struct name (e.g. `Config.new`).
                if self.structs.contains_key(n) {
                    return Some(n.clone());
                }
                None
            }
            ExprKind::Member(obj, field_name) => {
                if field_name == "new" {
                    return self.infer_type(obj, env);
                }
                let parent = self.infer_type(obj, env)?;
                let s = self.structs.get(&parent)?;
                let f = s.fields.iter().find(|f| &f.name == field_name)?;
                if self.structs.contains_key(&f.ty.name) {
                    Some(f.ty.name.clone())
                } else {
                    None
                }
            }
            ExprKind::Call(callee, _) => {
                if let ExprKind::Member(obj, method) = &callee.kind {
                    if method == "new" {
                        return self.infer_type(obj, env);
                    }
                }
                if let ExprKind::Name(n) = &callee.kind {
                    if let Some(f) = self.fns.get(n) {
                        if let Some(r) = &f.ret {
                            return Some(r.name.clone());
                        }
                    }
                }
                None
            }
            _ => None,
        }
    }

    fn eval_expr(&mut self, e: &Expr, env: &mut Env) -> ExprInfo {
        match &e.kind {
            ExprKind::Name(n) => {
                self.check_stale_on_use(e, e.pos, env);
                let ty_name = env.get(n).and_then(|i| i.ty_name.clone());
                ExprInfo::Owned { ty_name }
            }
            ExprKind::Number(_) => ExprInfo::Owned { ty_name: None },
            ExprKind::Str(_) => ExprInfo::Owned { ty_name: None },

            ExprKind::Ref(inner) => {
                // &x or &x.field produce a Ref with origins = {root of inner}.
                self.check_stale_on_use(inner, e.pos, env);
                let root = expr_root_name(inner);
                let mut origins = BTreeSet::new();
                if let Some(r) = root {
                    origins.insert(r);
                }
                ExprInfo::Ref { origins }
            }

            ExprKind::Member(obj, _field) => {
                // Stale checking on the whole expression.
                self.check_stale_on_use(e, e.pos, env);
                let inner = self.eval_expr(obj, env);
                // A field access preserves ref-ness of the base.
                inner
            }

            ExprKind::Index(obj, idx) => {
                self.check_stale_on_use(e, e.pos, env);
                let base = self.eval_expr(obj, env);
                self.eval_expr(idx, env);
                // Index into a refkeeps ref semantics.
                base
            }

            ExprKind::Assign(target, value) => {
                self.check_assignment(target, value, e.pos, env);
                ExprInfo::Owned { ty_name: None }
            }

            ExprKind::Call(callee, args) => {
                self.check_call(callee, args, e.pos, env);
                let ty_name = self.infer_type(e, env);
                let is_ref = if let ExprKind::Name(n) = &callee.kind {
                    self.fns.get(n).and_then(|f| f.ret.as_ref()).map(|r| r.is_ref).unwrap_or(false)
                } else {
                    false
                };
                if is_ref {
                    // The result points at whatever the reference arguments point at.
                    let mut origins: BTreeSet<String> = BTreeSet::new();
                    for a in args {
                        match &a.kind {
                            ExprKind::Ref(inner) => {
                                if let Some(r) = expr_root_name(inner) {
                                    origins.insert(r);
                                }
                            }
                            ExprKind::Name(n) => {
                                if let Some(i) = env.get(n) {
                                    if i.is_ref {
                                        for o in &i.origins {
                                            origins.insert(o.clone());
                                        }
                                    }
                                }
                            }
                            _ => {}
                        }
                    }
                    ExprInfo::Ref { origins }
                } else if ty_name.is_some() {
                    ExprInfo::Owned { ty_name }
                } else {
                    ExprInfo::Unknown
                }
            }
        }
    }

    fn check_call(&mut self, callee: &Expr, args: &[Expr], pos: Pos, env: &mut Env) {
        // alias-conflict: same variable passed as both plain (mutable) and &.
        let mut plain_roots: BTreeSet<String> = BTreeSet::new();
        let mut ref_roots: BTreeSet<String> = BTreeSet::new();

        for arg in args {
            match &arg.kind {
                ExprKind::Ref(inner) => {
                    if let Some(r) = expr_root_name(inner) {
                        ref_roots.insert(r);
                    }
                }
                _ => {
                    if let Some(r) = expr_root_name(arg) {
                        plain_roots.insert(r);
                    }
                }
            }
        }

        for r in plain_roots.intersection(&ref_roots) {
            self.err(
                pos,
                "alias-conflict",
                format!(
                    "variable '{}' is passed as both mutable and by reference in the same call",
                    r
                ),
            );
        }

        // Stale check on each arg.
        for arg in args {
            self.check_stale_on_use(arg, arg.pos, env);
        }

        // Evaluate callee and args.
        self.eval_expr(callee, env);
        for arg in args {
            self.eval_expr(arg, env);
        }

        // Mutating method calls mark the receiver as mutated.
        if let ExprKind::Member(obj, method) = &callee.kind {
            let mutating = ["push", "remove", "insert", "clear", "pop"];
            if mutating.contains(&method.as_str()) {
                if let Some(r) = expr_root_name(obj) {
                    self.mark_mutated(&r, env);
                }
            }
        }

        let _ = pos;
    }
}

enum ExprInfo {
    Owned { ty_name: Option<String> },
    Ref { origins: BTreeSet<String> },
    Unknown,
}


/// Return the root variable name of a path expression (a, a.b, a.b.c, a[i]).
fn expr_root_name(e: &Expr) -> Option<String> {
    match &e.kind {
        ExprKind::Name(n) => Some(n.clone()),
        ExprKind::Member(obj, _) => expr_root_name(obj),
        ExprKind::Index(obj, _) => expr_root_name(obj),
        ExprKind::Ref(inner) => expr_root_name(inner),
        _ => None,
    }
}
