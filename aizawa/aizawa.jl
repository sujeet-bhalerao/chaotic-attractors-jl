using Plots
gr()

# Define the Aizawa Attractor
Base.@kwdef mutable struct AizawaAttractor
    dt::Float64 = 0.015
    a::Float64 = 0.95
    b::Float64 = 0.7
    c::Float64 = 0.6
    d::Float64 = 3.5
    e::Float64 = 0.25
    f::Float64 = 0.1
    x::Float64 = 0.1
    y::Float64 = 0.1
    z::Float64 = 0.1
end

function step!(a::AizawaAttractor)
    dx = (a.z - a.b) * a.x - a.d * a.y
    dy = a.d * a.x + (a.z - a.b) * a.y
    dz = a.c + a.a * a.z - (a.z)^3 / 3 - ((a.x^2 + a.y^2) * (1 + a.e * a.z) + a.f * a.z^2)
    a.x += a.dt * dx
    a.y += a.dt * dy
    a.z += a.dt * dz
end

attractor = AizawaAttractor()

plt = plot3d(
    1,
    xlim = (-2, 2),
    ylim = (-2, 2),
    zlim = (-1, 3),
    title = "Aizawa Attractor",
    legend = false,
    marker = 2,
    lc = :blue,
    lw = 1,
)

anim = @animate for i = 1:3_000
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
    plot!(plt, camera=(10+0.03*i, 20 + 0.01 * i))
end every 15
gif(anim, "aizawa_attractor.gif", fps = 30)
