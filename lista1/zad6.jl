# Author: Adrian Herda

# Funkcja podana w zadaniu przyjmująca x jako liczbę
f(x) = sqrt(x^2 + 1.0) - 1.0

# Funkcja podana w zadaniu przyjmująca x jako liczbę
g(x) = x^2 / (sqrt(x^2 + 1.0) + 1.0)

# Część ładna do wypisywania w terminalu
# Ta część pokazuje różnice pomiedzy wartościami funkcji wyżej zdefiniowanymi
for i in 1:20
    println("f(8^-$i)  =   ", f(Float64(8)^-i))
    println("g(8^-$i)  =   ", g(Float64(8)^-i), "\n")
end
for i in [20, 40, 60, 80, 100]
    println("f(8^-$i)  =   ", f(Float64(8)^-i))
    println("g(8^-$i)  =   ", g(Float64(8)^-i), "\n")
end

# Część pod sprawozdanie
# Ta część pokazuje różnice pomiedzy wartościami funkcji wyżej zdefiniowanymi
# for i in 1:10
#     println("8^{-$i} & ", f(Float64(8)^-i), " & ", g(Float64(8)^-i), " \\\\")
#     println("\\hline")
# end

# for i in [20, 40, 60, 80, 100]
#     println("8^{-$i} & ", f(Float64(8)^-i), " & ", g(Float64(8)^-i), " \\\\")
#     println("\\hline")
# end