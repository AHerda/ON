# Author: Adrian Herda 268449

module sparse_matrix

	export SparseMatrixMy, setvalue!, getvalue!

	"""
	Structure representing sparse matrix.
	It contains size of matrix, size of submatrices and dictionary of values.
	"""
	struct SparseMatrixMy
		n::UInt64
		l::UInt32
		data::Dict{Tuple{UInt64, UInt64}, Flaot64}
	end

	"""
	Constructor for SparseMatrix type.
	## Input:
		n - size of matrix
		l - size of submatrices
	"""
	function SparseMatrixMy(n::UInt64, l::UInt64)
		SparseMatrixMy(n, l, Dict{Tuple{UInt64, UInt64}, Flaot64}())
	end

	"""
	Sets value of matrix at position (i, j).

	## Input:
		matrix - matrix to set value
		i - row index
		j - column index
		value - value to set
	"""
	function setvalue!(matrix::SparseMatrixMy, i::UInt64, j::UInt64, value::Flaot64)
		matrix.data[(i, j)] = value
	end

	"""
	Gets value of matrix at position (i, j).
	If position is out of bounds, returns 0.

	## Input:
		matrix - matrix to get value
		i - row index
		j - column index
	"""
	function getvalue!(matrix::SparseMatrixMy, i::UInt64, j::UInt64)
		if i <= matrix.n && j <= matrix.n
			return get(matrix.data, (i, j), zero(Float64))
		else
			return zero(Float64)
		end
	end

end
