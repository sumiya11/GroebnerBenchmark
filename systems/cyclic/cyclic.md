### Cyclic-n

- Variables: n, dimension: -.
- Timings:
    - cyclic-10 modulo 2^30+3 in deg-rev-lex. 27 minutes using Groebner.jl with 16 threads on Intel i9-13900. GB has 5690 equations, with roughly 20e6 monomials, 37,136 unique monomials. Quotient size is 36,572,032. Seems to agree with [(1)](https://arxiv.org/abs/1903.12427). Reported by Alexander Demin.
- References:
    - Göran Björck and Ralf Fröberg:
    *A faster way to count the solutions of inhomogeneous systems
    of algebraic equations, with applications to cyclic n-roots*,
    in J. Symbolic Computation (1991) 12, pp 329--336, [doi](https://doi.org/10.1016/S0747-7171(08)80153-8).
- Sources:
    - [Julia](./systems/cyclic/cyclic.jl)
