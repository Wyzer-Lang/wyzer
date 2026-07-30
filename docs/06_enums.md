# 6. Enums and Choices

Sometimes a variable can only be a few specific things. For example, a traffic light can only be Red, Yellow, or Green. Or a network message can be a Success (with data) or an Error (with an error message).

In Wyzer, you use an `enum` to make a list of choices. There are two ways to use them: **Number Enums** and **Data Enums**.

---

## 1. Data Enums (Enums with Data)

Often, you want a choice to carry extra information. For example, a network request might give you a `Message` that is either `Ok` (containing a number) or `Err` (containing text).

You can declare a Data Enum simply by listing the choices, and optionally putting types in parenthesis:

```wyzer
pub enum Message {
    Ok(u32),       // A choice that carries a number!
    Err(str),      // A choice that carries text!
    None           // A choice that carries nothing!
}
```

### Creating and Unpacking Data

You create these choices by using `::`, like `Message::Ok(42u32)`.

To read the data inside the choice, you use a `match` statement. A `match` statement checks which choice you have and "unpacks" the data into a new variable!

```wyzer
fn process(msg: Message) {
    match msg {
        Message::Ok(val) => {
            std::io::println("We got a value!");
            std::io::println(val); // 'val' holds the u32!
        },
        Message::Err(text) => {
            std::io::println("Uh oh, an error:");
            std::io::println(text); // 'text' holds the str!
        },
        Message::None => {
            std::io::println("We got nothing.");
        }
    }
}
```

Because Wyzer manages memory safely without garbage collection, when you "unpack" a choice (like `Message::Ok(val)`), you take full ownership of the `val`. The match statement automatically destroys the outer `Message` box and hands you the data directly.

---

## 2. Number Enums (C-Style Enums)

If you are doing low-level programming (like talking directly to hardware or C code), you might just want a simple list of numbers (like `0, 1, 2`). 

You can explicitly tell the compiler to create a "Number Enum" by putting a type (like `u8`) and a math formula (like `iota`) next to the name:

```wyzer
enum TrafficLight: u8 (iota) {
    Red,    // iota is 0, so Red is 0
    Yellow, // iota is 1, so Yellow is 1
    Green   // iota is 2, so Green is 2
}
```

`iota` is a special word that just means "the current step in the list". The first item is step 0, the next is step 1, and so on.

### Advanced Numbering

You can use math inside the parenthesis to control the exact numbers!

```wyzer
enum Flags: u8 (1 << iota) {
    Read,    // iota is 0, so 1 << 0 is 1
    Write,   // iota is 1, so 1 << 1 is 2
    Execute  // iota is 2, so 1 << 2 is 4
}
```

This lets you create bit-flags instantly. The compiler calculates all the math before your program even runs, so it is extremely fast.

### Special Number Overrides

Sometimes you need to break the pattern. Wyzer gives you two special tools so you don't mess up your counting:

1. **The Iota Override (`@=`)**: This changes what step you are on. You can jump ahead to step 5, for example.
2. **The Value Override (`$=`)**: This lets you hardcode a specific number for a choice, completely ignoring the math! The `iota` step counter silently counts up in the background so the next choice isn't broken.

```wyzer
enum Flags: u8 (1 << iota) {
   Read,          // step=0, math: 1<<0 = 1
   Write,         // step=1, math: 1<<1 = 2
   
   // We want Error to be 0, but we don't want to break the sequence!
   Error $= 0,    // Value Override: math is ignored! value is 0. (step is still 2)
   
   Execute,       // step=3, math: 1<<3 = 8 (The sequence resumes perfectly!)
   
   // We want to jump far ahead! We can use the current step in our override!
   // @= runs first, so step becomes 4+2=6. Then the math runs: 1<<6 = 64
   Custom @= (iota + 2), 
   Next           // step=7, math: 1<<7 = 128
}
```

This ensures there is never any confusion between what the counter is doing and what the final value is!
