# Author: Adrian Herda 268449

include("matrixgen.jl")
include("blocksys.jl")

using .File: loadMatrixPlus, loadMatrixMy, loadVector, writeVector, relative_error
using .matrixgen: blockmat
using .blocksys: solve_gauss, solve_gauss_with_pivot, solve_LU, solve_LU_with_pivot
using .SparseMatrix: SparseMatrixMy, generate_rhs_vector


A = loadMatrixMy("dane/Dane500000_1_1/A.txt")
# A2 = loadMatrixPlus("dane/Dane500000_1_1/A.txt")

b = generate_rhs_vector(A)
# b2 = generate_rhs_vector(A2)
# println("b1 = ", b)
# println("b2 = ", b2)

# x = solve_gauss(A, b)
# println("x = ", x)

# stat1 = @timed solve_gauss(A, b)
# stat2 = @timed solve_gauss(A2, b)

stat1 = @timed solve_gauss_with_pivot(A, b)
# stat2 = @timed solve_gauss_with_pivot(A2, b)

# stat1 = @timed solve_LU(A, b)
# stat2 = @timed solve_LU(A2, b)

# stat1 = @timed solve_LU_with_pivot(A, b)
# stat2 = @timed solve_LU_with_pivot(A2, b)
# println("x = ", x)

println("Czas rozwiązania układu równań z SparseMatrixMy metodą Gaussa: ", stat1[2])
# println("Czas rozwiązania układu równań z SparseMatrixCSC metodą Gaussa: ", stat2[2])

println("Błąd względny rozweiązania układu równań z SparseMatrixMy: ", relative_error(stat1[1]))
# println("Błąd względny rozweiązania układu równań z SparseMatrixCSC: ", relative_error(stat2[1]))

return
