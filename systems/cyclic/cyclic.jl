function cyclicn(
    n; 
    interface=AbstractAlgebra, 
    base_ring=interface.QQ, 
    ordering=:degrevlex
)
    _, z = interface.polynomial_ring(base_ring, ["z$i" for i in 1:n], internal_ordering=ordering)
    [
        (
            sum(prod(z[(k - 1) % n + 1] for k in j:(j + m)) for j in 1:n) for m in 0:(n - 2)
        )...,
        prod(z) - 1
    ]
end
