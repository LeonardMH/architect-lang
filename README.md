# (Archived) Architect Programming Language

This was a toy programming language concept I was working on which was targeted
at embedded systems development. It is not a working concept and it is not
something I'm even thinking about anymore but there are still some possibly
interesting ideas here that I didn't want to just throw away so here it is.

Core language features were inspired by the strong type system and safety
features of rust while the syntax was moving toward some blend of
[Rust][rust-lang] and [Python][python-lang] (two languages I very much admire) +
some unique features of its own.

## Like what unique features?

The list is short, but:

- No magic, nearly everything is opt in 
- `external` keyword to explicitly mark outside system access (outside of CPU I
   guess?), roughly inspired by the `unsafe` keyword in rust, though with a
   decidedly different purpose.
- Unique variable typing-naming system (described more thoroughly below, this
  is probably the most thought through idea in the langage).

## Why is it dead?

I'm not a lanuage expert and don't have time or desire to carry this to
completion, but more importantly [rust-embedded][rust-embedded] is in a much
better place this year and will only continue to improve so my brain cycles
would be better spent contributing there than re-inventing the wheel with a new
pet language.

Looking back on this concept after a year of not looking at it, there are a
couple of ideas that stand out as either good or bad.

- (good) `external` keyword to explicitly mark outside system access
- (good) Iterator specification `0 to 10`, `0 to 10 by 2`, `0 to 10 if _ % 5 == 0`
- (good) Variable `type[type-info]:name` specification pattern is flexible, consistent, and
         relatively pleasant, for comparison with some C types:
    - `num[i,u,32]:myvar == uint32_t myvar;` (i=integer, u=unsigned, 32=32bit size)
    - `num[i,s,32]:myvar == int32_t myvar;` (s=signed)
    - `num[f,s,32]:myvar == float myvar;` (f=floating point, s=signed [reqd.])
    - `bool:is_set == bool is_set;`
    - `fn:a_fun == void a_fun(void);` (function w/o parameter or return)
    - `fn[num[i,u,32]]:a_fun = (p1) { == void a_fun(uint32_t p1) {` (function w parameter and no return, trailing brackets included to illustrate the p1 name tag assigned to parameter 1)
    - the below example

```
# architect
fn[num[i,u,32] -> bool]:a_fun = (p1) {
    p1 > 40  
}
```

vs.

```c
// c
bool a_fun(uint32_t p1) {
    return p1 > 40;
}
```

vs.

```rust
// rust
fn a_fun(p1: u32) -> bool {
    p1 > 40
}
```

vs.

```python
# python with type annotations, to be fair to the other languages
def a_fun(p1: int) -> bool:
    return p1 > 40

# python without type annotations, to be fair to python
def a_fun(p1):
    return p1 > 40
```

The architect example here is exemplary for type information density. *All* of
the type information is to the left of the colon, while *all* of the name
information is to the right of the colon whereas in every other example this
information is interspersed.

- (bad) Instantiation of custom type seems poorly thought out (see examples/types.ar)
- (bad) Comment style, I would prefer to go with rust/rustdoc comments than Python style
- (bad) Consistency of methods vs functions in standard library (see
        examples/lists.ar `reverse` and `accumulate` functions). In retrospect,
        I would prefer these to be `[0 to 10].reverse()` and
        `"CASE".accumulate()` instead. Essentially I prefer the rust style to
        the Python style here.
- (bad) The loop design could use more thought, particularly the `repeat` needs
        love, probably something like below would be better.

```
# a do while loop
repeat {
    index += 1
} (index < 10)

# an idiomatic infinite loop
repeat {
    external { writeln("Hello") }
}
```

[rust-lang]: https://www.rust-lang.org/en-US/
[rust-embedded]: https://beta.rust-lang.org/what/embedded
[python-lang]: https://www.python.org/
