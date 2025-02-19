### SIWR

SIWR model of cholera transmission, structural identifiability problem.

- Keywords: identifiability.
- Comments: 
    - 15 variables, dimension is 12, degree is --.
    - Let "y" be the first 8 variables in the ring.
    Equations in the system have a particular form: F(x) G(y) - F(y) G(x).
    As a system in Q[x, y], the dimension is 12.
    As a system in Q[x][y], the dimension is 0, and the GB is linear.
- References:
    - Ruiwen Dong, Christian Goodbrake, Heather A. Harrington, and Gleb Pogudin (2023), *Differential Elimination for Dynamical Models via Projections with Applications to Structural Identifiability*. In SIAM Journal on Applied Algebra and Geometry, 7(1) 194-235, [doi](https://doi.org/10.1137/22M1469067).
- Sources:
    - [siwr.jl](./systems/siwr/siwr.jl).
        Attached is the Julia script for producing the system's equations.
        A .txt file with the equations takes 20 MB, so we do not distribute it.
