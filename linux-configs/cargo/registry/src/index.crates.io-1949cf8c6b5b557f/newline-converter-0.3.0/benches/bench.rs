use std::borrow::Cow;

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use lazy_regex::{lazy_regex, Lazy};
use newline_converter::{dos2unix, unix2dos};

fn dos2unix_string_replace<T: AsRef<str> + ?Sized>(input: &T) -> String {
    input.as_ref().replace("\r\n", "\n")
}

fn unix2dos_string_replace<T: AsRef<str> + ?Sized>(input: &T) -> String {
    input.as_ref().replace("\n", "\r\n")
}

static RE_DOS: lazy_regex::Lazy<lazy_regex::Regex> = lazy_regex!("\r\n");
static RE_UNIX: lazy_regex::Lazy<lazy_regex::Regex> = lazy_regex!("\n");
static RE_UNIX_FANCY: Lazy<fancy_regex::Regex> =
    Lazy::new(|| fancy_regex::Regex::new("(?!\r)\n").unwrap());

fn dos2unix_regex<T: AsRef<str> + ?Sized>(input: &T) -> Cow<str> {
    RE_DOS.replace_all(input.as_ref(), "\n")
}

fn unix2dos_regex<T: AsRef<str> + ?Sized>(input: &T) -> Cow<str> {
    RE_UNIX.replace_all(input.as_ref(), "\r\n")
}

fn unix2dos_regex_fancy<T: AsRef<str> + ?Sized>(input: &T) -> Cow<str> {
    RE_UNIX_FANCY.replace_all(input.as_ref(), "\r\n")
}

const DOS_INPUT: &str = "\r\nfoo\r\nbar\r\n";
const UNIX_INPUT: &str = "\nfoo\nbar\n";

fn bench_dos2unix(c: &mut Criterion) {
    let mut group = c.benchmark_group("dos2unix");
    let i = DOS_INPUT;
    group.bench_with_input(BenchmarkId::new("newline-converter", ""), i, |b, i| {
        b.iter(|| dos2unix(i))
    });
    group.bench_with_input(BenchmarkId::new("string.replace", ""), i, |b, i| {
        b.iter(|| dos2unix_string_replace(i))
    });
    group.bench_with_input(BenchmarkId::new("regex", ""), i, |b, i| {
        b.iter(|| dos2unix_regex(i))
    });
    group.finish();
}

fn bench_dos2unix_noop(c: &mut Criterion) {
    let mut group = c.benchmark_group("dos2unix_noop");
    let i = UNIX_INPUT;
    group.bench_with_input(BenchmarkId::new("newline-converter", ""), i, |b, i| {
        b.iter(|| dos2unix(i))
    });
    group.bench_with_input(BenchmarkId::new("string.replace", ""), i, |b, i| {
        b.iter(|| dos2unix_string_replace(i))
    });
    group.bench_with_input(BenchmarkId::new("regex", ""), i, |b, i| {
        b.iter(|| dos2unix_regex(i))
    });
    group.finish();
}

fn bench_unix2dos(c: &mut Criterion) {
    let mut group = c.benchmark_group("unix2dos");
    let i = UNIX_INPUT;
    group.bench_with_input(BenchmarkId::new("newline-converter", ""), i, |b, i| {
        b.iter(|| unix2dos(i))
    });
    group.bench_with_input(BenchmarkId::new("string.replace", ""), i, |b, i| {
        b.iter(|| unix2dos_string_replace(i))
    });
    group.bench_with_input(BenchmarkId::new("regex", ""), i, |b, i| {
        b.iter(|| unix2dos_regex(i))
    });
    group.bench_with_input(BenchmarkId::new("fancy_regex", ""), i, |b, i| {
        b.iter(|| unix2dos_regex_fancy(i))
    });
    group.finish();
}

fn bench_unix2dos_noop(c: &mut Criterion) {
    let mut group = c.benchmark_group("unix2dos_noop");
    let i = DOS_INPUT;
    group.bench_with_input(BenchmarkId::new("newline-converter", ""), i, |b, i| {
        b.iter(|| unix2dos(i))
    });
    group.bench_with_input(BenchmarkId::new("string.replace", ""), i, |b, i| {
        b.iter(|| unix2dos_string_replace(i))
    });
    group.bench_with_input(BenchmarkId::new("regex", ""), i, |b, i| {
        b.iter(|| unix2dos_regex(i))
    });
    group.bench_with_input(BenchmarkId::new("fancy_regex", ""), i, |b, i| {
        b.iter(|| unix2dos_regex_fancy(i))
    });
    group.finish();
}

criterion_group!(
    benches,
    bench_dos2unix,
    bench_dos2unix_noop,
    bench_unix2dos,
    bench_unix2dos_noop
);
criterion_main!(benches);
