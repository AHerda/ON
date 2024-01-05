# Author: Adrian Herda 268449

include("sparese_matrix.jl")

module FileLoad

	export loadMatrix, loadVector

	using SparseArrays

	"""
	Reads matrix data from file.

	Parameters:
		filepath - path to input file

	Return:
	(A, n, l) - tuple:
		A - matrix;
		n - size of matrix A;
		l - size of submatrices
	"""
	function loadMatrix(filepath::String) :: Tuple{SparseMatrixCSC{Float64, Int64}, UInt64, UInt64}
		data = open(filepath, "r") do file
			sizes = split(readline(file), " ")
			n = parse(Int64, sizes[1])
			l = parse(Int64, sizes[2])

			columns = []
			rows = []
			values = []

			for line in eachline(file)
				temp = split(line, " ")
				push!(columns, parse(Int64, temp[1]))
				push!(rows, parse(Int64, temp[2]))
				push!(values, arse(Float64, temp[3]))
			end
			(sparse(rows, columns, values), n, l)
		end

		return data
	end # function loadMatrix


	"""
	Reads vector of right sides.

	Parameters:
		filepath - file path to input data.

	Return:
	(b, n) - tuple:
		b - vector of right sides;
		n - size of vector b
	"""
	function loadVector(filepath::String) :: Tuple{Vector{Float64}, UInt64}
		data = open(filepath, "r") do file
			n = parse(Int64, readline(file))

			b = []
			for line in eachline(file)
				push!(b, parse(Float64, line))
			end

			(b, n)
		end

		return data
	end # function loadVector

	using sparse_matrix

	"""
	Reads matrix data from file.

	Parameters:
		filepath - path to input file

	Return:
		(A, n, l) - tuple:
		A - my custom struct SparseMatrix;
		n - size of matrix A;
		l - size of submatrices
	"""
	function loadMatrixMy(filepath::String) :: Tuple{SparseMatrixMy, UInt64, UInt64}
		data = open(filepath, "r") do file
			sizes = split(readline(file), " ")
			n = parse(Int64, sizes[1])
			l = parse(Int64, sizes[2])

			A = SparseMatrix(n, l)

			for line in eachline(file)
				temp = split(line, " ")
				i = parse(Int64, temp[1])
				j = parse(Int64, temp[2])
				value = parse(Float64, temp[3])

				setvalue!(A, i, j, value)
			end
			(A, n, l)
		end

		return data
	end # function loadMatrixMy

end # module FileLoad
