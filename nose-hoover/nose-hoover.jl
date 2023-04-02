using Plots
gr()

# Define the Nose-Hoover Attractor
Base.@kwdef mutable struct NoseHoover
    dt::Float64 = 0.08
    a::Float64 = -1
    b::Float64 = 0.01
    x::Float64 = 0.1
    y::Float64 = 0.1
    z::Float64 = 0.1
end

function step!(nh::NoseHoover)
    dx = nh.y
    dy = -nh.x + nh.z * nh.y
    dz = - nh.b * nh.y^2 +  1
    nh.x += nh.dt * dx
    nh.y += nh.dt * dy
    nh.z += nh.dt * dz
end

attractor = NoseHoover()

# Initialize a 3D plot with 1 empty series
plt = plot3d(
    1,
    xlim = (-40, 10),
    ylim = (-40, 20),
    zlim = (-10, 10),
    title = "Nose-Hoover Attractor",
    legend = false,
    marker = 2,
    lc = :blue,
    lw = 1,
)

# Build an animated gif by pushing new points to the plot, saving every 5th frame
anim = @animate for i = 1:3_000
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
    plot!(plt, camera=(15+ 0.05*i, 0 + 0.008*i ))
end every 15
gif(anim, "nose_hoover_attractor.gif", fps = 30)
