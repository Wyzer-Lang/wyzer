# 7. Foreign Code and Roles

In Wyzer, every piece of code belongs to a "Role". A Role is like a separate computer or a separate language that has its own memory. 

By default, all your code runs on the `Main` role.

## Talking to C (Foreign Function Interface)

If you want to use a function written in the C language, you can tell Wyzer that it exists on a different role called `C`.

```wyzer
extern fn write_file(path: str@C, content: str@C) @ C -> i32;
```

This tells the compiler: "There is a function called `write_file` on the `C` role. It expects strings that belong to the `C` role's memory."

## Transferring Data

Because the `Main` role and the `C` role have different memory, you cannot just pass a normal `Main` string into a `C` function. 

You must explicitly use `transfer` to move the data safely between roles. This proves to the compiler that you are not causing memory errors or crashes!

```wyzer
fn main() -> u32 {
    let my_file = "hello.txt";
    let my_text = "Hello world";

    // Transfer the strings to the C role so the C function can use them!
    write_file(transfer(my_file, C), transfer(my_text, C));

    return 0;
}
```

This makes talking to other languages just as safe as writing normal Wyzer code!
