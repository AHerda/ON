include("matrixgen.jl")
include("file_load.jl")

function main()
	# Parse command line arguments
	args = parse_args()

	# Load matrix data
	(A, n, l) = loadMatrix(args["matrix"])
	(b, n) = loadVector(args["vector"])

	# Solve system
	x = A \ b

	# Print solution
	println("Solution:")
	println(x)
end
