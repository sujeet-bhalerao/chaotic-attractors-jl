using Plots
gr()

# Define the Rabinovich-Fabrikant Attractor
Base.@kwdef mutable struct RabinovichFabrikant
    dt::Float64 = 0.05
    b::Float64 = 0.98
    g::Float64 = 0.1
    x::Float64 = 0.1
    y::Float64 = 0.1
    z::Float64 = 0.1
end

function step!(rf::RabinovichFabrikant)
    dx = rf.y * (rf.z - 1 + rf.x^2) + rf.g * rf.x
    dy = rf.x * (3 * rf.z + 1 - rf.x^2) + rf.g * rf.y
    dz = -2 * rf.z * (rf.b + rf.x * rf.y)
    rf.x += rf.dt * dx
    rf.y += rf.dt * dy
    rf.z += rf.dt * dz
end

attractor = RabinovichFabrikant()

# Initialize a 3D plot with 1 empty serie5
plt = plot3d(
    1,
    xlim = (-2, 2),
    ylim = (-4, 5),
    zlim = (0, 2),
    title = "Rabinovich-Fabrikant Attractor",
    legend = false,
    marker = 2,
    lc = :blue,
    lw = 1,
)

# Build an animated gif by pushing new points to t  he plot, saving every 5th frame
anim = @animate for i = 1:5_000
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
    plot!(plt, camera=(10 + 0.1* i, 30))
end every 20
gif(anim, "rabinovich_fabrikant_attractor.gif", fps = 30)
