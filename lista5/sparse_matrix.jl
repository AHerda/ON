# Author: Adrian Herda 268449

module SparseMatrix
	export SparseMatrixMy, SparseMatrixPlus, generate_rhs_vector, get_columns,
		get_first_column, get_last_column, get_rows,
		get_first_row, get_last_row

	using SparseArrays

	"""
	Structure representing sparse matrix.
	It contains size of matrix, size of submatrices and dictionary of values.
	"""
	mutable struct SparseMatrixMy
		n::UInt64
		l::UInt64
		data::Dict{Tuple{UInt64, UInt64}, Float64}
		operations::UInt64
	end
	mutable struct SparseMatrixPlus
		n::UInt64
		l::UInt64
		data::SparseMatrixCSC{Float64, UInt64}
		operations::UInt64
	end

	"""
	Constructor for SparseMatrixMy type.
	## Input:
		n - size of matrix
		l - size of submatrices
	"""
	function SparseMatrixMy(n::UInt64, l::UInt64) :: SparseMatrixMy
		SparseMatrixMy(n, l, Dict{Tuple{UInt64, UInt64}, Float64}(), 0)
	end

	"""
	Constructor for SparseMatrixPlus type.
	## Input:
		n - size of matrix
		l - size of submatrices
	"""
	function SparseMatrixPlus(n::UInt64, l::UInt64, A::SparseMatrixCSC{Float64, UInt64}) :: SparseMatrixMy
		SparseMatrixPlus(n, l, A, 0)
	end


	function Base.setindex!(X::SparseMatrixMy, v::Float64, i::UInt64, j::UInt64)
		if v == 0.0
			delete!(X.data, (i, j))
		else
			X.data[(i, j)] = v
		end
		X.operations += 1
	end
	function Base.setindex!(X::SparseMatrixPlus, v::Float64, i::UInt64, j::UInt64)
		X.data[i, j] = v
		X.operations += 1
	end

	function Base.getindex(X::SparseMatrixMy, i::UInt64, j::UInt64) :: Float64
		X.operations += 1
		return get(X.data, (i, j), 0.0)
	end
	function Base.getindex(X::SparseMatrixPlus, i::UInt64, j::UInt64) :: Float64
		X.operations += 1
		return X.data[i, j]
	end

	"""
	Generates the right-hand side vector for a given sparse matrix `A` if the vector 'x' is all ones.

	# Input:
		A - The sparse matrix for which the right-hand side vector is generated.

	# Output:
		b - The generated right-hand side vector.
	"""
	function generate_rhs_vector(A) :: Vector{Float64}
		n = A.n
		b = zeros(n)

		for i in 1 : n
			for j in get_columns(A, i)
				b[i] += A[i, j]
			end
		end
		return b
	end

	function get_columns(A, row::UInt64)
		return get_first_column(A, row) : get_last_column(A, row)
	end

	function get_first_column(A, row::UInt64)
		return max(1, row - ((row - 1) % A.l) - 1)
	end

	function get_last_column(A, row::UInt64)
		return min(A.n, A.l + row)
	end

	function get_rows(A, column::UInt64)
		return get_first_row(A, column) : get_last_row(A, column)
	end

	function get_first_row(A, column::UInt64)
		return max(1, column - A.l)
	end

	function get_last_row(A, column::UInt64)
		return min(A.n, column + A.l - (column % A.l))
	end
end # module SparseMatrix
