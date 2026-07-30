# 9. Generics (Code That Works With Anything)

Sometimes, you want to write a function or a struct that can hold *any* type of data, not just one specific type like `u32` or `str`. 

For example, imagine a box. You can put a number in a box, or you can put a word in a box. The box itself works exactly the same way regardless of what is inside.

In Wyzer, this is called a **Generic**. 

## The `generic` Keyword

To make something generic, you just put the `generic<T>` tag completely outside and in front of the definition! `T` is just a placeholder name that means "Type".

```wyzer
// A struct that can hold anything!
generic<T> struct Box {
    item: T
}
```

Because the `generic` tag is on the outside, you don't have to ruin the beautiful look of your struct! 

You can do the exact same thing for functions:

```wyzer
// A function that takes any type and just returns it!
generic<T> fn return_my_item(my_item: T) -> T {
    return my_item;
}
```

## Using Generics

When you actually want to *use* the box, you have to tell Wyzer what you are putting inside. You do this by putting the `generic` tag in front of the name again!

```wyzer
fn main() {
    // We are making a Box that holds a u32 number
    let my_number_box: generic<u32> Box = generic<u32> Box { item: 42u32 };

    // We are making a Box that holds a string
    let my_word_box: generic<str> Box = generic<str> Box { item: "Hello" };
}
```

It's that simple! One simple tag (`generic<T>`) applied to the front of any declaration or usage gives you the power to reuse code for any data type.
