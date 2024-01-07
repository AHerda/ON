include("matrixgen.jl")
include("blocksys.jl")

using .File: loadMatrixMy, loadVector, writeVector
using .matrixgen: blockmat
using .blocksys: solve_gauss, solve_gauss2, lu_decomposition
using .SparseMatrix: SparseMatrixMy, generate_rhs_vector, generate_rhs


(A, n, l) = loadMatrixMy("dane/Dane50000_1_1/A.txt")
b = generate_rhs_vector(A)

# println("b1 = ", b)
# println("b2 = ", b2)

# x = solve_gauss(A, b)
# println("x = ", x)

stat1 = @timed x = solve_gauss(A, b)
stat2 = @timed x = solve_gauss2(A, b)
# println("x = ", x)

println("Czas rozwiązania układu równań metodą Gaussa: ", stat1[2])
println("Czas rozwiązania układu równań metodą Gaussa2: ", stat2[2])
