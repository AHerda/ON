# Author: Adrian Herda

# Funckja oblicza wartość funkcji podanej w zadaniu w punkcie x
f(x) = sin(x) + cos(3x)
# Funckja oblicza wartość pochodnej funkcji podanej w zadaniu w punkcie x
dfdx(x) = cos(x) - 3sin(3x)
# Aproksymacja pochodnej funkcji podanej w parametrze f w punkcie x i z precyzją h
dfdx_approx(x, h, f) = (f(x + h) - f(x)) / h

# Prawdziwa wartość pochodnej funckcji f w punkcie x = 1
actual = dfdx(1)

# Wypisywanie ładne do terminalu
for n in 0:54
    println("\nh = 2^-$n:")
    println("~f'(1)                     =   ", dfdx_approx(1.0, Float64(2)^-n, f))
    println(" f'(1)                     =   ", actual)
    println("|f'(1) - ~f'(1)|           =   ", abs(dfdx_approx(1.0, Float64(2)^-n, f) - actual))
end

# Wypisywanie brzydkie, pomoc do sprawozdania 
# for n in 0:54
#     println("2^{-$n} & ", Float64(2)^-n + 1.0, " & ", dfdx_approx(1.0, Float64(2)^-n, f), " & ", abs(dfdx_approx(1.0, Float64(2)^-n, f) - actual), " \\\\")
#     println("\\hline")
# end