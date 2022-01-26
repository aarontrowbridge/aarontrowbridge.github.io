---
title: "ghosts, gauges, and generating functionals"
url: "posts/ghosts-gauges-and-generating-functionals"
date: 2021-10-31 
description: "a derivation of the gauge fixed Yang-Mills generating functional, with ghosts"
tags: ["gauge theory", "quantum field theory", "path integrals"]
categories: ["physics"] 
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


We saw in [a previous post]({{< ref "5-central-identity-of-QFT" >}}) that for a non-interacting theory (i.e. $V(\varphi) = 0$) that the generating functional can be written as 

$$
Z[J] = e^{\frac{1}{2} J \cdot K^{-1} \cdot J}.
$$

We hinted that it is not always the case that $K$ can be naively inverted. The issue arises when we consider the *Maxwell action* for a $U(1)$ gauge potential $A_\mu$:

$$
S(A) = \int d^4 x \left[ \frac{1}{2} A_\mu \left( \partial^2 g^{\mu \nu} - \partial^\mu \partial^\nu \right) A_\nu + A_\mu J^\mu \right].
$$

Here the operator we are looking to invert is 

$$
\begin{equation}
Q^{\mu \nu} \equiv \partial^2 g^{\mu \nu} - \partial^\mu \partial^\nu
\end{equation}
$$

which has zero eigenvalues for vectors of the form $\partial_\mu \theta(x)$: 

$$
Q^{\mu \nu} \partial_\mu \theta(x) = \left(\partial^2 g^{\mu \nu} \partial_\nu - \partial^\nu \partial_\nu \partial^\mu \right) \theta(x) = 0
$$ 

So, $Q^{\mu \nu}$ is not invertible and the issue is gauge redundancy - we need to fix a gauge.


<br>

## the Faddeev-Popov procedure

An interpretation of the issue is that the redundancy in the gauge field, where acting with $g \in U(1)$, takes $A_\mu \to A_\mu - \partial_\mu \theta \equiv A_g$; which is not a physical symmetry of the system, but still gets naively integrated over in the generating functional: 

$$
\begin{align*}
Z &= \int \mathcal{D}A \ e^{iS(A)} \\\\\\
&= \int \mathcal{D}A \int \mathcal{D}g \ e^{iS(A_g)} \\\\\\
\end{align*}
$$

Which diverges.

The naive path integral effectively over counts and blows up. What we need to do is insert a constraint on the gauge (e.g. $f(A_g) = 0$), which can be done by inserting 

$$
\begin{equation}
1 = \int \mathcal{D}g \ \delta\left( f(A_g) \right) \det \left( \frac{\partial f(A_g)}{\partial{g}} \right) = \Delta(A)\int \mathcal{D}g \ \delta\left( f(A_g) \right), 
\end{equation}
$$ 

where $\Delta(A)$ is *the Faddeev-Popov determinant* which is gauge invariant. We then get 

$$
\begin{aligned}
Z &= \int \mathcal{D}A \ e^{iS(A)} \\\\\\
&= \int \mathcal{D}A \ e^{iS(A)} \ \Delta(A) \int \mathcal{D}g  \ \delta\left( f(A_g) \right) \\\\\\
&= \int \mathcal{D}g \int \mathcal{D}A \ e^{iS(A)} \ \Delta(A) \ \delta\left( f(A_g) \right) \\\\\\
&= \left( \int \mathcal{D}g \right) \int \mathcal{D}A \ e^{iS(A)} \ \Delta(A) \ \delta\left( f(A) \right) \\\\\\
\end{aligned}
$$ 

Where we arrived at the final result by noting that the path integral measure $\mathcal{A}$ is gauge invariant and shifting $A \to A_{g^{-1}}$ removes the gauge dependence from $\delta(f(A_g))$. The factor outside, $\left( \int \mathcal{D}g \right)$ is an infinite constant that we can drop, as it has no physical effect. 


To see how this procedure works with QED check out Zee's wonderful book *Quantum Field Theory in a Nushell*, which was my primary reference for this post. 




## ghosts in non-abelian gauge theories

We will now turn our attention towards *quantum Yang-Mills theory*, where the gauge group being considered is non-abelian, for all intents and purposes is $SU(N)$.  Here things get very *spooky*.

In a pure non-abelian gauge theory, each component of the gauge potential $A_\mu$ transforms under the adjoint representation of the gauge group, in such a way that the action remains gauge invariant--i.e. 

$$
A_\mu(x) \to U(x)A_\mu(x)U^\dagger(x) + iU(x)\partial_\mu U^\dagger(x)
$$

One can note that if $U$ does not vary throughout space, $A$ really does transform in the adjoint representation; the extra term comes from the requirement for gauge invariance in a theory where the gauge group can act differently at each spacetime coordinate.

Now, given a set of generators for the gauge group, $\{T^a\}$, really a Lie algebra, we can see that under an infinitesimal gauge transformation ($U(x) \simeq 1 + i\theta^a T^a$), and noting we can decompose $A_\mu = A^a_\mu T^a $, we see that 

$$
A^a_\mu \to A^a_\mu - f^{abc}\theta^b A^c_\mu + \partial_\mu \theta^a. 
$$ 

Where the structure constants $f^{abc}$ are defined by $[T^a, T^b] = f^{abc}T^c$.

Let's now choose a gauge fixing condition to be $f(A) = \partial^\mu A_\mu - \sigma$, with $\sigma$ arbitrary. By (2) we then have

$$
\begin{align*}
\Delta(A) &= \left\\{\int \mathcal{D}\theta \ \delta\left[ f(A) \right] \right\\}^{-1} \\\\\\
&= \left\\{\int \mathcal{D}\theta \ \delta\left[ \partial^\mu A^a_\mu - \sigma^a \right] \right\\}^{-1} \\\\\\
&= \left\\{\int \mathcal{D}\theta \ \delta\left[ \partial^\mu A^a_\mu - \sigma^a - \partial^\mu \left( f^{abc}\theta^b A^c_\mu + \partial_\mu \theta^a \right)\right] \right\\}^{-1} \\\\\\
``&= \text{''} \ \left\\{\int \mathcal{D}\theta \ \delta\left[ \partial^\mu \left( f^{abc}\theta^b A^c_\mu + \partial_\mu \theta^a \right)\right] \right\\}^{-1} \\\\\\
\end{align*}
$$

Where there are quotes around the equality of the last line because we have yet to muliply by the gauge constraint $\delta[f(A)]$. 

Now lets formally define an operator $K^{ab}(x,y)$ by 

$$
\partial^\mu \left( f^{abc}\theta^b A^c_\mu + \partial_\mu \theta^a \right) = \int d^4y \ K^{ab}(x, y) \theta^b(y).
$$

that is

$$
K^{ab}(x,y) \equiv \partial^\mu \left( f^{abc} A^c_\mu - \partial_\mu \delta^{ab} \right) \delta^{(4)}(x - y)
$$

A generalization of the delta function identity, $\int d\theta \ \delta(K\theta) = 1/K$, to a vector $\theta$ and matrix $K$, gives us $\int d\theta \ \delta(K\theta) = 1 / \det K$.  We also have that anti-commuting [Grassmann variables](https://en.wikipedia.org/wiki/Grassmann_number#Integration) allow us to write $\det K = \int d\eta d\eta^\dagger \exp\left[-\eta^\dagger \cdot K \cdot \eta\right]$.  Pulling all of this together we see that

$$
\Delta(A) = \det K^{ab}(x,y) = \int \mathcal{D} c \mathcal{D} c^\dagger e^{i S_{\text{ghost}}(c^\dagger, c)} 
$$ 

where

$$
\begin{aligned}
S_{\text{ghost}}(c^\dagger, c) &= \int d^4x d^4y \ c_a^\dagger(x)K^{ab}(x, y)c_b(y) \\\\\
&= \int d^4x \ c_a^\dagger(x) \left[  \partial^\mu f^{abc} A^c_\mu(x) c_b(x) - \partial^2 c_b(x) \right] \\\\\\
&= \int d^4x \ \left[ \partial^\mu c_a^\dagger(x) \partial_\mu c_b(x) - \partial^\mu c^\dagger_a f^{abc} A^c_\mu(x) c_b(x) \right] \\\\\\
&= \int d^4x \ \partial^\mu c_a^\dagger(x) \left[ \partial_\mu c_b(x) - f^{abc} A^c_\mu(x) c_b(x) \right] \\\\\\
&= \int d^4x \ \partial^\mu c_a^\dagger(x) D_\mu c_a(x) \\\\\\
\end{aligned}
$$

Here $D_\mu$ is the covariant derivative of the adjoint representation;  $c_a, c_a^\dagger,$ and $A_\mu^a$ all transform in this way.  

$c_a$ and $c_a^\dagger$ are *ghost fields* and seemingly violate the *spin-statistics* connection, because they are grassmann anti-commuting variables, but they are not physical, just a convenient representation of $\Delta(A)$.  

Zooming out, we now have

$$
Z = \int \mathcal{D}A\mathcal{D}c\mathcal{D}c^\dagger \ e^{iS(A) + iS_{\text{ghost}}(c^\dagger, c)} \ \delta(\partial A - \sigma)
$$

which after integrating over $\sigma$ with a Gaussian weight, $e^{ -(i/2\xi) \int d^4x \sigma^a(x)^2}$, we arrive at a final gauge fixed (with gauge parameter $\xi$) generating functional for a pure non-abelian Yang-Mills theory:

$$
\boxed{
Z(J) = \int \mathcal{D}A\mathcal{D}c\mathcal{D}c^\dagger \ \exp \left\\{iS(A) + iS_{\text{ghost}}(c^\dagger, c) - \frac{i}{2\xi} \int d^4x (\partial^\mu A_\mu)^2 + \int d^4x J^\mu A_\mu\right\\}
}
$$