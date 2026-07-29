# 6. Enums and Choices

Sometimes a variable can only be a few specific things. For example, a traffic light can only be Red, Yellow, or Green. 

In Wyzer, you use an `enum` to make a list of choices.

Because Wyzer believes in "no hidden magic", there is only **one** way to declare an enum, and you must explicitly tell the compiler what type of numbers to use and how to calculate them.

You do this using an `iota` expression. `iota` represents the current step in the list!

## Standard Numbering

If you just want your choices to be numbered `0, 1, 2`, you simply pass `iota`:

```wyzer
enum TrafficLight: u8 (iota) {
    Red,    // iota is 0, so Red is 0
    Yellow, // iota is 1, so Yellow is 1
    Green   // iota is 2, so Green is 2
}
```

## Advanced Numbering

If you want to control the exact numbers, you can use math inside the parenthesis!

```wyzer
enum Flags: u8 (1 << iota) {
    Read,    // iota is 0, so 1 << 0 is 1
    Write,   // iota is 1, so 1 << 1 is 2
    Execute  // iota is 2, so 1 << 2 is 4
}
```

This exposes exactly how your data is represented underneath. The compiler calculates all the math before your program even runs, so it is extremely fast.

## Special Overrides

Sometimes, you need to break the pattern. Wyzer gives you two special tools for this so you don't mess up your counting:

1. **The Iota Override (`@=`)**: This lets you jump the `iota` counter to a brand new number. The sequence will continue counting from this new number.
2. **The Value Override (`$=`)**: This lets you hardcode the final value of a choice, completely ignoring the math! The `iota` counter silently counts up in the background so the next choice in the sequence isn't broken.

Here is an example of both in action:

```wyzer
enum Flags: u8 (1 << iota) {
   Read,          // iota=0, math: 1<<0 = 1
   Write,         // iota=1, math: 1<<1 = 2
   
   // We want Error to be 0, but we don't want to break the sequence!
   Error $= 0,    // Value Override: math is ignored! value is 0. (iota is still 2)
   
   Execute,       // iota=3, math: 1<<3 = 8 (The sequence resumes perfectly!)
   
   // We want to jump far ahead!
   Custom @= 5,   // Iota Override: iota jumps to 5. math: 1<<5 = 32
   Next           // iota=6, math: 1<<6 = 64
}
```

This ensures there is never any confusion between what the counter is doing and what the final value is!
