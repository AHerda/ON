module mod123
    export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx
    
    # import Pkg
    # Pkg.add("PyPlot")

    using PyPlot

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


    """
    Funkcja rysuje wielomian interpolacyjny i interpolowaną funkcję 
    w przedziale [a, b] na n+1 równoodległych punktach.

    # Dane
    f – funkcja do interpolacji zadana jako anonimowa funkcja

    a, b – przedział interpolacji

    n – stopień wielomianu interpolacyjnego

    # Wyniki
    p – obiekt rysunku z wykresami wielomianu i funkcji
    """
    function rysujNnfx(f, a :: Float64, b :: Float64, n :: Int)
        if a > b
            a, b = b, a
        end

        steps = n + 1

        xs = Vector{Float64}(undef, steps)
        ys = Vector{Float64}(undef, steps)

        currentDelta = zero(Float64)
        for i in 1:steps
            xs[i] = a + currentDelta
            ys[i] = f(xs[i])
            currentDelta += (b - a) / (steps - 1)
        end

        density = 10
        steps = (n + 1) * density

        qs = ilorazyRoznicowe(xs, ys)
        interpolationXs = Vector{Float64}(undef, steps)
        interpolationVals = Vector{Float64}(undef, steps)
        realVals = Vector{Float64}(undef, steps)

        currentDelta = zero(Float64)
        for i in 1:steps
            interpolationXs[i] = a + currentDelta
            interpolationVals[i] = warNewton(xs, qs, a + currentDelta)
            realVals[i] = f(a + currentDelta)
            currentDelta += (b - a) / (steps - 1)
        end

        clf()
        plot(interpolationXs, interpolationVals, label="interpolated", linewidth=2.0, alpha=0.5, color="#0070ff")
        plot(interpolationXs, realVals, label="actual", linewidth=2.0, alpha=0.5, color="#ff7000")
        grid(true)
        legend(title="Interpolation")
        savefig(string("plots/plot", "-", f, "-", n, ".png"))
    end
end