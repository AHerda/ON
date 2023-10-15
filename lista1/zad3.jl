równomiernie_rozmieszone = true
x = Float64(1)
while x <= 2
    print(nextfloat(x) - x)
    if nextfloat(x) - x == eps(Float64)
        global równomiernie_rozmieszone = false
        break
    end
    println(x)
    global x = nextfloat(x)
end

print(równomiernie_rozmieszone)