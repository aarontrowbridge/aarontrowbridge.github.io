using WGLMakie, JSServe
WGLMakie.activate!()

a_init = 1
c_init = 4
p_init = 0

x_bound = 6
x = -1.5x_bound:0.01:1.5x_bound

# convex function
f(x; a=a_init, c=c_init) = 0.5 * a * x^2 + c

# transformed function to find max of
f_transform(x; p=p_init, a=a_init, c=c_init) = p * x - f(x; a=a, c=c)

# Legendre (conjugate) transform of of f 
f_conjugate(p; a=a_init, c=c_init) = p^2 / a - f(p / a; a=a, c=c)

set_theme!(theme_black())

app = App() do session::Session
    fig = Figure(resolution=(600, 400))
    ax = Axis(fig[1, 1])

    slider_p = Slider(-x_bound:0.1:x_bound)

    y = f.(x)
    y_conj = f_conjugate.(a_init * x)

    y_tran = lift(slider_p) do p
        f_transform.(x; a=a_init, p=p, c=c_init)
    end

    lines!(ax, x, y, label=L"f(x) = \frac{1}{2}ax^2 + c")
    lines!(ax, x, y_tran, label=L"px - f(x)")
    lines!(ax, x, y_conj, label=L"f^*(p=ax)")

    axislegend()
    ylims!(ax, -0.5 * a_init * x_bound^2, 0.5 * a_init * x_bound^2)
    xlims!(ax, -1.5x_bound, 1.5x_bound)

    value = DOM.div("\\(p = \\)", slider_p.value)

    return JSServe.record_states(
        session, DOM.div(fig, value, slider_p) 
    )
end

open("static/plot_html/legendre_app.html", "w") do io
    println(io, "<center>")
    show(io, MIME"text/html"(), Page(exportable=true, offline=true))
    show(io, MIME"text/html"(), app)
    println(io, "</center>")
end

