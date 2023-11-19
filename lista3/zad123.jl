module mod123
    export mbisekcji, mstycznych, msiecznych


    """
    Funkcja rozwiązująca równanie f(x) = 0 metodą bisekcji.

    # Dane
    * f – funkcja f(x) zadana jako anonimowa funkcja,
    * a, b – końce przedziału początkowego,
    * delta, epsilon – dokładności obliczeń.

    # Wyniki
    Czwórka (r, v, it, err), gdzie
    * r – przybliżenie pierwiastka równania f(x) = 0,
    * v – wartość f(r),
    * it – liczba wykonanych iteracji,
    * err – sygnalizacja błędu:
        - 0 - brak błędu,
        - 1 - funkcja nie zmienia znaku w przedziale [a,b].
    """
    function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
        u = f(a)
        v = f(b)

        if sign(u) == sign(v)
            return (Nothing, Nothing, 0, 1)
        end

        
        e = b - a
        it = 0

        while true
            it += 1
            e /= 2
            c = a + e
            w = f(c)

            if abs(e) < delta || abs(w) < epsilon
                return (c, w, it, 0)
            end

            if sign(w) != sign(u)
                b = c
                v = w
            else
                a = c
                u = w
            end
        end
    end



    """
    Funkcja rozwiązująca równanie f(x) = 0 metodą Newtona.

    # Dane
    * f, pf – funkcja f(x) oraz pochodna f'(x) zadane jako anonimowe funkcje,
    * x0 – przybliżenie początkowe,
    * delta, epsilon – dokładności obliczeń,
    * maxit – maksymalna dopuszczalna liczba iteracji.

    # Wyniki
    Czwórka (r, v, it, err), gdzie
    * r – przybliżenie pierwiastka równania f(x) = 0,
    * v – wartość f(r),
    * it – liczba wykonanych iteracji,
    * err – sygnalizacja błędu:
        - 0 - brak błędu,
        - 1 - nie osiągnięto wymaganej dokładności w maxit iteracji,
        - 2 - pochodna bliska zeru.
    """
    function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
        v = f(x0)

        if abs(v) < epsilon
            return (x0, v, 0, 0)
        end

        for it in 1:maxit
            df = pf(x0)
            if abs(df) < epsilon
                return (x0, v, it, 2)
            end

            x1 = x0 - (v / pf(x0))
            v = f(x1)
            
            if abs(x1 - x0) < delta || abs(v) < epsilon
                return (x1, v, it, 0)
            end

            x0 = x1
        end

        return (x0, v, maxit, 1)
    end



    """
    Funkcja rozwiązująca równanie f(x) = 0 metodą siecznych.

    # Dane
    * f – funkcja f(x) zadana jako anonimowa funkcja,
    * a, b – przybliżenia początkowe,
    * delta, epsilon – dokładności obliczeń,
    * maxit – maksymalna dopuszczalna liczba iteracji.

    # Wyniki
    Czwórka (r, v, it, err), gdzie
    * r – przybliżenie pierwiastka równania f(x) = 0,
    * v – wartość f(r),
    * it – liczba wykonanych iteracji,
    * err – sygnalizacja błędu:
        - 0 - brak błędu,
        - 1 - nie osiągnięto wymaganej dokładności w maxit iteracji.
    """
    function msiecznych(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64, maxit::Int)
        fa = f(a)
        fb = f(b)

        for it in 1:maxit
            if abs(fa) > abs(fb)
                a, b = b, a
                fa, fb = fb, fa
            end

            s = (b - a) / (fb - fa)
            b = a
            fb = fa
            a -= fa * s
            fa = f(a)

            if abs(b - a) < delta || abs(fa) < epsilon
                return (a, fa, it, 0)
            end
        end
        return (b, fb, maxit, 1)
    end
end