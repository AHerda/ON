"""
Funkcja wyznaczająca współczynniki dla postaci naturalnej wielomianu 
interpolacyjnego danego w postaci Newtona.

# Dane
x – wektor długości n zawierający węzły x_0, ..., x_n-1, gdzie 
    x[i] = x_{i-1}

fx – wektor długości n zawierający obliczone ilorazy różnicowe, gdzie
    fx[i] = f[x_0, ..., x_{i-1}]

# Wyniki
a – wektor długości n zawierający obliczone współczynniki postaci naturalnej, 
    gdzie a[i] to współczynnik przy x^{i-1}
"""
function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    n = length(x)
    a = zeros(n)
    a[n] = fx[n]
    for i in (n-1):-1:1
        a[i] = fx[i] - x[i] * a[i+1]
        for j in (i+1):(n-1)
            a[j] += -x[i] * a[j+1]
        end
    end
    return a
end

export naturalna