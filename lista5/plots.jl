# Author: Adrian Herda 268449

include("blocksys.jl")
include("matrixgen.jl")

using .matrixgen: blockmat
using .blocksys: solve_gauss, solve_gauss_with_pivot, solve_LU, solve_LU_with_pivot
using .File: loadMatrixMy, loadMatrixPlus, loadVector, writeVector
using .SparseMatrix: SparseMatrixMy, SparseMatrixPlus, generate_rhs_vector

using Plots
sizes = [1000, 10000, 20000, 40000, 60000, 80000]
# sizes = [1000, 10000, 20000, 30000, 40000, 50000]
# sizes = [1000, 2500, 5000, 7500, 10000, 15000]

test_no = length(sizes)
block_size = 10

struct Solution
    func::Function
    times::Vector{Float64}
    ops::Vector{Int}
    memory::Vector{Int}
end

solutions = [
    Solution(f, zeros(Float64, test_no), zeros(Int, test_no), zeros(Int, test_no))
    for f in [solve_gauss, solve_gauss_with_pivot, solve_LU, solve_LU_with_pivot]
            ]

blockmat(4, 2, 10., "test.txt")
A = loadMatrixMy("test.txt")
b = generate_rhs_vector(A)
for S in solutions
    stats = @timed S.func(deepcopy(A), deepcopy(b))
end

for (i, size) in enumerate(sizes)
    blockmat(size, block_size, 10., "test.txt")
    A = loadMatrixMy("test.txt")
    b = generate_rhs_vector(A)
    for S in solutions
        tempA = deepcopy(A)
        tempb = deepcopy(b)
        stats = @timed S.func(tempA, tempb)
        println("$size $(stats.time) $(tempA.operations) $(stats.bytes)")

		if size != 100000
			S.times[i] = stats.time
			S.ops[i] = tempA.operations
        	S.memory[i] = stats.bytes
		end
    end
end


pyplot()

plot(
    sizes,
    [S.times for S in solutions],
    title="Złożoność czasowa algorytmów",
    label=["Gauss" "Gauss z wyborem" "LU" "LU z wyborem"],
	left_margin=10Plots.mm,
	legend=:topleft,
	dpi=700
    )
savefig("plots/times.png")

plot(
    sizes,
    [S.ops for S in solutions],
    title="Złożoność obliczeniowa algorytmów",
    label=["Gauss" "Gauss z wyborem" "LU" "LU z wyborem"],
	left_margin=15Plots.mm,
	legend=:topleft,
	dpi=700
    )
savefig("plots/ops.png")

plot(
    sizes,
    [S.memory for S in solutions],
    title="Złożoność pamięciowa algorytmów",
    label=["Gauss" "Gauss z wyborem" "LU" "LU z wyborem"],
	left_margin=15Plots.mm,
	legend=:topleft,
	dpi=700
    )
savefig("plots/mem.png")
