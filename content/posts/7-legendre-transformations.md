---
title: "Legendre transformations"
url: "posts/legendre-transformations"
date: 2021-12-09T10:17:17-05:00 
description: "a discussion of the Legendre transformation and its applications to physics"
tags: ["mathematical methods", "convex analysis", "analytical mechanics"]
categories: ["mathematics", "physics"] 
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
    image: "images/legendre_transformations/legendre_cover.png" # image path/url
    alt: "<alt text>" # alt text
    caption: "Legendre transformation visualization" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
editPost:
    URL: "https://github.com/aarontrowbridge/aarontrowbridge.github.io/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---


Courses and textbooks, at least in undergrad, often gloss over the details of *the Legendre transformation*, which converts *convex* functions of one variable into another convex function of the "*conjugate*" variable. Used ubiquitously in physics, from thermodynamics to quantum field theory, this mathematical method plays a central role in connecting some of the most fundamental concepts, and yet, at least to me for a while, was a mysterious black-box procedure.  I am now going to attempt to illuminate this technique. 

Let's begin with the technical definition:

> **Definition** Given a convex function $f: I \subset \mathbb{R} \to \mathbb{R}$ of a variable $x$, the Legendre transform, or convex conjugate, $f^* : I^* \to \mathbb{R}$ in terms of the conjugate variable $x^*$ is given by
>
>$$
\begin{equation}
>f^*(x^\*) = \sup_{x \in I} \big( x^\* x - f(x)\big), \ \ x^\* \in I^\*
\end{equation}
>$$
>
>where
>
>$$
>I^* = \left\\{ x^* \in \mathbb{R} : \sup_{x \in I} \big( x^* x - f(x)\big) < \infty \right\\}
>$$

This definition generalizes to convex functions of higher dimensions by replacing $x^{\*}x$ with $\langle x^*, x \rangle$, the appropriate inner product. 

Below is an interactive plot (made with Julia) demonstrating how $f^*(p)$ depends on the maximum of the transformed function $px-f(x)$ for a given function $f(x) = \frac{1}{2}ax^2 + c$, where here $a = 1$ and $c = 4$. The derivation of these functions will be made clear below, but this might give some intuition into the transformation.

{{< include-html "static/plot_html/legendre_app.html" >}}

Notice that the maximum of the orange curve always lies on the green curve $f^*$.

<br>

## a more explicit definition

For a fixed $x^\*$ we can find $f^*(x^\*)$ by finding $\bar x$, s.t. the expression in (1) is maximized, via the standard method from calculus, and the fact that a linear function minus a convex function is a concave function.

$$
\begin{align}
0 &= \frac{d}{dx} \big( x^* x - f(x) \big)\bigg\rvert\_{x=\bar x} \nonumber \\\\\\
&= x^* - f'(\bar x) \nonumber \\\\\\
\nonumber \\\\\\
\implies \bar x &= \big(f'\big)^{-1}(x^*) \\\\\\ \nonumber 
\end{align}
$$

Keeping in mind that $\bar x$ depends on $x^*$, we can now write 

$$ 
\begin{equation}
\boxed{
f^*(x^{\*}) = x^{\*} \bar x - f(\bar x)
}
\end{equation}
$$ 

which is our first explicit definition of the Legendre transform of $f$. Then, taking the derivative, we find that 

$$
\begin{align*}
\big(f^\*(x^{\*})\big)' &= \bar x + x^{\*} \frac{d \bar x}{dx^{\*}} - f'(\bar x) \frac{d \bar x}{dx^{\*}} \\\\\\
&= \bar x. \\\\\\ 
\end{align*}
$$

This is true since (2) implies $f'(\bar x) = x^*$, which then implies 

$$
\begin{equation}
\boxed{
\big( f^* \big)' = \big( f' \big)^{-1}.
}
\end{equation}
$$

Thus (4) is an equivalent way to specify $f^\*$ up to an additive constant by integrating both sides of the expression with respect to $x^\*$. 

<br>

## mechanics

Considering a mechanical system, we can specify the dynamics of the system by considering the *Lagrangian* functional for a given path $q(t)$, which, for all intents and purposes can be written as:

$$
\mathcal{L}[q(t)] = \mathcal{L}(q, \dot q; t) \equiv \frac{1}{2}m \dot q^2 - V(q) 
$$

This defines a function on *configuration space* (technically the tangent bundle $T\mathcal{M}$ of a manifold $\mathcal{M}$), with coordinates $(q, \dot q)$. Given starting and ending coordinates, the physical solution is given by extremizing the action functional $ S[q(t)] = \int dt \ \mathcal{L}[q]$, resulting in the Euler-Lagrange equation:

$$
\frac{d}{dt}\frac{\partial \mathcal{L}}{\partial \dot q} =\frac{\partial \mathcal{L}}{\partial q} 
$$


> ### **an aside on conjugates**
>
> Before proceeding, I must comment that there seems to exist inconsistent  definitions of conjugate variables or at least inconsistent usage of the term.  For example, the classical definition of a [conjugate variable](https://en.wikipedia.org/wiki/Conjugate_variables) in mechanics is the result of differentiating the action with respect to the original variable--e.g. schematically for $q$
>
> $$
> \begin{align*}
> \frac{\partial S}{\partial q} &= \int dt \frac{\partial \mathcal{L}}{\partial q} \\\\\\
> &= \int dt \frac{d}{dt} \frac{\partial \mathcal{L}}{\partial \dot q} \\\\\\
> &= \frac{\partial \mathcal{L}}{\partial \dot q} \\\\\\
> &\equiv p \\\\\\
> \end{align*}
> $$
>
> So $p$ is conjugate to $q$, but the literature ([wikipedia](https://en.wikipedia.org/wiki/Legendre_transformation)) seems to say that $p$ is conjugate to $\dot q$ in the context of Legendre transforms.  I am looking out for clarification regarding this point.

For fixed $q$, we can view $\mathcal{L}$ as a convex function of $\dot q$, so 

$$
\mathcal{L}'(\dot q) = m \dot q \implies \big(\mathcal{L}'\big)^{-1}(p) = \frac{p}{m}.
$$

We can now find the Legendre transform of $\mathcal{L}$ taking $\dot q \to p$, using (3):

$$
\begin{align*}
\mathcal{L}^\*(q, p) &= \big( p \dot q - \mathcal{L}(q, \dot q) \big)\bigg\rvert_{\dot q = \big(\mathcal{L}'\big)^{-1}(p)} \\\\\\
&= p \left( \frac{p}{m} \right) - \mathcal{L}\left( q, \frac{p}{m} \right) \\\\\\
\\\\\\
\implies \mathcal{H}(q, p) &\equiv \frac{p^2}{2m} + V(q) = \mathcal{L}^\*(q, p) \\
\end{align*} 
$$


Here, $\mathcal{H}$ is the *Hamiltonian* - a function of the system's *phase space* (technically the cotangent bundle $T^*\mathcal{M}$)

For completeness' sake, let's see how this works with the alternative definition (4).  With $q$ fixed

$$
\begin{align*}
\mathcal{H}(q,p) &= \int dp \ \left(\frac{\partial \mathcal{L}}{\partial \dot q}\right)^{-1} \\\\\\
&= \int dp \ \frac{p}{m} \\\\\\
&= \frac{p^2}{2m} + C 
\end{align*}
$$

which matches (4) when we recognize the constant of integration $C = V(q)$.