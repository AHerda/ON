# Author: Adrian Herda 268449

# Funkcja zwraca iloczyn skalarany x oraz y liczony "w przód"
# T to typ zmiennej
function a(x, y, T)
    result = T(0)
    n = length(x)

    for i in 1:n
        result += x[i] * y[i]
    end

    return result
end

# Funkcja zwraca iloczyn skalarany x oraz y liczony "w tył"
# T to typ zmiennej
function b(x, y, T)
    result = T(0)
    n = length(x)

    for i in n:-1:1
        result += (x[i] * y[i])
    end

    return result
end

# Funkcja zwraca iloczyn skalarany x oraz y liczony:
#       Dodatnie od największego do najmniejszego
#       Ujemne od najmnijeszego do największego
# T to typ zmiennej
function c1(x, y, T)
    to_sum = x .* y

    sum_positive = filter(a -> a >= 0, to_sum)
    sum_negative = filter(a -> a < 0, to_sum)

    sum_positive = sort(sum_positive, rev=true)
    sum_negative = sort(sum_negative)

    sum = T(0)
    for i in eachindex(sum_positive)
        sum += sum_positive[i]
    end
    for i in eachindex(sum_negative)
        sum += sum_negative[i]
    end

    return sum
end

# Funkcja zwraca iloczyn skalarany x oraz y liczony:
#       Dodatnie od najmnijeszego do największego
#       Ujemne od największego do najmniejszego
# T to typ zmiennej
function d(x, y, T)
    to_sum = x .* y

    sum_positive = filter(a -> a >= 0, to_sum)
    sum_negative = filter(a -> a < 0, to_sum)

    sum_positive = sort(sum_positive)
    sum_negative = sort(sum_negative, rev=true)

    sum = T(0)
    for i in eachindex(sum_positive)
        sum += sum_positive[i]
    end
    for i in eachindex(sum_negative)
        sum += sum_negative[i]
    end

    return sum
end


# x oraz y to dane z listy 1, x2 to zmieniony wektor zgodnie z poleceniem zadanie 1 z listy 2
x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
x2 = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println("\nPrawdziwy wynik: -1.00657107000000e-11, \n")

for T in [Float32, Float64]
    tab1 = Array{T}(x)
    tab12 = Array{T}(x2)
    tab2 = Array{T}(y)
    println("--- $T ---")
    println(rpad("", 15), " & ", rpad("Lista 1", 25), " & Lista 2 \\\\ \\hline\\hline")
    for i in [a, b, c1, d]
        println(rpad("Funkcja $i:", 15),
                " & ", rpad(i(tab1, tab2, T), 25),
                " & ", i(tab12, tab2, T),
                " \\\\ \\hline")
    end
    println()
end