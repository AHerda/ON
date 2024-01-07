# Author: Adrian Herda 268449

include("file.jl")

module blocksys
	export solve_gauss, solve_gauss2, lu_decomposition

	using ..SparseMatrix: SparseMatrixMy, setvalue!, getvalue!, generate_rhs_vector, get_bottom_row, get_last_column
	using ..File: loadMatrixMy, loadVector, writeVector

	"""
	Solves system of linear equations using Gauss elimination method.

	## Input:
		A - matrix of coefficients
		b - vector of free terms
		pivot - if true, uses partial pivoting

	## Output:
		x - vector of solutions
	"""
	function solve_gauss(A::SparseMatrixMy, b::Vector{Float64})
		n = A.n
		l = A.l
		x = zeros(n)

		for k in 1 : n-1
			for i in k+1 : get_bottom_row(A, k)
				if getvalue!(A, k, k) == 0.0
					error("Wartość na przekątnej jest równa 0")
					return
				end
				temp = getvalue!(A, i, k) / getvalue!(A, k, k)
				setvalue!(A, i, k, 0.0)

				for j in k+1 : get_last_column(A, k)
					setvalue!(A, i, j, getvalue!(A, i, j) - temp * getvalue!(A, k, j))
				end

				b[i] -= temp * b[k]
			end
		end

		for i in n : -1 : 1
			sum = 0.0

			for j in i+1:n
				sum += getvalue!(A, i, j) * x[i]
			end

			x[i] = (b[i] - sum) / getvalue!(A, i, i)
		end

		return x
	end # function solve_gauss

	function solve_gauss_with_pivot(A::SparseMatrixMy, b::Vector{Float64})
		n = size(A, 1)
		x = zeros(n)

		for k in 1 : n-1
			max = abs(A[k, k])
			max_index = k
			for i = k+1:n
				if abs(A[i, k]) > max
					max = abs(A[i, k])
					max_index = i
				end
			end
			if max_index != k
				for j = k:n
					temp = A[k, j]
					A[k, j] = A[max_index, j]
					A[max_index, j] = temp
				end
				temp = b[k]
				b[k] = b[max_index]
				b[max_index] = temp
			end
			for i = k+1:n
				factor = A[i, k] / A[k, k]
				A[i, k+1:end] -= factor * A[k, k+1:end]
				b[i] -= factor * b[k]
			end
		end

		for k = n:-1:1
			x[k] = (b[k] - dot(A[k, k+1:end], x[k+1:end])) / A[k, k]
		end

		return x
	end # function solve_gauss_with_pivot

	function lu_decomposition(A)
		n = size(A, 1)
		L = Matrix{Float64}(I, n, n)
		U = copy(A)
		for k = 1:n-1
			for i = k+1:n
				factor = U[i, k] / U[k, k]
				L[i, k] = factor
				U[i, k:end] -= factor * U[k, k:end]
			end
		end
		return L, U
	end # function lu_decomposition

end # function module blocksys
