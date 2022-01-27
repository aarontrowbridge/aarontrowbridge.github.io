# %%

# script to create a widget with sliders
# for the Legendre transform of f

import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider, Button
import mpld3
from mpld3 import plugins 

plt.rcParams.update({
    'text.usetex': True,
    'font.family': 'serif',
    'font.serif': 'cm'
})

#%%

# convex function
def f(x, a, c):
    return 0.5 * a * x**2 + c

# transformed function to find max of
def f_transform(x, p, a, c):
    return p * x - f(x, a, c)

# Legendre transform of f
def f_conjugate(p, a, c):
    return p**2 / a - f(p / a, a, c)

x_limit = 4
x = np.linspace(-x_limit, x_limit, 1000)

# initialization parameters
init_a = 1
init_p = 0
init_c = 5

# %%

# plot figure
fig, ax = plt.subplots()
f_line, = ax.plot(x, f(x, init_a, init_c), label=r'$f(x) = \frac{1}{2}ax^2$')
f_transform_line, = ax.plot(x, f_transform(x, init_p, init_a, init_c),
                            label=r'$px - f(x)$')
f_conjugate_line, = ax.plot(x, f_conjugate(init_a * x, init_a, init_c), 
                            label=r'$f^*(p=ax)$')
ax.set_xlabel(r'$x$')
ax.legend()
ax.margins(0.1)
ax.grid()

# adjust plot to fit sliders
plt.subplots_adjust(bottom=0.3)

# create horizontal sliders for the parameters
ax_a = plt.axes([0.25, 0.15, 0.5, 0.03])
a_slider = Slider(
    ax=ax_a, 
    label='a', 
    valmin=0.1, 
    valmax=10,
    valstep=0.1, 
    valinit=init_a, 
    dragging=True
)

ax_p = plt.axes([0.25, 0.1, 0.5, 0.03])
p_slider = Slider(
    ax=ax_p, 
    label='p', 
    valmin=-5 * x_limit, 
    valmax=5 * x_limit, 
    valstep=0.1, 
    valinit=init_p, 
    dragging=True
)

ax_c = plt.axes([0.25, 0.05, 0.5, 0.03])
c_slider = Slider(
    ax=ax_c,
    label='c',
    valmin=-10,
    valmax=10,
    valstep=0.1,
    valinit=init_c,
    dragging=True
)

# define function to update the plot
def update(val):
    a = a_slider.val
    p = p_slider.val
    c = c_slider.val
    p_slider.valmin = -a * x_limit
    p_slider.valmax = a * x_limit
    f_line.set_ydata(f(x, a, c))
    f_transform_line.set_ydata(f_transform(x, p, a, c))
    f_conjugate_line.set_ydata(f_conjugate(a * x, a, c))
    fig.canvas.draw_idle()

# connect the slider to the function
a_slider.on_changed(update)
p_slider.on_changed(update)
c_slider.on_changed(update)

plt.show()

# create html file
# tooltip = plugins.PointHTMLTooltip(
#     f_transform_line,





# %%
