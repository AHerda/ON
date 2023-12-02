"""
Funkcja obliczająca wartość wielomianu interpolacyjnego w postaci Newtona.

# Dane
x – wektor długości n zawierający węzły x_0, ..., x_n-1, gdzie 
    x[i] = x_{i-1}

fx – wektor długości n zawierający obliczone ilorazy różnicowe, gdzie
    fx[i] = f[x_0, ..., x_{i-1}]

t – punkt, w którym należy obliczyć wartość wielomianu

# Wyniki
nt – wartość wielomianu w punkcie t
"""
function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    n = length(x)
    nt = fx[n]
    for i in (n-1):-1:1
        nt = fx[i] + (t - x[i])*nt
    end
    return nt
end

export warNewton