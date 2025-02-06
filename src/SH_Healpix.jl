using SphericalHarmonics, Healpix, Plots
gr()
default(
    fontfamily="serif-roman",
    guidefontsize=28,
    tickfontsize=16,
    legendfontsize=20,
    margin=10Plots.mm,
)

function plot_spherical_harmonic_healpix(l, m; nside=64)
    npix = Healpix.nside2npix(nside)
    map = Healpix.HealpixMap{Float64,RingOrder}(nside)

    for pix in 1:npix
        θ, φ = Healpix.pix2ang(map, pix)
        Ylm = SphericalHarmonics.sphericalharmonic(θ, φ; l=l, m=m)
        map[pix] = real(Ylm)
    end
    return map
end

function plot_single_frame(l, m; nside=64)
    map = plot_spherical_harmonic_healpix(l, m; nside=nside)
    plot(map, orthographic, color=:seismic, clim=(-1, 1), legend=false, title="\$Y^{$l}_{$m}\$")
end

plot_single_frame(4, 3)  # 例: l=3, m=2 の球面調和関数のプロットを作成
