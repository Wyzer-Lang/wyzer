# 10. Standard Library

Wyzer comes with a small but powerful standard library to help you build applications quickly without reinventing the wheel. The standard library is always available globally using the `std::` prefix.

## Input/Output (`std::io`)

The `std::io` module provides native tools for printing text to the screen and interacting with standard streams.

### Printing Text

You can use `print` and `println` to output text to standard output (`stdout`), and `eprint` and `eprintln` to output text to standard error (`stderr`). 

```wyzer
fn main() {
    // Prints without a newline
    std::io::print("Hello ");
    
    // Prints with a newline
    std::io::println("World!");
    
    // Prints an error message
    std::io::eprintln("Something went wrong!");
}
```

### String Formatting (F-Strings)

To easily embed variables inside your strings, Wyzer supports **f-strings** (format strings). You just put an `f` before the quotes and place your variables inside curly braces `{}`.

The compiler automatically type-checks the variables to ensure they are safe to print, keeping everything zero-cost!

```wyzer
fn main() {
    let user_name = "Alice";
    let score = 95;
    
    // Variables are inserted seamlessly
    std::io::println(f"Player {user_name} achieved a score of {score}!");
}
```

### Standard Streams

Wyzer exposes standard file descriptors globally so you can pass them around to functions that require a stream handle:

```wyzer
fn log_to_stream(stream: Stream) {
    // Write directly to the stream...
}

fn main() {
    let out = std::io::stdout;
    let err = std::io::stderr;
    let in  = std::io::stdin;
    
    log_to_stream(err);
}
```
*Note: Full generic `Read` and `Write` interfaces for custom streams are planned for a future update!*
