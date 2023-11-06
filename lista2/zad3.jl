# Author: Adrian Herda 268449

# Dodawanie funkcji danych za listą do pliku
include("hilb.jl")
include("matcond.jl")

# funkcja rozwiązuje układ równań liniowych za pomoća metody Gaussa
# jako paramtey pobiera Macierz A oraz jej wielkość n
function solve_guass(A, n)
    x = ones(Float64, n)
    b = A * x

    return A \ b
end

# funkcja rozwiązuje układ równań liniowych za pomoća metody inwersji
# jako paramtey pobiera Macierz A oraz jej wielkość n
function solve_inverse(A, n)
    x = ones(Float64, n)
    b = A * x

    return inv(A) * b
end

# funkcja wylicza błędy obu metod rozwiązywania równań liniowych
# Za parametry bierze macierz A i jej wielkość jako n
function calculate_err(A, n)
    gauss = solve_guass(A, n)
    inverse = solve_inverse(A, n)

    x = ones(Float64, n)
    gauss_err = norm(gauss - x) / norm(x)
    inverse_err = norm(inverse - x) / norm(x)

    return (gauss_err, inverse_err)
end

println("---- Macierze Hilberta ----")
println(rpad("n", 5), 
        " & ", rpad("\$cond(A)\$", 25), 
        " & ", rpad("\$rank(A)\$", 10), 
        " & ", rpad("Błąd eliminacji Gaussa", 25), 
        " & Błąd metody inwersji", 
        " \\\\ \\hline\\hline")
for n in 1:3:52
    A = hilb(n)
    local err = calculate_err(A, n)
    println(rpad(n, 5),
        " & ", rpad(cond(A), 25),
        " & ", rpad(rank(A), 10),
        " & ", rpad(err[1], 25),
        " & ", err[2],
        " \\\\ \\hline")
end



println("\n---- Macierze Losowe ----")
println(rpad("n", 5), 
        " & ", rpad("\$cond(A)\$", 25), 
        " & ", rpad("\$rank(A)\$", 10), 
        " & ", rpad("Błąd eliminacji Gaussa", 25), 
        " & Błąd metody inwersji", 
        " \\\\ \\hline\\hline")
for n in [5, 10, 20]
    for log_10_c in [0, 1, 3, 7, 12, 16]
        A = matcond(n, 10.0^log_10_c)
        local err = calculate_err(A, n)
        println(rpad(n, 5),
            " & ", rpad(cond(A), 25),
            " & ", rpad(rank(A), 10),
            " & ", rpad(err[1], 25),
            " & ", err[2],
            " \\\\ \\hline")
    end
end