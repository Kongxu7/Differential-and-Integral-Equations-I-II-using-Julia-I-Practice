using Pkg

using Plots

using ForwardDiff

gr()

x = [1, 2, 5]
y = [1, 3, 4]
plot(x, y)

scatter(x, y)

f(x) = x^2
x = range(-1, 2, length =50)
y = f.(x)
plot(x, y)

f(x) = exp(-x) * sin(x) + cos(x) * exp(x) + 8
x = range(-2, 2, length=100)
y = f.(x)
plot(x, y, color=:cyan, lw=2, lab="j", annotation=[(x[i],
 y[i] + 0.100, text(string(x[i]), 5)) for i = 1:100],
 m=(:circle, 4, :red, stroke(2,:cyan)), linestyle=:dash,
 grid = false, axis = true, yaxis =:log, xticks=([-π / 2, 0, π / 2], ["-\\pi/2", "0", "\\pi/2"]),
 legend=:bottomright
)


x = range(-0.2, 2π+0.2, length=100)
ycos = cos.(x)
ysin = sin.(x) #ponto para aplicar ponto a ponto, em td o coiso
plot(x, ycos, lab="cos")
plot!(x, ysin, lab="sin")
plot!([-0.2, 2π + 0.2], [1, 1], c=:purple, lab="", l=:dash)
plot!([-0.2, 2π + 0.2], [-1, -1], c=:purple, lab="", l=:dash)
xlims!(-0.2, 2π + 0.2)
ylims!(-1.1, 1.1)
xticks!(0:π/2:2π, ["0", "\\pi/2", "\\pi", "3\\pi/2", "2\\pi"])
yticks!([-1, 0, 1])
plot!(legend=:outerbottomright)
xlabel!("Dominio de 0 a 2\\pi")
ylabel!("Seno e cosseno")

png("graph")

#x^2 + y^2 = 1
t = range(0, 2π, length = 360)
rx(t) = cos(t) * (1+0.7 *cos(4t))
ry(t) = sin(t) * (1+0.7 * cos(4t))
a = 0.3
drx(t) = (rx(t+1e-8) - rx(t)) / 1e-8
dry(t) = (ry(t+1e-8) - ry(t)) / 1e-8
x = cos.(t) .* cos.(4t)
y = sin.(t) .* cos.(4t)
@gif  for a=0:0.01π:2π
    plot(x, y, aspect_ratio =:equal, leg= false, axis=false, grid=false)
    scatter!([rx(a)], [ry(a)], c=:pink, ms=3)
    plot!([rx(a), rx(a) + drx(a)], [ry(a), ry(a) + dry(a)], c=:pink, l=:arrow)
end


png("flower")

plotlyjs(size=(400, 300))
f(x, y) = x^6 - 6x^7 + y^3
xg = range(-8, 8, length = 100)
yg = range(-8, 8, length = 100)
surface(xg, yg, f)


gr(size=(400,300))
f(x) = x[1]^3 - 3x[1] + x[2]^2
F(x) = ForwardDiff.gradient(f, x)
xg = range(-2, 2, length=10)
yg=range(-2, 2, length=10)
XG = repeat(xg, outer=length(yg))
YG = repeat(yg, inner=length(xg))
UV = F.([[XG[i]; YG[i]] for i=1:length(XG)])
u = [uv[1] for uv in UV]
v = [uv[2] for uv in UV]
maxuv = 2.0 * maximum(sqrt.(u.^2 + v.^2))
u = u/maxuv
v = v/maxuv
xg = range(-2, 2, length=100)
yg=range(-2, 2, length=100)
contour(xg, yg, (x, y) -> f([x;y]))
quiver!(XG, YG, quiver =(u,v))
xlims!(-2, 2)
ylims!(-2,2)
