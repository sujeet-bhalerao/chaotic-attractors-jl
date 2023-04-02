using Plots
gr()

# Define the Chua attractor
Base.@kwdef mutable struct Chua
    dt::Float64 = 0.02
    alpha::Float64 = 15.6
    beta::Float64 = 28
    m0::Float64 = -1.143
    m1::Float64 = -0.714
    x::Float64 = 0.7
    y::Float64 = 0.1
    z::Float64 = 0.3
end

function g(v::Float64, m0::Float64, m1::Float64)
    return m1 * v + (m0 - m1) * abs(v + 1) / 2 - (m0 - m1) * abs(v - 1) / 2
end

function step!(c::Chua)
    dx = c.alpha * (c.y - c.x - g(c.x, c.m0, c.m1))
    dy = c.x - c.y + c.z
    dz = -c.beta * c.y
    c.x += c.dt * dx
    c.y += c.dt * dy
    c.z += c.dt * dz
end

attractor = Chua()

# Initialize a 3D plot with 1 empty series
plt = plot3d(
    1,
    xlim = (-3, 3),
    ylim = (-1, 1),
    zlim = (-5, 5),
    title = "Chua Attractor",
    legend = false,
    marker = 2,
    lc = :blue,
    lw = 1,
)

# Build an animated gif by pushing new points to the plot, saving every 5th frame
anim = @animate for i = 1:3_000
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
    plot!(plt, camera=(10 + 0.1*i, 25))
end every 10
gif(anim, "chua_attractor.gif", fps = 30)
