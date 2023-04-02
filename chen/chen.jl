using Plots
gr()

# Define the Chen Attractor
Base.@kwdef mutable struct ChenAttractor
    dt::Float64 = 0.005
    a::Float64 = 40
    b::Float64 = 3
    c::Float64 = 28
    x::Float64 = 0.1
    y::Float64 = 0.1
    z::Float64 = 0.1
end

function step!(c::ChenAttractor)
    dx = c.a * (c.y - c.x)
    dy = (c.c - c.a) * c.x - c.x * c.z + c.c * c.y
    dz = c.x * c.y - c.b * c.z
    c.x += c.dt * dx
    c.y += c.dt * dy
    c.z += c.dt * dz
end

attractor = ChenAttractor()

# Initialize a 3D plot with 1 empty series
plt = plot3d(
    1,
    xlim = (-30, 30),
    ylim = (-30, 30),
    zlim = (0, 50),
    title = "Chen Attractor",
    legend = false,
    marker = 2,
    lc = :blue,
    lw = 1,
)

# Build an animated gif by pushing new points to the plot, saving every 5th frame
anim = @animate for i = 1:4_000
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
    plot!(plt, camera=(15 + 0.05*i, 25))
end every 20
gif(anim, "chen_attractor.gif", fps = 30)
