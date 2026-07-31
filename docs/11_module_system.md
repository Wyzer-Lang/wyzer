# Hybrid Module System

Wyzer implements a zero-boilerplate, hybrid module system designed for large-scale systems programming. It combines the structural safety of explicit module trees (like Rust) with the rapid on-demand lazy loading of modern package systems.

## The Two Pillars

### 1. `mod` - Explicit Tree Building

The `mod` keyword is used to explicitly declare dependencies and build the compilation unit's module tree. 
When the compiler encounters `pub mod math;`, it actively looks for `math.wyz` in the current directory and natively adds it to the AST. 

This ensures that the compiler has a strict, structural guarantee of which files belong to the project, which is critical for Endpoint Projection to analyze the entire topology holistically.

```wyzer
// src/main.wyz
pub mod math;
pub mod network;

fn main() {
    let result = math::geometry::calculate_area();
}
```

### 2. `import` - On-Demand Path Binding

The `import` statement allows you to bind paths from anywhere in your project into your current namespace. 
Crucially, **Wyzer uses absolute paths starting from the project root**, denoted by the `bundle::` prefix.

If an `import` points to a module that has not yet been `mod`ded into the compilation tree, the compiler will instantly find it from the project root and **lazy-load it dynamically** into both the typechecker and interpreter.

```wyzer
// Automatically crawls from project root to find src/math/geometry.wyz
import bundle::math::geometry;

// External standard library modules are also supported
import std::io;

fn main() {
    // You can call it via the resolved path
    geometry::calculate_area();
    
    // Or call standard library intrinsics
    std::io::println("Area calculated!");
}
```

## Cross-Module Symbol Resolution

Whether during strict compile-time Typechecking or during execution in the Runtime Interpreter (`Eval`), Wyzer natively resolves cross-module paths (e.g. `bundle::math::add(1, 2)`).

The module system requires **no relative paths**. You will never have to type `import "../../../utils/time.wyz"`. Everything is strictly rooted to `bundle::` for internal files or `std::` for external libraries.
