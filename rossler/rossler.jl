using Plots
gr()

# Define the Rössler attractor
Base.@kwdef mutable struct Rossler
    dt::Float64 = 0.03
    a::Float64 = 0.2
    b::Float64 = 0.2
    c::Float64 = 5.7
    x::Float64 = 1
    y::Float64 = 1
    z::Float64 = 1
end

function step!(r::Rossler)
    dx = -r.y - r.z
    dy = r.x + r.a * r.y
    dz = r.b + r.z * (r.x - r.c)
    r.x += r.dt * dx
    r.y += r.dt * dy
    r.z += r.dt * dz
end

attractor = Rossler()

# Initialize a 3D plot with 1 empty series
plt = plot3d(
    1,
    xlim = (-15, 15),
    ylim = (-15, 15),
    zlim = (0, 40),
    title = "Rössler Attractor",
    legend = false,
    marker = 2,
    lc = :blue,
    lw = 1,
)

# Build an animated gif by pushing new points to the plot, saving every 5th frame
anim = @animate for i = 1:5_000
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
    plot!(plt, camera=(10, 30))
end every 10
gif(anim, "rossler_attractor.gif", fps = 30)
