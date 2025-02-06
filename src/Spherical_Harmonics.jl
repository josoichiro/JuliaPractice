using SphericalHarmonics, Plots, LaTeXStrings
plotly()
Plots.default()


function plot_spherical_harmonic(l, m; resolution=100)
    θ_vals = range(0, π, length=resolution)   # θ は 0 から π
    φ_vals = range(0, 2π, length=resolution)  # φ は 0 から 2π

    X = zeros(resolution, resolution)
    Y = zeros(resolution, resolution)
    Z = zeros(resolution, resolution)
    Vals = zeros(resolution, resolution)

    for i in 1:resolution, j in 1:resolution
        θ, φ = θ_vals[i], φ_vals[j]

        Ylm = SphericalHarmonics.sphericalharmonic(θ, φ; l=l, m=m)
        X[i, j] = sin(θ) * cos(φ)  # 球面座標 → デカルト座標
        Y[i, j] = sin(θ) * sin(φ)
        Z[i, j] = cos(θ)
        Vals[i, j] = real(Ylm)
        # coeff = real(Ylm)
        # println("θ = $θ, φ = $φ, Ylm = $coeff")
    end
    surface(X, Y, Z, fill_z=Vals, c=:seismic, clim=(-1, 1), legend=false, colorbar=true)
    plot!(xaxis=("x"), yaxis=("y"), zaxis=("z"))
    title!("l = $l, m = $m")
end

plot_spherical_harmonic(4, 2)  # 例: l=3, m=2 の球面調和関数
