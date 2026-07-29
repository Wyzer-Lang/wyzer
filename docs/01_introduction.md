# 1. Introduction to Wyzer

Welcome to Wyzer! Wyzer is a safe and fast programming language. It is built to create strong systems and secure networks.

## The Core Philosophy
Most bugs in complex systems (like memory leaks or network errors) happen because it is not clear who owns a resource.

Wyzer fixes this by tracking everything you create:
* Memory is managed automatically without pausing your program. It is as fast as C, but much easier to learn than Rust.
* Data is shared safely. The compiler checks that you use resources correctly.
* Network features are built-in. The compiler proves that your network code will not get stuck.

## Your First Program

```wyzer
import std::io;

fn main() {
    std::io::println("Hello, Wyzer!");
}
```

Wyzer code is easy to read. There is no hidden magic. You must write exactly what you mean. For example, if a variable is a number, you must write its exact size.

## Running Code
Right now, Wyzer runs through an OCaml interpreter.
To run a file, type this in your terminal:
```bash
dune exec wyzerc -- your_file.wyz
```
