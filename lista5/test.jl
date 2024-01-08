# Author: Adrian Herda 268449

include("matrixgen.jl")
include("blocksys.jl")

using .blocksys: solve_gauss, solve_gauss_with_pivot, solve_LU, solve_LU_with_pivot
using .File: loadMatrixMy, loadMatrixPlus, loadVector, writeVector
using Test

n_list = [16, 10000, 50000, 100000, 300000]

for i in eachindex(n_list)
    test = n_list[i]
    @testset "Moja struktura Dane$(test)_1_1" begin
		matrix = loadMatrixMy("dane/Dane$(test)_1_1/A.txt")
		vec = loadVector("dane/Dane$(test)_1_1/b.txt")
		results = ones(n_list[i])

		@test isapprox(solve_gauss(deepcopy(matrix), deepcopy(vec[1])), results)
		@test isapprox(solve_gauss_with_pivot(deepcopy(matrix), deepcopy(vec[1])), results)
		@test isapprox(solve_LU(deepcopy(matrix), deepcopy(vec[1])), results)
		@test isapprox(solve_LU_with_pivot(deepcopy(matrix), deepcopy(vec[1])), results)
    end

	@testset "SparseMatrixCSC Dane$(test)_1_1" begin
		matrix = loadMatrixPlus("dane/Dane$(test)_1_1/A.txt")
		vec = loadVector("dane/Dane$(test)_1_1/b.txt")
		results = ones(n_list[i])

		@test isapprox(solve_gauss(deepcopy(matrix), deepcopy(vec[1])), results)
		@test isapprox(solve_gauss_with_pivot(deepcopy(matrix), deepcopy(vec[1])), results)
		@test isapprox(solve_LU(deepcopy(matrix), deepcopy(vec[1])), results)
		@test isapprox(solve_LU_with_pivot(deepcopy(matrix), deepcopy(vec[1])), results)
    end
end
