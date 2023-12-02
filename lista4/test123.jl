include("zad123.jl")

using Test
using .mod123

xs = [1.0, 3.0, 4.0, 5.0]
fxs = [4.0, -2.0, 10.0, 16.0]

expectedQs = [4.0, -3.0, 5.0, -2.0]
calculatedQs = ilorazyRoznicowe(xs, fxs)
@testset "Quotients" begin
    @test isapprox(calculatedQs, expectedQs)
end

@testset "Values" begin
    @test isapprox(warNewton(xs, calculatedQs, 1.0), 4.0)
    @test isapprox(warNewton(xs, calculatedQs, 9.0), -260.0)
end

expectedNaturals = [-156.0, 262.0, -118.0, 16.0]
@testset "Natural" begin
    @test isapprox(naturalna(xs, fxs), expectedNaturals)
end