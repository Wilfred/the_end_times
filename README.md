# The End Times

A comparison of programming language implementation performance. We
focus on the performance of the built-in primitives the language provides.

## Rules

* Each test program should implement the same algorithm.

* No FFI.

* No inline assembly (unless you're submitting an assembly test program!)

* No external libraries.

* No rolling your own datatypes. We're interested in the performance
  of those already provided.

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

GHC does really well here as it uses GMP underneath. Go's impressive
performance is due to some of the math/big library being written in
assembly. Julia also uses GMP, so I suspect there is low hanging fruit
in optimisations still.

CPython beats out pypy as
[pypy's JIT can't help in this benchmark](https://mail.python.org/pipermail/pypy-dev/2014-August/012713.html).

| Language | Implementation | Time/seconds |
|----------|----------------|-------------:|
| Common Lisp | SBCL | 11.635 |
| Go | Go | 2.956 |
| Julia | Julia |  5.790 |
| Haskell | GHC | 1.582 |
| Python3 | CPython | 4.391 |
| Python3 | pypy | 6.505 |
| Ruby | JRuby | 26.803 |
| Ruby | MRI | 26.135 |
| Rust | Rust | 11.930 |
| Scheme | Chicken | 8.181 |
| Scheme | Gambit | 13.763 |
| Scheme | Guile | 8.644 |
| Scheme | Racket | 16.837 |

## License

Code is under the BSD license, and includes code originally from The
Computer Language Benchmarks Game.

