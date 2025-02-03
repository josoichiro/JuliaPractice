using LinearAlgebra
using Plots
Plots.default()


m1 = 1.0
m2 = 2.0

function velocity_update(dt, x, v)
    dx, dy = x[1] .- x[2]
    distance_cubed = (dx^2 + dy^2)^1.5
    v[1] .-= dt * m2 * (x[1] .- x[2]) / distance_cubed
    v[2] .+= dt * m1 * (x[1] .- x[2]) / distance_cubed
    return v
end

function position_update(dt, x, v)
    x .+= dt .* v
    return x
end

function energy(x, v)
    distance = sqrt(sum((x[1] .- x[2]) .^ 2))
    kinetic_energy = 0.5 * (m1 * sum(v[1] .^ 2) + m2 * sum(v[2] .^ 2))
    potential_energy = -m1 * m2 / distance
    return kinetic_energy + potential_energy
end

function analytic_solution(t)
    omega = sqrt(m1 + m2)
    x1 = cos.(omega .* t)
    y1 = sin.(omega .* t)
    x2 = -0.5 .* cos.(omega .* t)
    y2 = -0.5 .* sin.(omega .* t)
    return x1, y1, x2, y2
end

function main()
    t0 = 0.0
    dt = 1.0 / 16.0

    x = [[1.0, 0.0], [-0.5, 0.0]]
    v = [[0.0, 1.0], [0.0, -0.5]]
    timesteps = 2000
    t = t0

    t_analytic = range(t0, step=dt, length=timesteps)
    x1_analytic, y1_analytic, x2_analytic, y2_analytic = analytic_solution(t_analytic)
    E_analytic = energy(x, v)

    x1_vals = []
    y1_vals = []
    x2_vals = []
    y2_vals = []
    E_vals = []
    t_vals = []

    for i in 1:timesteps
        push!(t_vals, t)
        x = position_update(dt, x, v)
        v = velocity_update(dt, x, v)
        E = energy(x, v)
        t += dt
        push!(x1_vals, x[1][1])
        push!(y1_vals, x[1][2])
        push!(x2_vals, x[2][1])
        push!(y2_vals, x[2][2])
        push!(E_vals, E)
    end

    p1 = plot(x1_vals, y1_vals, label="object1 : Numerical", xlabel="\$x\$", ylabel="\$y\$")
    plot!(p1, x2_vals, y2_vals, label="object2 : Numerical")
    plot!(p1, x1_analytic, y1_analytic, label="object1 : Analytical")
    plot!(p1, x2_analytic, y2_analytic, label="object2 : Analytical")
    plot!(p1, aspect_ratio=:equal)
    title!(p1, "Solution of Two-body problem")

    p2 = plot(t_vals, E_vals, label="Numerical", xlabel="\$t\$", ylabel="\$E\$", legend=:topright)
    plot!(p2, t_analytic, fill(E_analytic, length(t_analytic)), label="Analytical")
    title!(p2, "Energy")

    plot(p1, p2, layout=(1, 2))
end

main()

