function katsuran(
    n; 
    interface=AbstractAlgebra, 
    base_ring=interface.QQ, 
    ordering=:degrevlex
)
    _, x = interface.polynomial_ring(base_ring, ["x$i" for i in 0:n], internal_ordering=ordering)
    [
        (
            sum(x[abs(l) + 1] * x[abs(m - l) + 1] for l = (-n):n if abs(m - l) <= n) -
            x[m + 1] for m in 0:(n - 1)
        )...,
        x[1] + 2sum(x[i + 1] for i in 1:n) - 1
    ]
end
