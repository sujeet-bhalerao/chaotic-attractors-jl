using Plots
gr()

# Define the Thomas' Cyclically Symmetric Attractor
Base.@kwdef mutable struct ThomasAttractor
    dt::Float64 = 0.15
    b::Float64 = 0.1999
    x::Float64 = 1.0
    y::Float64 = 0.0
    z::Float64 = 1.0
end

function step!(t::ThomasAttractor)
    dx = -t.b * t.x + sin(t.y)
    dy = -t.b * t.y + sin(t.z)
    dz = -t.b * t.z + sin(t.x)
    t.x += t.dt * dx
    t.y += t.dt * dy
    t.z += t.dt * dz
end

attractor = ThomasAttractor()

# Initialize a 3D plot with 1 empty series
plt = plot3d(
    1,
    xlim = (-5, 5),
    ylim = (-5, 5),
    zlim = (-5, 5),
    title = "Thomas' Cyclically Symmetric Attractor",
    legend = false,
    marker = 2,
    lc = :blue,
    lw = 1,
)

# Build an animated gif by pushing new points to the plot, saving every 5th frame
anim = @animate for i = 1:2_000
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
    plot!(plt, camera=(10+ 0.1 * i, 10))
end every 10
gif(anim, "thomas_cyc_symmetric.gif", fps = 30)
