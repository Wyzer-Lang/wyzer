# 3. Control Flow

Wyzer gives you simple ways to control how your program runs.

## If / Else
You use `if` and `else` for basic choices. You must always use brackets `{}`.

```wyzer
fn main() {
    let x: u32 = 10u32;
    
    if x > 5u32 {
        std::io::println("x is greater than 5");
    } else {
        std::io::println("x is 5 or less");
    }
}
```

## Match Statements
The `match` statement is the safest way to read enums and errors. It forces you to handle every possible outcome.

```wyzer
fn main() {
    let response: Result<u32, str> = Ok(200u32);
    
    match (response) {
        Ok(code) => std::io::println(code),
        Err(msg) => std::io::println("Error occurred")
    };
}
```
*Note: A `match` block is an expression. If you use it on its own line, you must put a semicolon `;` at the end.*

### Exhaustiveness Checking

Wyzer's compiler performs strict **Exhaustiveness Checking** on all `match` statements. This means the compiler mathematically verifies that you have handled every possible value (like every variant in an `enum`, or `true` and `false` for `bool`). If you miss one, your code will not compile!

If you don't want to handle every single choice individually, you can use the wildcard pattern (`_`) as a "catch-all" fallback for any remaining variants:

```wyzer
fn process(status: Status) {
    match status {
        Status::Active => std::io::println("Active!"),
        _ => std::io::println("Inactive or Pending!")
    };
}
```

### Matching Integer Literals

`match` can also branch directly on integer values, including hex and binary literals. This is especially useful when working with status codes, bitmasks, or hardware registers where those bases are more readable than decimal.

```wyzer
fn main() {
    // Matching against hex literals
    let status: u32 = 0xFF;
    match (status) {
        0x00 => std::io::println("no error"),
        0xFF => std::io::println("all flags set"),
        _    => std::io::println("other")
    };

    // Matching against binary literals
    let flags: u8 = 0b1010u8;
    match (flags) {
        0b0000 => std::io::println("all clear"),
        0b1010 => std::io::println("bits 1 and 3 set"),
        _      => std::io::println("other pattern")
    };
}
```

Decimal, hex, and binary literals are interchangeable in match arms — `0xFF`, `255`, and `0b11111111` all match the same value.

## Loops
Wyzer has basic loops to repeat code.

**While Loop:**
```wyzer
fn main() {
    var count: u32 = 0u32;
    while count < 3u32 {
        std::io::println(count);
        count = count + 1u32;
    }
}
```

**For Loop:** (Basic version)
```wyzer
fn main() {
    for _ in 5u32 {
        std::io::println("This prints 5 times");
    }
}
```
