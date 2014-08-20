# The End Times

A comparison of programming language implementation performance.

## Rules

* Each test program should implement the same algorithm.

* No FFI.

* No inline assembly (unless you're submitting an assembly test program!)

* No external libraries.

* Different language implementations (e.g. GCC and Clang) may have
  different test programs.

## How to run it

Check out the code, and run `run`.

     $ git clone git@github.com:Wilfred/the_end_times.git
     $ cd the_end_times
     $ ./run

You will need Python 2, and all the languages you are interested in testing.

## Preliminary Results

### Pidigits

Pidigits tests numeric performance for arbitrary sized integers.

| Language | Implementation | Time/seconds |
|----------|----------------|-------------:|
| Haskell | GHC | 1.582 |
| Python3 | CPython | 4.391 |
| Python3 | pypy | 6.505 |
| Ruby | JRuby | 26.803 |
| Ruby | MRI | 26.135 |
| Rust | Rust | 11.930 |
| Scheme | Racket | 16.837 |

## License

Code is under the BSD license, and includes code originally from The
Computer Language Benchmarks Game.

