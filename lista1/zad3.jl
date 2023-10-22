# Author: Adrian Herda

x = one(Float64)

println(prevfloat(x), " - " , bitstring(prevfloat(x)))
println(x, "                - " , bitstring(x))
println(nextfloat(x), " - " , bitstring(nextfloat(x)))
println(nextfloat(nextfloat(x)), " - " , bitstring(nextfloat(nextfloat(x))))
println(prevfloat(x+1), " - " , bitstring(prevfloat(x+1)))

println(x+1, "                - " , bitstring(x+1))
println(x+2, "                - " , bitstring(x+2))


# Funkcja sprawdzjąca równomiernie rozmieszone dla 100 pierwszych liczb wyznaczanych przez start jako pierwszą liczbę oraz func jako funkcja wyznaczjąca kolejną liczbę
# delta to oczekiwana róznica pomiędzy liczbami
# funkcja zwraca true jeśli zachowane jest równomiernie rozmieszenie i false jeśli nie jest zachowane
function równomiernie_rozmieszone_na_ogonach(start, delta, func)
    równomiernie_rozmieszone = true
    for i in 0:100
        if func(start) != start + delta
            równomiernie_rozmieszone = false
            break
        end
        start = func(start)
    end

    return równomiernie_rozmieszone
end


print("\n\n")
# Sprawdzanie początku przedziału [1, 2]
println("Równomierne rozmieszenie na początku przedziału [1, 2]: ", równomiernie_rozmieszone_na_ogonach(one(Float64), eps(Float64), nextfloat))
# Sprawdzanie końca przedziału [1, 2]
println("Równomierne rozmieszenie na końcu przedziału [1, 2]: ", równomiernie_rozmieszone_na_ogonach(one(Float64) + 1, -eps(Float64), prevfloat))