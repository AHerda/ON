# Author: Adrian Herda

# Funkcja znajduje najmniejszą liczbe większą od 1 dla typu T i zwraca jej róznicę od 1
function machine_epsilon(T)
    result = T(2.0)
    epsilon = T(1.0)
    
    while one(T) + epsilon > one(T)
        result /= T(2.0)
        epsilon /= T(2.0)
    end
    
    return result
end

# Funkcja znajduje najmniejszą liczbę większą od 0 dla typu T
function machine_eta(T)
    result = T(2.0)
    eta = T(1.0)

    while eta > zero(T)
        result /= T(2.0)
        eta /= T(2.0)
    end

    return result
end

# Funkcja pomocnicza
# Funckja znajduje największą liczbę mniejszą od liczby x dla typu T
function find_previous_float(x, T)
    x = T(x)
    diff = T(1.0)
    while x - diff < x
        diff /= T(2.0)
    end
    
    diff *= T(2.0)

    return x - diff
end

# Funckcja znajduję największą możliwą liczbę 
function max(T)
    max = find_previous_float(1.0, T)

    while !isinf(max * T(2.0))
        max *= T(2.0)
    end

    return max
end

println("Epsilon:\n")
# Dla typu Float16
eps_half = machine_epsilon(Float16)
println("Epsilon maszynowy (mój) dla Float16: ", eps_half)
println("Epsilon maszynowy dla Float16: ", eps(Float16), "\n")

# Dla typu Float32
eps_single = machine_epsilon(Float32)
println("Epsilon maszynowy (mój) dla Float32: ", eps_single)
println("Epsilon maszynowy dla Float32: ", eps(Float32), "\n")

# Dla typu Float64
eps_double = machine_epsilon(Float64)
println("Epsilon maszynowy (mój) dla Float64: ", eps_double)
println("Epsilon maszynowy dla Float64: ", eps(Float64))


println("\n==========================================================\n")

println("Eta:\n")
# Dla typu Float16
eta_half = machine_eta(Float16)
println("Eta maszynowa (moja) dla Float16: ", eta_half)
println("Eta maszynowa dla Float16: ", nextfloat(Float16(0.0)), "\n")

# Dla typu Float32
eta_single = machine_eta(Float32)
println("Eta maszynowa (moja) dla Float32: ", eta_single)
println("Eta maszynowa dla Float32: ", nextfloat(Float32(0.0)), "\n")

# Dla typu Float64
eta_double = machine_eta(Float64)
println("Eta maszynowa (moja) dla Float64: ", eta_double)
println("Eta maszynowa dla Float64: ", nextfloat(Float64(0.0)), "\n")


println("==========================================================\n")

println("MAX:\n")
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

println("==========================================================\n")

println("MIN:\n")
# Dla typu Float16
println("MIN dla Float16: ", floatmin(Float16), "\n")

# Dla typu Float32
println("MIN dla Float32: ", floatmin(Float32), "\n")

# Dla typu Float64
println("MIN dla Float64: ", floatmin(Float64), "\n")