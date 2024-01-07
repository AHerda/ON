# Author: Adrian Herda 268449

module SparseMatrix

	export SparseMatrixMy, setvalue!, getvalue!, generate_rhs_vector, generate_rhs, get_columns

	"""
	Structure representing sparse matrix.
	It contains size of matrix, size of submatrices and dictionary of values.
	"""
	struct SparseMatrixMy
		n::UInt64
		l::UInt32
		data::Dict{Tuple{UInt64, UInt64}, Float64}
	end

	"""
	Constructor for SparseMatrixMy type.
	## Input:
		n - size of matrix
		l - size of submatrices
	"""
	function SparseMatrixMy(n::UInt64, l::UInt64) :: SparseMatrixMy
		SparseMatrixMy(n, l, Dict{Tuple{UInt64, UInt64}, Float64}())
	end

	"""
	Sets value of matrix at position (i, j).

	## Input:
		matrix - matrix to set value
		i - row index
		j - column index
		value - value to set
	"""
	function setvalue!(matrix::SparseMatrixMy, i::UInt64, j::UInt64, value::Float64)
		if value == 0.0
			delete!(matrix.data, (i, j))
		else
			matrix.data[(i, j)] = value
		end
	end

	"""
	Gets value of matrix at position (i, j).
	If position is out of bounds, returns 0.

	## Input:
		matrix - matrix to get value
		i - row index
		j - column index
	"""
	function getvalue!(matrix::SparseMatrixMy, i::UInt64, j::UInt64) :: Float64
		get(matrix.data, (i, j), 0.0)
	end

	"""
	Generates the right-hand side vector for a given sparse matrix `A` if the vector 'x' is all ones.

	# Input:
		A - The sparse matrix for which the right-hand side vector is generated.

	# Output:
		b - The generated right-hand side vector.
	"""
	function generate_rhs_vector(A::SparseMatrixMy) :: Vector{Float64}
		n = A.n
		b = zeros(n)

		for (i, j) in keys(A.data)
			b[i] += getvalue!(A, i, j)
		end

		return b
	end

	function generate_rhs(A::SparseMatrixMy)
		R = zeros(Float64, A.n)
		for i in 1:A.n
			for j in get_columns(A, i)
				R[i] += getvalue!(A, i, j)
			end
		end
		return R
	end

	function get_columns(M::SparseMatrixMy, row::UInt64)
		return get_first_column(M, row) : get_last_column(M, row)
	end

	function get_first_column(M::SparseMatrixMy, row::UInt64)
		return max(1, row - ((row - 1) % M.l) - 1)
	end

	function get_last_column(M::SparseMatrixMy, row::UInt64)
		return min(M.n, M.l + row)
	end

	function get_rows(M::SparseMatrixMy, column::UInt64)
		return get_top_row(M, column) : get_bottom_row(M, column)
	end

	function get_top_row(M::SparseMatrixMy, column::UInt64)
		return max(1, column - M.l)
	end

	function get_bottom_row(M::SparseMatrixMy, column::UInt64)
		return min(M.n, column + M.l - (column % M.l))
	end
end
