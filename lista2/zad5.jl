# Author: Adrian Herda 268449

next(p, r) = p + r * p * (1 - p)

# Podpunkt 1.
println("\n\n---- Podpunkt 1 ----")
liczba = Float32(0.01)
liczba_odc = Float32(0.01)
r = Float32(3)

println(rpad("n", 5),
    " & ", rpad("Bez odcięcia", 15), 
    " & ", rpad("Z odcięciem", 15),
    "\\\\ \\hline\\hline")
for n in 0:40
    if n == 10
        liczba_odc = floor(liczba_odc * 1000) / 1000
        println("\\hline")
    end
    println(rpad(n, 5),
        " & ", rpad(liczba, 15),
        " & ", rpad(liczba_odc, 15),
        "\\\\ \\hline")

    global liczba = next(liczba, r)
    global liczba_odc = next(liczba_odc, r)
end

# Podpunkt 2.

println("\n\n---- Podpunkt 2 ----")
liczba1 = Float32(0.01)
liczba2 = Float64(0.01)
r1 = Float32(3)
r2 = Float64(3)

println(rpad("n", 5),
    " & ", rpad("Float32", 15), 
    " & ", rpad("Float64", 25),
    "\\\\ \\hline\\hline")
for n in 0:40
    println(rpad(n, 5),
        " & ", rpad(liczba1, 15),
        " & ", rpad(liczba2, 25),
        "\\\\ \\hline")

    global liczba1 = next(liczba1, r1)
    global liczba2 = next(liczba2, r2)
end