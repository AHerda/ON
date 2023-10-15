function f(x, T)
    return T(sqrt(T(x)^2 + T(1)) - T(1))
end

function g(x, T)
    return T(x)^2 / (sqrt(T(x)^2 + T(1)) + T(1))
end

for i in 1:20
    println("f(8^-$i)  =   ", f(Float64(8)^-i, Float64))
    println("g(8^-$i)  =   ", g(Float64(8)^-i, Float64), "\n")
end