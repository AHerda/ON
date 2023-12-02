"""
Funkcja obliczająca ilorazy różnicowe potrzebne do przedstawienia wielomianu 
interpolacyjnego w postaci Newtona.

# Dane
x – wektor długości n zawierający węzły x_0, ..., x_n-1, gdzie 
    x[i] = x_{i-1}

f – wektor długości n zawierający wartości interpolowanej funkcji w węzłach,
    gdzie f[i] = f(x_{i-1})

# Wyniki
fx – wektor długości n zawierający obliczone ilorazy różnicowe, gdzie
    fx[i] = f[x_0, ..., x_{i-1}]
"""
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    n = length(x)
    fx = zeros(n)
    for i in 1:n
        fx[i] = f[i]
    end
    for j in 2:n
        for i in n:-1:j
            fx[i] = (fx[i] - fx[i-1])/(x[i]-x[i-j+1])
        end
    end
    return fx
end

export ilorazyRoznicowe