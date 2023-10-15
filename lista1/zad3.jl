# global równomiernie_rozmieszone = true
# global x = one(Float64)
# println(x, " - " , bitstring(x))
# println(x+1, " - " , bitstring(x+1))
# println(x+2, " - " , bitstring(x+2))

# while x <= 2
#     if nextfloat(x) != x + eps(Float64)
#         równomiernie_rozmieszone = false
#         break
#     end
#     println(x, " - " , bitstring(x))
#     x = nextfloat(x)
# end

# println(równomiernie_rozmieszone)

x = one(Float64)

println(x, "                - " , bitstring(x))
println(nextfloat(x), " - " , bitstring(nextfloat(x)))
println(prevfloat(x), " - " , bitstring(prevfloat(x)))
println(x+1, "                - " , bitstring(x+1))
println(x+2, "                - " , bitstring(x+2))

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
println("Równomierne rozmieszenie na początku przedziału [1, 2]: ", równomiernie_rozmieszone_na_ogonach(one(Float64), eps(Float64), nextfloat))
println("Równomierne rozmieszenie na końcu przedziału [1, 2]: ", równomiernie_rozmieszone_na_ogonach(one(Float64) + 1, -eps(Float64), prevfloat))