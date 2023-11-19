# Author: Adrian Herda 268449

include("zad123.jl")
using .mod123
using Test

@testset "Metoda bisekcji" begin
    delta = 10^(-5)
    epsilon = 10^(-5)

    # test pozytywny

    f(x) = x^3 - x
    r = 1.

    res = mbisekcji(f, 0.1, 5., delta, epsilon)
    x = res[1]
    fx = res[2]

    @test abs(fx) <= epsilon
    @test abs(r - x) <= delta
    @test res[4] == 0

    # bardzo płaska funkcja

    f(x) =  1 / x - 0.001
    r = 1000.

    res = mbisekcji(f, 990., 1100., delta, epsilon)
    x = res[1]
    fx = res[2]
    println(r, " ", x)
    @test abs(fx) <= epsilon
    @test abs(r - x) > delta
    @test res[4] == 0

    # a teraz bardzo stroma

    f(x) = exp(x) - exp(10)
    r = 10.

    res = mbisekcji(f, 9., 12., delta, epsilon)
    x = res[1]
    fx = res[2]
    println(r, " ", x)
    @test abs(fx) > epsilon
    @test abs(r - x) <= delta
    @test res[4] == 0

    # funkcja ma te same znaki na końcach przedziału

    f(x) = x^2 + 1

    res = mbisekcji(f, -1., 2., delta, epsilon)

    @test res[4] == 1
end

@testset "Metoda Newtona" begin
    delta = 10^(-3)
    epsilon = 10^(-3)
    
    # funkcja poprawna

    f(x) = x^3 + 1
    df(x) = 3 * x^2
    r = -1.

    res = mstycznych(f, df, 0.5, delta, epsilon, 10)
    x = res[1]
    fx = res[2]

    @test abs(fx) <= epsilon
    @test abs(r - x) <= delta
    @test res[4] == 0

    # funkcja wpada w punkt z pochodną bliską zeru

    res = mstycznych(f, df, 0.8, delta, epsilon, 10)

    @test res[4] == 2

    # metoda zacykli się

    f(x) = x^3 - 2 * x - 2
    df(x) = 3 * x^2 - 2
    r = -1.7693

    res = mstycznych(f, df, 0., delta, epsilon, 100)
    x = res[1]
    fx = res[2]

    @test abs(fx) > epsilon
    @test abs(r - x) > delta
    @test res[4] == 1
end

@testset "metoda siecznych" begin
    delta = 10^(-10)
    epsilon = 10^(-10)

    f(x) = atan(x)
    r = 0.

    # nie udało mi się znaleźć fajnego przypadku zapętlania się albo rozbiegania
    # ale tu zdąży

    res = msiecznych(f, -1.5, 1., delta, epsilon, 10)
    x = res[1]
    fx = res[2]

    @test abs(fx) <= epsilon
    @test abs(r - x) <= delta
    @test res[4] == 0

    # a tu nie

    res = msiecznych(f, 341000244450., 1120323240., delta, epsilon, 50)
    x = res[1]
    fx = res[2]

    @test abs(fx) > epsilon
    @test abs(r - x) > delta
    @test res[4] == 1
end