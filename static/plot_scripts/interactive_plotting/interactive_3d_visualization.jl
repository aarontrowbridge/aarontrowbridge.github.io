using WGLMakie
using JSServe

# this is optional and just changes the color theme
set_theme!(theme_dark())

# radial sinc function with scale parameter "a"
radial_sinc(x, y, a) = sinc(a * hypot(x, y)) 

# domain of surface
xs = LinRange(-5, 5, 150)
ys = LinRange(-5, 5, 150)

# creating the javascript app
app = App() do session::Session
    scale_slider = Slider(1:0.2:3)

    states = map(scale_slider) do a
        return [radial_sinc(x, y, a) for x in xs, y in ys]
    end

    fig, ax, = surface(xs, ys, states, figure=(resolution=(700, 400),))
    limits!(ax, -5, 5, -5, 5, -1, 2)

    scale_value = DOM.div("\\(a = \\)", scale_slider.value)
    
    return JSServe.record_states(
        session,
        DOM.div(fig, scale_value, scale_slider)
    )
end

output_file = "static/plot_html/interactive_plotting/sinc_surface.html"
open(output_file, "w") do io
    println(io, "<center>")
    show(io, MIME"text/html"(), Page(exportable=true, offline=true))
    show(io, MIME"text/html"(), app)
    println(io, "</center>")
end


