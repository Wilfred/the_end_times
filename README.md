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

Run on an AMD Phenom X4 965 with 4 GiB RAM with Linux x86_64 3.16.4.

| Language | Implementation | Time in seconds |
|----------|----------------|-------------:|
| Common Lisp | SBCL 1.2.2 | 12.049 |
| Go | Go 1.3.3 | 2.899 |
| Haskell | GHC 7.8.3 | 1.583 |
| Java | OpenJDK 1.7.0_71 | 19.618 |
| Julia | Julia 0.3.1 |  7.395 |
| PHP | PHP 5.6.2 | 438.732 |
| Python3 | CPython 3.4.2 | 4.568 |
| Python3 | pypy 2.3.1 | 8.881 |
| Ruby | JRuby 1.7.16 | 29.197 |
| Ruby | MRI 2.1.3p242 | 27.721 |
| Ruby | Rubinius 2.2.10 | 19.010 |
| Rust | Rust 0.12.0-dev | 11.793 |
| Scheme | Gambit 4.7.3 | 14.631 |
| Scheme | Guile 2.0.11 | 9.413 |
| Scheme | Racket 6.1 | 17.369 |

## License

Code is under the BSD license, and includes code originally from The
Computer Language Benchmarks Game.

