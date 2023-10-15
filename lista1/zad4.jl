function find_ne(start, end_, func)
    flag = true
    if start > end_
        flag = false
    end
    znaleziono = false
    while (flag && start < end_) || (!flag && end_ < start)
        if Float64(start * Float64(1 / start)) != 1
            znaleziono = true
            break
        end
        start = func(start)
    end
    return (start, znaleziono)
end

println("Szukanie liczby nie spełniającej działania x * 1/x na początku przedziału (1, 2): ", find_ne(nextfloat(Float64(1)), prevfloat(Float64(2)), nextfloat))
println("Szukanie liczby nie spełniającej działania x * 1/x na końcu przedziału (1, 2): ", find_ne(prevfloat(Float64(2)), nextfloat(Float64(1)), prevfloat))