function machine_epsilon(T)
    result = T(2.0)
    epsilon = T(1.0)
    one = T(1.0)
    
    while one + epsilon > one
        result /= T(2.0)
        epsilon /= T(2.0)
    end
    
    return result
end

function machine_eta(T)
    result = T(2.0)
    eta = T(1.0)

    while eta > 0.0
        result /= T(2.0)
        eta /= T(2.0)
    end

    return result
end

function find_previous_float(x, T)
    one = T(x)
    epsilon = T(1.0)
    
    while one - epsilon < one
        epsilon /= T(2.0)
    end
    
    epsilon *= T(2.0)

    return one - epsilon
end

function max(T)
    max = find_previous_float(1.0, T)

    while !isinf(max * T(2.0))
        max *= T(2.0)
    end

    return max
end

println("Epsilon:")
# Dla typu Float16
epsilon_half = machine_epsilon(Float16)
print(epsilon_half, "   ", eps(Float16), "\n")

# Dla typu Float32
epsilon_single = machine_epsilon(Float32)
print(epsilon_single, "   ", eps(Float32), "\n")

# Dla typu Float64
epsilon_double = machine_epsilon(Float64)
print(epsilon_double, "   ", eps(Float64), "\n")


println("==========================================================\n")


# Dla typu Float16
eta_half = machine_eta(Float16)
println("Eta maszynowa (mój) dla Float16: ", eta_half)
println("Eta maszynowa dla Float16: ", nextfloat(Float16(0.0)), "\n")

# Dla typu Float32
eta_single = machine_eta(Float32)
println("Eta maszynowa (mój) dla Float32: ", eta_single)
println("Eta maszynowa dla Float32: ", nextfloat(Float32(0.0)), "\n")

# Dla typu Float64
eta_double = machine_eta(Float64)
println("Eta maszynowa (mój) dla Float64: ", eta_double)
println("Eta maszynowa dla Float64: ", nextfloat(Float64(0.0)), "\n")


println("==========================================================\n")


# Dla typu Float16
max_half = max(Float16)
println("MAX (mój) dla Float16: ", max_half)
println("MAX dla Float16: ", floatmax(Float16), "\n")

# Dla typu Float32
max_single = max(Float32)
println("MAX (mój) dla Float32: ", max_single)
println("MAX dla Float32: ", floatmax(Float32), "\n")

# Dla typu Float64
max_double = max(Float64)
println("MAX (mój) dla Float64: ", max_double)
println("MAX dla Float64: ", floatmax(Float64), "\n")