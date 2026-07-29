# 4. Functions and Structs

## Functions
You make a function by writing `fn`. You must write the type for every input and output. This makes the code very easy to read.

```wyzer
fn add(a: u32, b: u32) -> u32 {
    a + b
}
```
There is no `return` keyword. A function automatically returns the final value in the block.

If a function does not return anything, you can just leave out the `-> type` part.

```wyzer
fn log_message(msg: str) {
    std::io::println(msg);
}
```

## Structs
Structs are how you build your own data types.

```wyzer
struct Point {
    x: u32,
    y: u32
}

fn main() {
    // Creating a struct
    var p: Point = Point { x: 10u32, y: 20u32 };
    
    // Reading a field
    std::io::println(p.x);
    
    // Modifying (allowed because we used 'var')
    p = Point { x: 15u32, y: p.y };
}
```

*Note: Structs are managed safely by Wyzer's automatic memory system.*
