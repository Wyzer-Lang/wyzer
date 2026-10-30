# Introduction to Wyzer

Hi there, fellow programmer! Welcome to Wyzer. Wyzer is a safe and blazingly
fast programming language built to create strong systems and secure networks.

## What's the thing about Wyzer that makes it special?

Most bugs in complex programs (e.g., memory leaks and network errors) occur
because the identity of who owns a certain resource is not clear. Wyzer
solves this problem by tracking everything you create.

- Memory is managed automatically by the compiler, without pausing the program.
  This makes Wyzer as fast as C, but has a less steep learning curve than Rust.

- Data is shared safely. The compiler checks that you use resources correctly.

- Network features are built-in with the language. The compiler shows that your
  network code will not get stuck.

## "Hello World!" in Wyzer
To print "Hello World!" in Wyzer, it would be:

```wyzer
import "std/io";

fn main() {
    std::io::println("Hello, World!");
}
    
```

As you can see, Wyzer's syntax is easy to read. You must write exactly what you want the program to do.
However, the compiler is smart enough to figure out the sizes of your numbers automatically!

## Running your code
As of now, Wyzer is written in OCaml and runs through an OCaml interpreter.
To run your program, enter this in your terminal:

```bash
dune exec wyzerc -- [filename].wyz
```

