function noonn(; 
    interface=AbstractAlgebra, 
    base_ring=interface.QQ, 
    ordering=:degrevlex
)
    without(x, k) = x[1:end .!= k]

    R, xs = interface.polynomial_ring(base_ring, ["x$i" for i in 1:n], internal_ordering=ordering)
    fs = zeros(R, n)
    for i in 1:n
        other = without(xs, i)
        fs[i] = xs[i] * (10 * sum(other .^ 2) - 11) + 10
    end
    fs
end
