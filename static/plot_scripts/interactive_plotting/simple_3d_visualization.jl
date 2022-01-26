using WGLMakie, JSServe
WGLMakie.activate!()

n = 10
volume = rand(n, n, n)
fig, ax, plotobj = contour(volume; figure=(resolution=(700, 700),))

output_file = "static/plot_html/interactive_plotting/contour.html"

open(output_file, "w") do io
    println(io, "<center>")
    show(io, MIME"text/html"(), Page(exportable=true, offline=true))
    show(io, MIME"text/html"(), fig)
    println(io, "</center>")
end


