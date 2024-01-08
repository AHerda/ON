# Author: Adrian Herda 268449

include("sparse_matrix.jl")

module File
	export loadMatrixPlus, loadVector, loadMatrixMy, writeVector, relative_error

	using LinearAlgebra: norm
	using ..SparseMatrix: SparseMatrixMy, SparseMatrixPlus, generate_rhs_vector
	using SparseArrays

	"""
	Reads matrix data from file.

	Inout:
		filepath - path to input file

	Output:
		A - custom Struct with SparseMatrixCSC inside
	"""
	function loadMatrixPlus(filepath::String) :: SparseMatrixPlus
		data = open(filepath, "r") do file
			sizes = split(readline(file), " ")
			n = parse(UInt64, sizes[1])
			l = parse(UInt64, sizes[2])

			A = spzeros(Float64, n, n)
			for line in eachline(file)
				data = split(line, " ")
				i = parse(UInt64, data[1])
				j = parse(UInt64, data[2])
				value = parse(Float64, data[3])

				A[i, j] = value
			end

			SparseMatrixPlus(n, l, A, 0)
		end

		return data
	end # function loadMatrix


	"""
	Reads vector of right sides.

	Input:
		filepath - file path to input data.

	Output:
	(b, n) - tuple:
		b - vector of right sides
		n - size of vector b
	"""
	function loadVector(filepath::String)::Tuple{Vector{Float64}, UInt64}
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

	"""
	Reads matrix data from file.

	Input:
		filepath - path to input file

	Output:
		A - my custom struct SparseMatrixMy
	"""
	function loadMatrixMy(filepath::String) :: SparseMatrixMy
		data = open(filepath, "r") do file
			sizes = split(readline(file), " ")
			n = parse(UInt64, sizes[1])
			l = parse(UInt64, sizes[2])

			A = SparseMatrixMy(n, l)

			for line in eachline(file)
				temp = split(line, " ")
				i = parse(UInt64, temp[1])
				j = parse(UInt64, temp[2])
				value = parse(Float64, temp[3])

				A[i, j] = value
			end
			A
		end

		return data
	end # function loadMatrixMy

	"""
	Writes vector to file.

	Input:
		filepath - path to output file
		x - vector to write
	"""
	function writeVector(filepath::String, x::Vector{Float64}, err::Bool = false)
		open(filepath, "w") do file
			if err
				write(file, raltive_error(x))
				write(file, "\n")
			end
			for i = 1:length(x)
				write(file, x[i])
				write(file, "\n")
			end
		end
	end # function writeVector

	"""
	Helper function for calculating relative error.

	Input:
		x - vector of approximated values

	Output:
		relative error
	"""
	function relative_error(x::Vector{Float64})::Float64
		x_exact = ones(length(x))
		return norm(x - x_exact) / norm(x_exact)
	end # function relative_error

end # module File
