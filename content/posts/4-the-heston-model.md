---
title: "the Heston stochastic volatility model"
url: "posts/the-heston-model"
date: 2021-08-01T10:17:17-05:00 
description: "an overview of a relatively modern and sophisticated model for pricing financial derivatives"
tags: ["mathematical finance", "stochastic processes", "optimization", "numerical methods"]
categories: ["mathematics"] 
draft: false
showToc: true
TocOpen: true 
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




The development of mathematical finance, much like the processes it aims to study, has had a particularly jumpy history.  A major leap came in 1973, when the [Black-Scholes option pricing model](https://en.wikipedia.org/wiki/Black-Scholes_model) was published and mathematically understood. The essential idea is to model the underlying asset $S_t$ of an option as a geometric brownian motion, with a stochastic differential equation (SDE), given by

$$
dS_t = \mu S_t \ dt + \sigma S_t \ dW_t,
$$

which contains a drift parameter $\mu$ and a *constant* volatility parameter $\sigma$. Taking the price of an option at time $t$ to be a function $C(S,t)$, [Ito's lemma](https://en.wikipedia.org/wiki/It%C3%B4%27s_lemma) applies and the famous Black-Scholes formula can be derived.

The first solved stochastic volatility model appeared in 1993, due to Steven Heston[^1], which aimed to correct the shortcomings of the Black-Scholes model and is what will be studied here.  

<br>

## The Heston Model

This model is essentially the same as the Black-Scholes model, except that on top of modelling the underlying asset $S$ as a stochastic process, the volatility parameter is also modelled as a stochastic process. In terms of SDEs

$$
\begin{align*}
dS_t &= \mu S_t \ dt + \sqrt{v_t} S_t \ dW_t^{(1)}, \\\\\\
dv_t &= \kappa(\bar{v} - v_t) \ dt + \sigma \sqrt{v_t} \ dW_t^{(2)}, \\\\\\
\end{align*}
$$

with

$$
dW_t^{(1)}dW_t^{(2)} = \rho dt.
$$

The five parameters of the model:

* $v_0$, the initial volatility
* $\bar{v}$, the long variance
* $\rho$, the correlation of the two Wiener processes
* $\kappa$, the rate at which $v_t$ reverts to $\bar{v}$
* $\sigma$, the volatility of the volatility

We will use $\mathbf{\theta} = [v_0, \bar{v}, \rho, \kappa, \sigma]^\top$ to represent the vector of parameters of the model.

<br>

## Pricing Derivatives

For a vanilla call option with strike $K$ and maturity $T$, where the underlying asset has a spot price $S_0$ and interest rate $r$, we can use our model to estimate the price:

$$
\begin{align*}
C(\mathbf{\theta}; K, T) &= e^{-rT} \mathbb{E} \left[\left( S_T - K \right)1_{\{S_T \geq K \} }(S_T) \right] \\\\\\ 
&= e^{-rT} \left( \mathbb{E} \left[ S_T \ 1_{\{S_T \geq K \}}(S_T)\right] - K \mathbb{E} \left[ 1_{\{S_T \geq K \}}(S_T)\right] \right) \\\\\\
&= S_0 P_1 - e^{-rT}K P_2 \\\\\\
\end{align*} 
$$

Here $P_1$ and $P_2$ are given as

$$
\begin{align*}
P_1 &=  \frac{1}{2} + \frac{1}{\pi}\int_0^{\infty} \operatorname{Re} \left( \frac{e^{-iu \log K}}{iuF} \varphi(\theta; u - i, T) \right) \mathrm{d}u, \\\\\\ 
P_2 &=  \frac{1}{2} + \frac{1}{\pi}\int_0^{\infty} \operatorname{Re} \left( \frac{e^{-iu \log K}}{iu} \varphi(\theta; u, T) \right) \mathrm{d}u, \\\\\\ 
\end{align*}
$$

with $F = S_0 e^{rT}$ and $\varphi(\theta; u, t)$ is the characteristic function of the logarithm of the stock price model.  

The characteristic function was given in its original form by Heston and subsequently in other forms that tried to avoid discontinuities and be analytically differentiable.  The representation that achieved both of these goals was given by Cui et al.[^2] in 2016.  It is given by 

$$ 
\varphi(\theta; u, t) = \exp \left\\{ iu \left( \log S_0 + rt - \frac{t \kappa \bar{v} \rho}{\sigma} \right) - v_0 A + \frac{2 \kappa \bar{v}}{\sigma^2} D\right\\}
$$

where 

$$
\begin{align}
A &:= \frac{A_1}{A_2}, \\\\\\
A_1 &:= (u^2 + iu)\sinh \frac{dt}{2}, \\\\\\
A_2 &:= d \cosh \frac{dt}{2} + \xi \sinh \frac{dt}{2}, \\\\\\
\end{align}
$$

and

$$
D := \log d + \frac{(\kappa - d)t}{2} - \log \left( \frac{d + \xi}{2} + \frac{d - \xi}{2}e^{-dt}\right),
$$

with

$$
\begin{align}
d &:= \sqrt{\xi^2 + \sigma^2(u^2 + iu)}, \\\\\\
\xi &:= \kappa - i \sigma \rho u, \\\\\\
\end{align}
$$

<br>

## Calibrating The Model

In order to calibrate the parameters of our model to the observed market data we will seek to minimize the difference between the market price of a vanilla call option $C^*(K_i, T_i)$ and our model's prediction $C(\theta; K_i, T_i)$ for various strikes and maturities, $K_i$ and $T_i$ respectively.  We compute a residual vector $\mathbf{r}(\theta) \in \mathbb{R}^n$ for the $n$ options, with $i$th component

$$
r_i(\theta) := C(\theta; K_i, T_i) - C^*(K_i, T_i), \qquad i = 1,\dots,n.
$$

The optimization problem can then be stated as nonlinear least squares problem

$$
\min_{\theta \in \mathbb{R}^m}f(\theta).
$$

Where $m = 5$, in this case, is the dimesion of the parameter vector and 

$$
f(\theta) := \frac{1}{2} \|\mathbf{r}(\theta)\|^2 = \frac{1}{2} \mathbf{r}^\top(\theta)\mathbf{r}(\theta).
$$

Here we have $n \gg m$ so the optimization problem is overdetermined but there is significant computational cost involved in evaluating $C(\theta; K, T)$.  Additionally an analytic expression for the gradient was not known until just recently, also given by Cui et al.

### Analytic Gradient

We use $\nabla = \partial / \partial \theta$ as the gradient operator with respect to the parameter vector $\theta$ and $\nabla \nabla^\top$ for the Hessian operator.  We are interested in calculating the gradient and Hessian of the objective function $f(\theta)$:

$$
\begin{align}
\nabla f &= \nabla \left( \frac{1}{2} \mathbf{r}^\top \mathbf{r} \right) \\\\\\
&= \nabla \mathbf{r}^\top \mathbf{r} \\\\\\
&= \mathbf{J} \mathbf{r} \\\\\\
\end{align}
$$

where $\mathbf{J} := \nabla \mathbf{r}^\top$ is the Jacobian matrix of the residual vector $\mathbf{r}$ which has elements 

$$
J_{ij} = \frac{\partial r_j}{\partial \theta_i}.
$$

The Hessian of the objective function is then

$$
\begin{align*}
\nabla \nabla^\top f &= \nabla \nabla^\top \left( \frac{1}{2} \mathbf{r}^\top \mathbf{r} \right) \\\\\\
&= \nabla \left(\nabla \mathbf{r}^\top \mathbf{r} \right)^\top \\\\\\
&= \nabla \left( \mathbf{r}^\top \left( \nabla \mathbf{r}^\top \right)^\top \right) \\\\\\
&= \nabla \mathbf{r}^\top \left( \nabla \mathbf{r}^\top \right)^\top + \sum_i r_i \nabla \nabla^\top r_i \\\\\\
&= \mathbf{J}\mathbf{J}^\top + \sum_i r_i \mathbf{H}(r_i) \\\\\\
\end{align*}
$$

where $\mathbf{H}(r_i) := \nabla \nabla^\top r_i$ is the Hessian matrix for each residual $r_i$ with components

$$
H_{jk}(r_i) = \frac{\partial^2r_i}{\partial \theta_j \partial \theta_k}.
$$

For details of the calculation of $\nabla C(\theta; K, T)$ needed in the implementation of the optimization algorithm described below see Theorem 1 in the paper by Cui et al.  As can be inferred from the form of the characteristic function it is not clean!

### The Levenberg-Marquardt Method

The [LM algorithm](https://en.wikipedia.org/wiki/Levenberg-Marquardt_algorithm) aims to solve the problem of minimizing the squared residuals of the model.  We wish to find

$$
\hat\theta \in \arg\min_{\theta} f(\theta).
$$

Here, $\hat\theta$ is not necessarily a *global* minimum (though we hope to show it is), which is why the member notation is used in place of equality.

The derivation of the parameter space search step goes as follows:

$$
\begin{align*}
f(\theta + \Delta \theta) &\approx f(\theta) + \Delta \theta^\top \nabla f + \frac{1}{2} \Delta \theta^\top \left(\nabla \nabla^\top f \right) \Delta \theta. \\\\\\
&= f(\theta) + \Delta \theta^\top \nabla f + \frac{1}{2} \Delta \theta^\top \left(\mathbf{J} \mathbf{J}^\top + \sum_i r_i \mathbf{H}(r_i) \right)\Delta \theta. \\\\\\
&\approx f(\theta) + \Delta \theta^\top \nabla f + \frac{1}{2} \Delta \theta^\top \mathbf{J} \mathbf{J}^\top \Delta \theta. \\\\\\
% f(\theta + \Delta \theta) &= \frac{1}{2}\mathbf{r}(\theta + \Delta \theta)^\top \mathbf{r}(\theta + \Delta \theta) \\\\\\
% &\approx \frac{1}{2} \left( \mathbf{r}(\theta) + \mathbf{J}^\top \Delta \theta \right)^\top\left( \mathbf{r}(\theta) + \mathbf{J}^\top \Delta \theta \right) \\\\\\
% &= \frac{1}{2} \left( \mathbf{r}(\theta)^\top \mathbf{r}(\theta) + 2 \mathbf{r}(\theta)^\top \mathbf{J}^\top \Delta \theta + \Delta \theta^\top \mathbf{J} \mathbf{J}^\top \Delta \theta \right) \\\\\\
% &= f(\theta) + \nabla f^\top \Delta \theta + \frac{1}{2} \Delta \theta^\top \mathbf{J} \mathbf{J}^\top \Delta \theta. \\\\\\
\end{align*}
$$

Where the last line is a valid approximation when the residuals $r_i$ or the Hessian of the residuals $\mathbf{H}(r_i)$ are small.

Now taking the derivative with respect to $\Delta \theta$, setting it equal to zero, and flipping the sign (to descend the space), we arrive at the search step:

$$
\Delta \theta = \left( \mathbf{J}\mathbf{J}^\top + \mu \mathbf{I} \right)^{-1} \nabla f.
$$

Here the $\mu \mathbf{I}$ term is Levenberg's contribution, and acts as a damping factor that is dynamically adjusted to interpolate between the method of steepest descent and the [Gauss-Newton method](https://en.wikipedia.org/wiki/Gauss-Newton_algorithm). 

When the residuals are large (the model is far from the optimum), $\mu$ is set large, resulting in a steepest descent approach.  When close to the optimum, $\mu$ is made small, resulting in the Gauss-Newton method.  

For details of the LM calibration algorithm see Algorithm 4.1 in Cui et al.[^2] 
<br>

## Implementation and Results

A incomplete repository of code can be found at my github in [LevyProcesses](https://github.com/aarontrowbridge/LevyProcesses).  I will be following up with a new post when I have a working model. 


## References

[^1]: Heston (1993) "Closed-Form Solution for Options with Stochastic Volatility with Applications to Bond and Currency Options" [pdf](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.139.3204&rep=rep1&type=pdf)

[^2]: Cui et al. (2015) "Full and fast calibration of the Heston stochastic volatility model" [arxiv:1511.08718](https://arxiv.org/abs/1511.08718v2)