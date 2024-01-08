# Author: Adrian Herda 268449

include("file.jl")

module blocksys
	export solve_gauss, solve_gauss_with_pivot, solve_LU, solve_LU_with_pivot

	using ..SparseMatrix: SparseMatrixMy, generate_rhs_vector, get_last_row, get_last_column, get_first_column
	using ..File: loadMatrixMy, loadVector, writeVector

	"""
	Solves system of linear equations using Gauss elimination method.

	## Input:
		A - matrix
		b - rhs vector

	## Output:
		x - solution
	"""
	function solve_gauss(A, b::Vector{Float64}) :: Vector{Float64}
		n = A.n
		x = zeros(n)

		for k in 1 : n-1
			for i in k+1 : get_last_row(A, k)
				if A[k, k] == 0.0
					error("Wartość na przekątnej jest równa 0")
					println("Wartość na przekątnej jest równa 0")
					return
				end

				temp = A[i, k] / A[k, k]
				A[i, k] = 0.0

				for j in k+1 : get_last_column(A, k)
					A[i, j] -= temp * A[k, j]
				end

				b[i] -= temp * b[k]
			end
		end

		x[n] = b[n] / A[n, n]
		for i in n-1 : -1 : 1
			x[i] = b[i]

			for j in i+1 : get_last_column(A, i)
				x[i] -= A[i, j] * x[j]
			end

			x[i] /= A[i, i]
		end

		return x
	end # function solve_gauss

	"""
	Solves system of linear equations using Gauss elimination method with pivot.

	## Input:
		A - matrix
		b - rhs vector

	## Output:
		x - solution
	"""
	function solve_gauss_with_pivot(A, b::Vector{Float64}) :: Vector{Float64}
		n = A.n
		l = A.l
		pivots = [1:n;]
		x = zeros(n)

		for k in 1 : n-1
			loop_end = get_last_row(A, k)
			last_row = 0
			last_column = 0

			for i in k : loop_end
				if abs(A[pivots[i], k]) > last_column
					last_column = abs(A[pivots[i], k])
					last_row = i
				end
			end

			pivots[k], pivots[last_row] = pivots[last_row], pivots[k]

			for i in k+1 : loop_end
				temp = A[pivots[i], k] / A[pivots[k], k]
				A[pivots[i], k] = 0.0

				for j in k+1 : get_last_column(A, k + l)
					A[pivots[i], j] -= temp * A[pivots[k], j]
				end

				b[pivots[i]] -= temp * b[pivots[k]]
			end
		end

		x[n] = b[pivots[n]] / A[pivots[n], n]

		for i in n-1 : -1 : 1
			sum = 0.0

			for j in i+1 : get_last_column(A, i + l)
				sum += A[pivots[i], j] * x[j]
			end

			x[i] = (b[pivots[i]] - sum) / A[pivots[i], i]
		end
		return x
	end # function solve_gauss_with_pivot

	"""
	Performs LU decomposition of a given matrix.
	Changes the matrix A.

	## Input:
		A - matrix
	"""
	function lu(A)
		n = A.n

		for k in 1 : n-1
			for i in k+1 : get_last_row(A, k)
				if A[k, k] == 0.0
					error("Wartość na przekątnej jest równa 0")
					println("Wartość na przekątnej jest równa 0")
					return
				end

				temp = A[i, k] / A[k, k]
				A[i, k] = temp

				for j in k+1 : get_last_column(A, k)
					A[i, j] -= temp * A[k, j]
				end
			end
		end
	end # function lu_decomposition

	"""
	Solves system of linear equations using LU decomposition.

	## Input:
		A - matrix
		b - rhs vector

	## Output:
		x - solution
	"""
	function solve_LU(A, b::Vector{Float64}) :: Vector{Float64}
		n = A.n
		x = zeros(n)
		lu(A)

		for k in 1 : n - 1
			for i in k + 1 : get_last_row(A, k)
				b[i] -= A[i, k] * b[k]
			end
		end

		for i in n : -1 : 1
			x[i] = b[i]

			for j in i+1 : get_last_column(A, i)
				x[i] -= A[i, j] * x[j]
			end

			x[i] /= A[i, i]
		end

		return x
	end # function solve_LU

	"""
	Performs LU decomposition of a given matrix with pivot.
	Changes the matrix A.

	## Input:
		A - matrix

	## Output:
		pivots - vector of pivots
	"""
	function lu_with_pivots(A) :: Vector{UInt64}
		n = A.n
		l = A.l
		pivots = [1:n;]

		for k in 1 : n-1
			loop_end = get_last_row(A, k)
			last_row = 0
			last_column = 0

			for i in k : loop_end
				if abs(A[pivots[i], k]) > last_column
					last_column = abs(A[pivots[i], k])
					last_row = i
				end
			end

			pivots[k], pivots[last_row] = pivots[last_row], pivots[k]

			for i in k+1 : loop_end
				temp = A[pivots[i], k] / A[pivots[k], k]
				A[pivots[i], k] = temp

				for j in k+1 : get_last_column(A, k + l)
					A[pivots[i], j] -= temp * A[pivots[k], j]
				end
			end
		end

		return pivots
	end	# function LU_with_pivots

	"""
	Solves system of linear equations using LU decomposition with pivot.

	## Input:
		A - matrix
		b - rhs vector

	## Output:
		x - solution
	"""
	function solve_LU_with_pivot(A, b::Vector{Float64}) :: Vector{Float64}
		n = A.n
		l = A.l
		x = zeros(n)

		pivots = lu_with_pivots(A)

		for i in 2 : n
			for j in get_first_column(A, pivots[i]) : i - 1
				b[pivots[i]] -= A[pivots[i], j] * b[pivots[j]]
			end
		end

		x[n] = b[pivots[n]] / A[pivots[n], n]
		for i in n-1 : -1 : 1
			x[i] = b[pivots[i]]
			for j in i+1 : get_last_column(A, i + l)
				x[i] -= A[pivots[i], j] * x[j]
			end
			x[i] /= A[pivots[i], i]
		end

		return x
	end # function solve_LU_with_pivot

end # function module blocksys
