# newline-converter
`newline-converter` is a simple library used for converting the newline characters in strings between Windows `\r\n` and Unix `\n` style. It mainly serves as a backend for [Rust Newline converter](https://github.com/spitfire05/rnc) CLI tool.

[![Crates.io](https://img.shields.io/crates/v/newline-converter)](https://crates.io/crates/newline-converter)

## Comparision of newline-wrangling methods

### newline-converter (this crate)

- ✅ Properly handles edge-cases like lone `\r` characters. For example, `\r\n` sequences won't become `\r\r\n` after `unix2dos`  call:
  ```rust
  use newline_converter::unix2dos;
  assert_eq!(
    unix2dos("\nfoo\r\nbar\n"),
    "\r\nfoo\rbar\n"
  );
  ```
- ✅ Is the fastest when input data is small (few bytes of text with line breaks).
- ❌ Is the slowest (or second slowest in case of `unix2dos`) when dealing with larger data sets (ex. 100 paragraphs of [Lorem Ipsum](https://www.lipsum.com/)).

### `string.replace`

- ❌ Does not handle edge cases properly in `unix2dos`.
- ✅ Good performance on larger data sets.

### [regex](https://crates.io/crates/regex) crate `Regex::replace_all`

- ❌ Does not handle edge cases properly in `unix2dos`, because of lack of support for look around.
- ✅ The best performance with larger data sets.

### [fancy-regex](https://crates.io/crates/fancy-regex) crate `Regex::replace_all`

- ✅ Properly handles edge cases.
- ❌ `unix2dos` has worst performance of all implementations, by an order of magnitude (because of look around used).

Look into `benches/bench.rs` for the comparision benchmarks.

## MSRV
Minimum Supported Rust Version is `1.38.0`.
