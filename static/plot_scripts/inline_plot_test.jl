using WGLMakie, JSServe
WGLMakie.activate!()

set_theme!(theme_dark())

app1 = App() do session::Session
    fig = Figure(resolution=(400,400))

    n = 10
    n_slider = Slider(1:n)
    k_slider = Slider(1:n)
    a_slider = Slider(1:n)

    mat = map(i -> rand(4, 4), n_slider)
    
    ax, surf = surface(fig[1,1], mat)

    on(k_slider) do k
        translate!(surf, 0, 0, k)
    end

    on(a_slider) do a
        scale!(surf, 1, 1, 1/a)
    end

    slider1 = DOM.div("n: ", n_slider, n_slider.value)
    slider2 = DOM.div("k: ", k_slider, k_slider.value)
    slider3 = DOM.div("a: ", a_slider, a_slider.value)

    return JSServe.record_states(
        session, DOM.div(slider1, slider2, slider3, fig)
    )
end

app2 = App() do session::Session 
    n = 10
    index_slider = Slider(1:n)
    volume = rand(n, n, n)
    slice = map(index_slider) do idx
        return volume[:, :, idx]
    end

    fig = Figure(resolution=(800, 400))
    ax, cplot = contour(fig[1, 1], volume)

    rectplot = linesegments!(ax, Rect(-1, -1, 12, 12), linewidth=2, color=:red)
    on(index_slider) do idx
        translate!(rectplot, 0, 0, idx)
    end

    heatmap(fig[1, 2], slice)

    slider = DOM.div("z-index: ", index_slider, index_slider.value)

    return JSServe.record_states(session, DOM.div(slider, fig))
end

open("_includes/plot_html/test.html", "w") do io
    show(io, MIME"text/html"(), Page(exportable=true, offline=true))
    show(io, MIME"text/html"(), app1)
    show(io, MIME"text/html"(), app2)
end

