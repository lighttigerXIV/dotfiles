//! A library for newline character converting.
//!
//! # Examples
//!
//! Using the extension trait:
//!
//! ```
//! use newline_converter::AsRefStrExt;
//! assert_eq!("foo\r\nbar", "foo\nbar".to_dos());
//! ```
//!
//! ```
//! use newline_converter::AsRefStrExt;
//! assert_eq!("foo\nbar", "foo\r\nbar".to_unix());
//! ```
//!
//! Using conversion functions directly:
//!
//! ```
//! assert_eq!("foo\r\nbar", newline_converter::unix2dos("foo\nbar"));
//! ```
//!
//! ```
//! assert_eq!("foo\nbar", newline_converter::dos2unix("foo\r\nbar"));
//! ```
//!
//! The conversion functions are **lazy** - they don't perform any allocations if the input is already in correct format.

#![deny(missing_docs)]
#![deny(clippy::unwrap_used)]
#![deny(clippy::expect_used)]

use std::borrow::Cow;
use unicode_segmentation::UnicodeSegmentation;

const UNPACK_MSG: &str = "Grapheme should always be found -- Please file a bug report";

/// Converts DOS-style line endings (`\r\n`) to UNIX-style (`\n`).
///
/// The input string may already be in correct format, so this function
/// returns `Cow<str>`, to avoid unnecessary allocation and copying.
///
/// # Examples
/// ```
/// assert_eq!(newline_converter::dos2unix("\r\nfoo\r\nbar\r\n"), "\nfoo\nbar\n");
/// ```
///
/// Lone `\r` bytes will be preserved:
/// ```
///  assert_eq!(
///    newline_converter::dos2unix("\nfoo\rbar\r\n"),
///    "\nfoo\rbar\n"
///  );
/// ```
pub fn dos2unix<T: AsRef<str> + ?Sized>(input: &T) -> Cow<str> {
    let mut iter = input.as_ref().chars().peekable();

    let input = input.as_ref();
    let mut output: Option<String> = None;

    while let Some(current) = iter.next() {
        if '\r' == current {
            if let Some('\n') = iter.peek() {
                // drop it
                if output.is_none() {
                    let n = input.chars().filter(|x| *x == '\r').count();
                    let mut buffer = String::with_capacity(input.len() - n);
                    let i = input
                        .grapheme_indices(true)
                        .find(|(_, x)| *x == "\r\n")
                        .map_or_else(|| unreachable!("{}", UNPACK_MSG), |(i, _)| i);
                    let (past, _) = input.split_at(i);
                    buffer.push_str(past);
                    output = Some(buffer);
                }
                continue;
            }
        }
        if let Some(o) = output.as_mut() {
            o.push(current);
        }
    }

    match output {
        None => Cow::Borrowed(input),
        Some(o) => Cow::Owned(o),
    }
}

#[allow(clippy::match_like_matches_macro)] // MSRV 1.38, matches! macro available in 1.42
/// Converts UNIX-style line endings (`\n`) to DOS-style (`\r\n`).
///
/// The input string may already be in correct format, so this function
/// returns `Cow<str>`, to avoid unnecessary allocation and copying.
///
/// # Examples
/// ```
/// assert_eq!(newline_converter::unix2dos("\nfoo\nbar\n"), "\r\nfoo\r\nbar\r\n");
/// ```
///
/// Already present DOS line breaks are respected:
/// ```
/// assert_eq!(newline_converter::unix2dos("\nfoo\r\nbar\n"), "\r\nfoo\r\nbar\r\n");
/// ```
pub fn unix2dos<T: AsRef<str> + ?Sized>(input: &T) -> Cow<str> {
    let mut output: Option<String> = None;
    let mut last_char: Option<char> = None;

    let input = input.as_ref();
    for (i, current) in input.chars().enumerate() {
        if '\n' == current
            && (i == 0
                || match last_char {
                    Some('\r') => false,
                    _ => true,
                })
        {
            if output.is_none() {
                let n = input.chars().filter(|x| *x == '\n').count();
                let mut buffer = String::with_capacity(input.len() + n);
                let i = input
                    .grapheme_indices(true)
                    .find(|(_, x)| *x == "\n")
                    .map_or_else(|| unreachable!("{}", UNPACK_MSG), |(i, _)| i);
                let (past, _) = input.split_at(i);
                buffer.push_str(past);
                output = Some(buffer);
            }
            match output.as_mut() {
                Some(o) => o.push('\r'),
                None => unreachable!(),
            }
        }
        last_char = Some(current);

        if let Some(o) = output.as_mut() {
            o.push(current);
        }
    }

    match output {
        Some(o) => Cow::Owned(o),
        None => Cow::Borrowed(input),
    }
}

/// Extension trait for converting between DOS and UNIX linebreaks.
pub trait AsRefStrExt {
    /// Converts linebreaks to DOS (`\r\n`). See [`unix2dos`] for more info.
    ///
    /// # Examples
    ///
    /// ```
    /// use newline_converter::AsRefStrExt;
    /// assert_eq!("foo\r\nbar", "foo\nbar".to_dos());
    /// ```
    fn to_dos(&self) -> Cow<str>;

    /// Converts linebreaks to UNIX (`\n`). See [`dos2unix`] for more info.
    ///
    /// # Examples
    ///
    /// ```
    /// use newline_converter::AsRefStrExt;
    /// assert_eq!("foo\nbar", "foo\r\nbar".to_unix());
    /// ```
    fn to_unix(&self) -> Cow<str>;
}

impl<T> AsRefStrExt for T
where
    T: AsRef<str>,
{
    fn to_dos(&self) -> Cow<str> {
        unix2dos(self)
    }

    fn to_unix(&self) -> Cow<str> {
        dos2unix(self)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use quickcheck::{quickcheck, TestResult};

    #[test]
    fn middle() {
        assert_eq!(dos2unix("foo\r\nbar"), "foo\nbar".to_dos().to_unix());
        assert_eq!(unix2dos("foo\nbar"), "foo\r\nbar");
    }

    #[test]
    fn beginning() {
        assert_eq!(dos2unix("\r\nfoobar"), "\nfoobar");
        assert_eq!(unix2dos("\nfoobar"), "\r\nfoobar");
    }

    #[test]
    fn end() {
        assert_eq!(dos2unix("foobar\r\n"), "foobar\n");
        assert_eq!(unix2dos("foobar\n"), "foobar\r\n");
    }

    #[test]
    fn all() {
        assert_eq!(dos2unix("\r\nfoo\r\nbar\r\n"), "\nfoo\nbar\n");
        assert_eq!(unix2dos("\nfoo\nbar\n"), "\r\nfoo\r\nbar\r\n");
    }

    #[test]
    fn advanced() {
        assert_eq!(unix2dos("\rfoo\r\nbar\n"), "\rfoo\r\nbar\r\n");
        assert_eq!(dos2unix("\nfoo\rbar\r\n"), "\nfoo\rbar\n");
    }

    #[test]
    fn not_mutated_dos2unix() {
        let converted = dos2unix("\nfoo\nbar\n");
        assert_eq!(converted, Cow::Borrowed("\nfoo\nbar\n") as Cow<str>);
    }

    #[test]
    fn mutated_dos2unix() {
        let converted = dos2unix("\r\nfoo\r\nbar\r\n");
        assert_eq!(
            converted,
            Cow::Owned(String::from("\nfoo\nbar\n")) as Cow<str>
        );
    }

    #[test]
    fn not_mutated_unix2dos() {
        let converted = unix2dos("\r\nfoo\r\nbar\r\n");
        assert_eq!(converted, Cow::Borrowed("\r\nfoo\r\nbar\r\n") as Cow<str>);
    }

    #[test]
    fn mutated_unix2dos() {
        let converted = unix2dos("\nfoo\nbar\n");
        assert_eq!(
            converted,
            Cow::Owned(String::from("\r\nfoo\r\nbar\r\n")) as Cow<str>
        );
    }

    #[test]
    fn non_ascii_characters_unix2dos() {
        assert_eq!(
            unix2dos("Zażółć\ngęślą\njaźń\n"),
            "Zażółć\r\ngęślą\r\njaźń\r\n"
        );
    }

    #[test]
    fn non_ascii_characters_dos2unix() {
        assert_eq!(
            dos2unix("Zażółć\r\ngęślą\r\njaźń\r\n"),
            "Zażółć\ngęślą\njaźń\n"
        );
    }

    #[test]
    // https://github.com/spitfire05/rnc/issues/14
    fn panics_in_0_2_1_unix2dos() {
        assert_eq!(unix2dos("ä\n"), "ä\r\n");
    }

    #[test]
    // https://github.com/spitfire05/rnc/issues/14
    fn panics_in_0_2_1_dos2unix() {
        assert_eq!(dos2unix("ä\r\n"), "ä\n");
    }

    #[test]
    fn just_linebreak_dos2unix() {
        assert_eq!(dos2unix("\r\n"), "\n");
    }

    #[test]
    fn just_linebreak_unix2dos() {
        assert_eq!(unix2dos("\n"), "\r\n");
    }

    quickcheck! {
        fn dos_unix_dos(data: String) -> TestResult {
            if data.contains("\r\n") {
                return TestResult::discard();
            }

            TestResult::from_bool(data.replace('\n', "\r\n") == unix2dos(&dos2unix(&data)))
        }

        fn unix_dos_unix(data: String) -> bool {
            data.replace("\r\n", "\n") == dos2unix(&unix2dos(&data))
        }

        fn unix_contains_no_crlf(data: String) -> bool {
            !dos2unix(&data).contains("\r\n")
        }

        fn dos_has_no_lf_without_cr(data: String) -> bool {
            let dos = unix2dos(&data);
            let crlf = dos.graphemes(true).filter(|x| *x == "\r\n").count();
            let lf = dos.chars().filter(|x| *x == '\n').count();

            lf == crlf
        }

        fn to_unix_equals_dos2unix(data: String) -> bool {
            dos2unix(&data) == data.to_unix()
        }

        fn to_dos_equals_unix2dos(data: String) -> bool {
            unix2dos(&data) == data.to_dos()
        }
    }
}
