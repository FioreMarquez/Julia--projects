using Random, Statistics, Plots


Random.seed!(123)   # (Se fija una semilla) para que los resultados sean reproducibles

# --- Parámetros del modelo ---
struct Params
    a::Float64    # sensibilidad de la demanda a la tasa
    c::Float64    # sensibilidad de la demanda de dinero a la tasa
    σu::Float64   # desvío del shock de demanda agregada
    σv::Float64   # desvío del shock de demanda de dinero
end

p = Params(1.0, 0.5, 1.0, 1.0)

#  Resultados teóricos 
var_dinero(p) = (p.c^2 * p.σu^2 + p.a^2 * p.σv^2) / (p.a + p.c)^2   # (11.4)
var_tasa(p)   = p.σu^2                                              # (11.5)

#  Simulación Monte Carlo 
N = 100_000
u = p.σu .* randn(N)    # N shocks de demanda agregada
v = p.σv .* randn(N)    # N shocks de demanda de dinero

y_dinero = @. (p.c * u - p.a * v) / (p.a + p.c)
y_tasa   = u

println("Regla de dinero: simulada = ", var(y_dinero), " | teórica = ", var_dinero(p))
println("Regla de tasa:   simulada = ", var(y_tasa),   " | teórica = ", var_tasa(p))