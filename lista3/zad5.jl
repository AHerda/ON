include("zad123.jl")
using .mod123

f(x) = 3 * x
g(x) = exp(x)
h(x) = f(x) - g(x)

delta = 10^(-4)
epsilon = 10^(-4)

(x0, fx0, it, err) = mbisekcji(h, 0., 1., delta, epsilon)
println("Pierwsze przecięcie:\n\tx_0 = ", x0, "\n\tf(x_0) = ", f(x0))

(x0, fx0, it, err) = mbisekcji(h, 1., 2., delta, epsilon)
println("\nDrugie przecięcie:\n\tx_0 = ", x0, "\n\tf(x_0) = ", f(x0))