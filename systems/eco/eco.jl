function econ(
    n; 
    interface=AbstractAlgebra, 
    base_ring=interface.QQ, 
    ordering=:degrevlex
)
	_, x = polynomial_ring(base_ring, ["x$i" for i in 1:n], internal_ordering=ordering)
	vcat(
		[
			x[n]*(x[k] + sum(x[1:n-k-1] .* x[1+k:n-1]; init=0)) - k
			for k in 1:n-1
		],
		sum(x[1:n-1]; init=0) + 1
    )
end
