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
