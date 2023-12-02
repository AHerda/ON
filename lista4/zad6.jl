include("./zad123.jl")
using .mod123

oneOverOnePlusXSquared(x) = 1/(1+x^2)

rysujNnfx(abs, -1.0, 1.0, 5)
rysujNnfx(abs, -1.0, 1.0, 10)
rysujNnfx(abs, -1.0, 1.0, 15)

rysujNnfx(oneOverOnePlusXSquared, -5.0, 5.0, 5)
rysujNnfx(oneOverOnePlusXSquared, -5.0, 5.0, 10)
rysujNnfx(oneOverOnePlusXSquared, -5.0, 5.0, 15)