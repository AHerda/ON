# Author: Adrian Herda 268449

module blocksys

	export loadMatrix, loadVector, solve_gauss_special, lu_decomposition

	function solve_gauss(A, b, pivot=false)
		n = size(A, 1)
		x = zeros(n)

		for k = 1:n-1
			if pivot
				pivot_idx = argmax(abs.(A[k:end, k])) + k - 1
				A[[k, pivot_idx], :] = A[[pivot_idx, k], :]
				b[[k, pivot_idx]] = b[[pivot_idx, k]]
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
	end

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
