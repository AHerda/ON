# Author: Adrian Herda 268449

include("zad123.jl")
using .mod123

f(x) = sin(x) - (x / 2)^2

pf(x) = cos(x) - x / 2

delta = (1/2)*(10^(-5))
epsilon = (1/2)*(10^(-5))

println(rpad("sin(x) - (x/2)^2 = 0" , 90))

println(rpad("" , 20),
    " & ", rpad("x0", 20),
    " & ", rpad("f(x0)", 25),
    " & ", rpad("it", 20),
    " & ", rpad("err", 10),
    "\\\\ \\hline\\hline")

(x0, fx0, it, err) = mbisekcji(f, 1.5, 2.0, delta, epsilon)
println(rpad("Metoda Bisekcji" , 20),
    " & ", rpad(x0, 20),
    " & ", rpad(fx0, 25),
    " & ", rpad(it, 20),
    " & ", rpad(err, 10),
    "\\\\ \\hline")

(x0, fx0, it, err) = mstycznych(f, pf, 1.5, delta, epsilon, 100)
println(rpad("Metoda Stycznych" , 20),
    " & ", rpad(x0, 20),
    " & ", rpad(fx0, 25),
    " & ", rpad(it, 20),
    " & ", rpad(err, 10),
    "\\\\ \\hline")

(x0, fx0, it, err) = msiecznych(f, 1.0, 2.0, delta, epsilon, 100)
println(rpad("Metoda Siecznych" , 20),
    " & ", rpad(x0, 20),
    " & ", rpad(fx0, 25),
    " & ", rpad(it, 20),
    " & ", rpad(err, 10),
    "\\\\ \\hline")