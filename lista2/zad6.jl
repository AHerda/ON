# Author: Adrian Herda 268449


# funkcja obliczjąca x_{n+1} na podstawie x_n orac c1
# za parametry bierze x (poprzednie x) oraz c
next(x, c) = x^2 + c

#inicjowanie wartości c oraz x_0
# wektor x nazywa się x a nie x_0 ze względu na to że będziemy pracować na bezpośrednio tych wartościach 
x = [[1, 2, 1.99999999999999], [1, -1, 0.75, 0.25]]
c = [-2, -1]

for i in 1:2
    println("\n\n---- c = $(c[i]) ----")
    print(rpad("n", 5))
    for j in eachindex(x[i])
        print(" & ", rpad("\$x_0 = $(x[i][j])\$", 25))
    end
    println("\\\\ \\hline\\hline")
    for n in 0:40
        print(rpad(n, 5))
        for j in eachindex(x[i])
            print(" & ", rpad(x[i][j], 25))
        end
        println("\\\\ \\hline")
        for j in eachindex(x[i])
            x[i][j] = next(x[i][j], c[i])
        end
    end
end