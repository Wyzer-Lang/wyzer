# 5. Memory Model

Wyzer manages memory for you, but it does not use a Garbage Collector. This means your program never stops randomly to clean up memory. It is fast and predictable.

## How it Works
1. **Automatic Tracking**: The compiler counts how many times your complex data (like structs) is used.
2. **Perfect Timing**: The exact moment your variable is no longer needed, the compiler deletes it. You do not have to write manual cleanup code.
3. **No Pauses**: Memory is freed instantly as the program runs. 

## In-Place Mutation
This is Wyzer's best trick. Because the compiler knows exactly when data is used, it can safely reuse memory instead of asking for more.

If you update a variable, and the compiler sees that no one else is using it, it will overwrite the old memory directly!

```wyzer
struct Point { x: u32, y: u32 }

fn main() {
    var p: Point = Point { x: 10u32, y: 20u32 };
    
    // The compiler knows 'p' is never used again after this.
    // Instead of asking for new memory, it overwrites 'p' directly!
    var p2: Point = Point { x: 100u32, y: p.y };
}
```

This lets you write simple code that runs as fast as if you managed the memory yourself.
