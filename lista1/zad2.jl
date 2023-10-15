function macheps(T)
    return T(3) * (T(4) / T(3) - T(1)) - T(1)
end

types = [Float16, Float32, Float64]

println("       Mine:        eps():")
for type in types
    println(type, ": ", macheps(type), "    ", eps(type))
end