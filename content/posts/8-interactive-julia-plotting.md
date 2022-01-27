---
title: "using Julia to do web based interactive plotting"
url: "posts/interactive-julia-plotting"
date: 2021-12-20T10:17:17-05:00 
description: "a tutorial for setting up web based interactive plots, using Julia and Makie.jl"
tags: ["julia", "web development", "data visualization"]
categories: ["computer science"] 
draft: false
showToc: true
TocOpen: false 
comments: true 
disableShare: false
hideSummary: false 
searchHidden: false 
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true 
cover:
    # image: "<image path/url>" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
editPost:
    URL: "https://github.com/aarontrowbridge/aarontrowbridge.github.io/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---


So you want inline interactive plots in your blog posts? But you don't want to learn javascript and there wasn't an obvious way to embed matplotlib?  

If your comfortable with (or willing to learn) Julia, there is a simple and elegant solution! [Makie.jl](https://makie.juliaplots.org/stable/) is a julia plotting package with a lot of functionality, including a backend system consisting of [WGLMakie and JSServe](https://makie.juliaplots.org/stable/documentation/backends_and_output/wglmakie/) which provides a way to embed makie plots---including 3d visualizations---right into html and inserted into markdown jekyll blog posts.

> DISCLAIMER: plots may not appear on some browsers, specifically safari, as WebGL is required and might not be supported.  Also, loading the page might take a couple seconds.

## a first example
A simple script to display a static 3d visualization---a contour plot of a random volume---looks like this:


```julia
using WGLMakie, JSServe
WGLMakie.activate!()

n = 10
volume = rand(n, n, n)
fig, ax, plotobj = contour(volume, figure=(resolution=(700, 700),))

output_file = "static/plot_html/interactive_plotting/contour.html"

# this is the essential component
open(output_file, "w") do io
    println(io, "<center>")
    show(io, MIME"text/html"(), Page(exportable=true, offline=true))
    show(io, MIME"text/html"(), fig) # we insert the figure here
    println(io, "</center>")
end
```

To include the plot in a jekyll blog post just use liquid---i.e.

```html
{{</* include-html "static/plot_html/interactive_plotting/contour.html" */>}}
```

which outputs:

{{< include-html "static/plot_html/interactive_plotting/contour.html" >}}

Using a mouse or touchpad, the figure can be rotated and zoomed. Pretty cool eh?

> * click and drag to rotate
> * mouse wheel or 2 fingers on track pad to zoom

This script works by converting the makie `fig` into an html blob that is written into `output_file`   
<br>

## more interactivity

Now lets try something with a little more interactivity; sliders are a good place to start.

Using makie we can write:

```julia
using WGLMakie, JSServe
WGLMakie.activate!()

# this is optional and just changes the color theme
set_theme!(theme_dark())

# radial sinc function with scale parameter "a"
radial_sinc(x, y, a) = sinc(a * hypot(x, y)) 

# domain of surface
xs = LinRange(-5, 5, 150)
ys = LinRange(-5, 5, 150)

# creating the javascript app
app = App() do session::Session

    # create the slider
    scale_slider = Slider(1:3)

    # map slider values to surface states
    states = map(scale_slider) do a
        return [radial_sinc(x, y, a) for x in xs, y in ys]
    end

    # create the figure
    fig, = surface(xs, ys, states)

    # show the slider value above the slider 
    # using "\\(a = \\)" to embed inline latex in markdown 
    scale_value = DOM.div("\\(a = \\)", scale_slider.value)
    
    # record a state map for the app and display fig above value above slider
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
```

which outputs:

{{< include-html "static/plot_html/interactive_plotting/sinc_surface.html" >}}

<!-- {{< include-html "static/plot_html/interactive_plotting/contour.html" >}} -->


## the future

Hopefully this demonstrates how julia can be used to do some pretty cool things in the browser. 

More sliders can be added as long as they are independent of each other.  In the future I will try to figure out dynamics (e.g. moving particles, fluctuating membranes), which I think would be pretty cool. :)

