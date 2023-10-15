f(x) = sin(x) + cos(3x)
dfdx(x) = cos(x) - 3sin(3x)
dfdx_approx(x, h, f) = (f(x + h) - f(x)) / h

actual = dfdx(1)

for n in 0:54
    println("\nh = 2^-$n:")
    println("approx f'(1)    =   ", dfdx_approx(1, Float64(2)^-n, f))
    println("actual f'(1)    =   ", actual)
end