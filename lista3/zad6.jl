include("zad123.jl")
using .mod123

f1(x) = exp(1 - x) - 1
f2(x) = x * exp(-x)

df1(x) = -exp(1 - x)
df2(x) = exp(-x) * (1 - x)

delta = 10^(-5)
epsilon = 10^(-5)

function print_tex_table(res)
    println(
        rpad(res[1], 25), " & ",
        rpad(res[2], 25), " & ",
        rpad(res[3], 20), " & ",
        rpad(res[4], 10), " \\\\\\hline"
    )
end

println("\n f1")

println("\n bisekcja")
print(rpad("przedział", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_1(r)\$", "liczba iteracji", "kod błędu"])
for (a, b) in [(0., 2.), (-0.1, 2.), (-21.37, 37.21), (0.1, 1024.), (0.9, 1.0e6)]
    print(rpad("\$[$a, $b]\$", 20), " & ")
    print_tex_table(mbisekcji(f1, a, b, delta, epsilon))
end

println("\n styczne")
print(rpad("\$x_0\$", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_1(r)\$", "liczba iteracji", "kod błędu"])
for x0 in [0., -4., 10., 1.0e6]
    print(rpad(x0, 20), " & ")
    print_tex_table(mstycznych(f1, df1, x0, delta, epsilon, 100))
end

println("\n sieczne")
print(rpad("\$x_0\$, \$x_1\$", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_1(r)\$", "liczba iteracji", "kod błędu"])
for (x0, x1) in [(0.,2.), (-0.1, 2.), (-21.37, 37.21), (0.1, 1024.), (0.9, 1.0e6)]
    print(rpad("\$$x0, $x1\$", 20), " & ")
    print_tex_table(msiecznych(f1, x0, x1, delta, epsilon, 100))
end

println("\n f2")

println("\n bisekcja")
print(rpad("przedział", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_2(r)\$", "liczba iteracji", "kod błędu"])
for (a, b) in [(-1., 2.), (-0.1, 2.), (-21.37, 37.21), (-2.1, 1024.), (0.9, 1.0e6)]
    print(rpad("\$[$a, $b]\$", 20), " & ")
    print_tex_table(mbisekcji(f2, a, b, delta, epsilon))
end

println("\n styczne")
print(rpad("\$x_0\$", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_2(r)\$", "liczba iteracji", "kod błędu"])
for x0 in [-1., -4., 1., 10., 1.0e6]
    print(rpad(x0, 20), " & ")
    print_tex_table(mstycznych(f2, df2, x0, delta, epsilon, 100))
end

println("\n sieczne")
print(rpad("\$x_0\$, \$x_1\$", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_2(r)\$", "liczba iteracji", "kod błędu"])
for (x0, x1) in [ (-0.1, 2.), (-0.7,1.5), (-21.37, 37.21), (0.1, 1024.), (0.9, 1.0e6)]
    print(rpad("\$$x0, $x1\$", 20), " & ")
    print_tex_table(msiecznych(f2, x0, x1, delta, epsilon, 100))
end

println("\nadditional")

println("\nf1")
print(rpad("\$x_0\$", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_1(r)\$", "liczba iteracji", "kod błędu"])
for x0 in [1.1, 2., 5., 10., 1.0e4]
    print(rpad(x0, 20), " & ")
    print_tex_table(mstycznych(f1, df1, x0, delta, epsilon, 100))
end

println("\nf2")
print(rpad("\$x_0\$", 20), " & ")
print_tex_table(["pierwiastek r", "\$f_2(r)\$", "liczba iteracji", "kod błędu"])
for x0 in [1., 1.1, 2., 5., 10., 1.0e4]
    print(rpad(x0, 20), " & ")
    print_tex_table(mstycznych(f2, df2, x0, delta, epsilon, 100))
end