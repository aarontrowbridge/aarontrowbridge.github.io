using WGLMakie
WGLMakie.activate!()

fig = Figure(resolution=(700, 500))
ax = Axis(fig[1, 1])

a_init = 1
c_init = 4
p_init = 0

x_bound = 4
x = -x_bound:0.01:x_bound

# convex function
f(x; a=a_init, c=c_init) = 0.5 * a * x^2 + c

# transformed function to find max of
f_transform(x; p=p_init, a=a_init, c=c_init) = p * x - f(x; a=a, c=c)

# Legendre (conjugate) transform of of f 
f_conjugate(p; a=a_init, c=c_init) = p^2 / a - f(p / a; a=a, c=c)

# slider_a = Slider(fig[2,1], range=0.1:0.1:10, startvalue=a_init)
# slider_p = Slider(fig[3,1], range=-5x_bound:0.1:5x_bound, startvalue=p_init)
# slider_c = Slider(fig[4,1], range=0.1:0.1:10, startvalue=a_init)

lsgrid = labelslidergrid!(
    fig,
    [L"a", L"c", L"p"],
    [0.1:0.1:10, -10:0.1:10, -10:0.1:10];
    tellheight = false
)

fig[1,2] = lsgrid.layout

sliderobservables = [s.value for s in lsgrid.sliders]

y = lift(sliderobservables...) do a, c, p
    f.(x; a=a, c=c)
end

y_tran = lift(sliderobservables...) do a, c, p
    f_transform.(x; a=a, p=p, c=c)
end

y_conj = lift(sliderobservables...) do a, c, p
    f_conjugate.(a * x; a=a, c=c)
end

lines!(ax, x, y, label=L"f(x) = \frac{1}{2}ax^2 + c")
lines!(ax, x, y_tran, label=L"px - f(x)")
lines!(ax, x, y_conj, label=L"f^*(p=ax)")

axislegend()
ylims!(ax, -15, 15)

set_close_to!(lsgrid.sliders[1], a_init)
set_close_to!(lsgrid.sliders[2], c_init)
set_close_to!(lsgrid.sliders[3], p_init)

fig