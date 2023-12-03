# Author: Adrian Herda 268449

include("zad1234.jl")
using .mod123

e(x) = exp(x)
x2sin(x) = x^2 * sin(x)

rysujNnfx(e, 0.0, 1.0, 5)
rysujNnfx(e, 0.0, 1.0, 10)
rysujNnfx(e, 0.0, 1.0, 15)

rysujNnfx(x2sin, -1.0, 1.0, 5)
rysujNnfx(x2sin, -1.0, 1.0, 10)
rysujNnfx(x2sin, -1.0, 1.0, 15)