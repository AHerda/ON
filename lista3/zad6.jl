# Author: Adrian Herda 268449

include("zad123.jl")
using .mod123

f1(x) = exp(1 - x) - 1
f2(x) = x * exp(-x)

# Pochodna funkcji f1
df1(x) = -exp(1 - x)
# Pochodna funkcji f2
df2(x) = exp(-x) * (1 - x)

delta = 10^(-5)
epsilon = 10^(-5)


println("---- f1 ----")

println(
    rpad("Metoda", 20),
    " & ", rpad("Dane początkowe", 20),
    " & ", rpad("\$r\$", 25),
    " & ", rpad("\$f(r)\$", 25),
    " & ", rpad("Liczba iteracji", 20),
    " \\\\ \\hline\\hline"
)
res = mbisekcji(f1, -0.4, 1.9, delta, epsilon)
println(
    rpad("Metoda bisekcji", 20),
    " & ", rpad("\$[-0.4, 1.9]\$", 20),
    " & ", rpad(res[1], 25),
    " & ", rpad(res[2], 25),
    " & ", rpad(res[3], 20),
    " \\\\\\hline"
)
res = mstycznych(f1, df1, -5., delta, epsilon, 50)
println(
    rpad("Metoda Newtona", 20),
    " & ", rpad("\$x_0=-5\$", 20),
    " & ", rpad(res[1], 25),
    " & ", rpad(res[2], 25),
    " & ", rpad(res[3], 20),
    " \\\\\\hline"
)
res = msiecznych(f1, -1., 0., delta, epsilon, 50)
println(
    rpad("Metoda siecznych", 20),
    " & ", rpad("\$x_0=-1\$, \$x_1=0\$", 20),
    " & ", rpad(res[1], 25),
    " & ", rpad(res[2], 25),
    " & ", rpad(res[3], 20),
    " \\\\\\hline"
)

println("\n---- f2 ----")

println(
    rpad("Metoda", 20),
    " & ", rpad("Dane początkowe", 20),
    " & ", rpad("\$r\$", 25),
    " & ", rpad("\$f(r)\$", 25),
    " & ", rpad("Liczba iteracji", 20),
    " \\\\ \\hline\\hline"
)
res = mbisekcji(f2, -1.9, 0.99, delta, epsilon)
println(
    rpad("Metoda bisekcji", 20),
    " & ", rpad("\$[-1.9, 0.99]\$", 20),
    " & ", rpad(res[1], 25),
    " & ", rpad(res[2], 25),
    " & ", rpad(res[3], 20),
    " \\\\\\hline"
)
res = mstycznych(f2, df2, -5., delta, epsilon, 50)
println(
    rpad("Metoda Newtona", 20),
    " & ", rpad("\$x_0=-5\$", 20),
    " & ", rpad(res[1], 25),
    " & ", rpad(res[2], 25),
    " & ", rpad(res[3], 20),
    " \\\\\\hline"
)
res = msiecznych(f2, -1., 1., delta, epsilon, 50)
println(
    rpad("Metoda siecznych", 20),
    " & ", rpad("\$x_0=-1\$, \$x_1=1\$", 20),
    " & ", rpad(res[1], 25),
    " & ", rpad(res[2], 25),
    " & ", rpad(res[3], 20),
    " \\\\\\hline"
)


println("\n===== dodatkowo =====")

println("\n--- f1 ----")
println(
    rpad("\$x_0\$", 20),
    " & ", rpad("\$r\$", 25),
    " & ", rpad("\$f(r)\$", 25),
    " & ", rpad("Liczba iteracji", 20),
    " & ", rpad("Kod błedu", 10),
    " \\\\ \\hline\\hline"
)
for x0 in [1.1, 2., 5., 10., 100., 10.0^4]
    print(rpad(x0, 20), " & ")
    global res = mstycznych(f1, df1, x0, delta, epsilon, 60)
    println(
        rpad(res[1], 25),
        " & ", rpad(res[2], 25),
        " & ", rpad(res[3], 20),
        " & ", rpad(res[4], 10),
        " \\\\\\hline"
    )
end

println("\n--- f2 ----")
println(
    rpad("\$x_0\$", 20),
    " & ", rpad("\$r\$", 25),
    " & ", rpad("\$f(r)\$", 25),
    " & ", rpad("Liczba iteracji", 20),
    " & ", rpad("Kod błedu", 10),
    " \\\\ \\hline\\hline"
)
for x0 in [1., 1.1, 2., 5., 10., 100., 10.0^4]
    print(rpad(x0, 20), " & ")
    global res = mstycznych(f2, df2, x0, delta, epsilon, 60)
    println(
        rpad(res[1], 25),
        " & ", rpad(res[2], 25),
        " & ", rpad(res[3], 20),
        " & ", rpad(res[4], 10),
        " \\\\\\hline"
    )
end