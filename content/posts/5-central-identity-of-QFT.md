---
title: "the central identity of quantum field theory"
url: "posts/central-identity-of-QFT"
date: 2021-09-10 
description: "a derivation of a generating functional identity used for calculating correlators"
tags: ["quantum field theory", "mathematical methods", "path integrals"]
categories: ["physics", "mathematics"] 
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


Quantum field theory is the study of various types of fields, the interactions between these fields, and the correlation functions describing the dynamics of the entire system.  Fields are really just functions that label each spacetime coordinate with some type of mathematical object. We can talk about spinor fields, scalar fields, and even gauge fields, which can be described by vectors or tensors that transform in certain ways under an associated gauge group.

To describe the properties of fields (which we can bundle up into one big vector $\varphi$) and their interactions, QFT takes advantage of the associated action functional of the fields, 

$$
S[\varphi] = \int d^4x \ \mathcal{L}[\varphi] 
$$

where $\mathcal{L}[\varphi]$ is the *Lagrangian density* of the system, which specifies a "quantum field theory", with its own set of parameters and interactions. Classical field theory can be summarized as finding $\varphi$ s.t. $S[\varphi]$ is at a minimum (more accurately a critical point), which is called the principal of least action. 

You may then be wondering, like I was, what makes a field theory quantum?

> answer: the path integral

Technically, there are two equivalent answers. One is so elegant and useful that it is overwhelmingly preferred to the other (though this dominance is waning), and it is known as the [path integral formalism](https://en.wikipedia.org/wiki/Path_integral_formulation), gifted to the world by the illustrious Dick Feynman (as his friends called him). For the curious, the alternative is known as the [canonical formalism](https://en.wikipedia.org/wiki/Second_quantization), but we will not delve into it here.

<br>

## The Path Integral Formalism


In this formalism, we are given a ground state of our quantum system $\ket\Omega$.  The essence of Feynman's insight is that the *amplitude* (a complex number) for any quantum state to evolve into another state given by the *path* or *functional integral* over every possible evolution of the system.  For the ground state to evolve into the ground state this looks like:

$$
\braket{\Omega \vert \Omega} = \int \mathcal{D}\varphi \ e^{\frac{i}{\hbar}S[\varphi]}.
$$

We sum up the $e^{\frac{i}{\hbar}S[\varphi]}$ for every possible "path" $\varphi(\vec x, t)$. This is the ingredient than when infused into our field theory gives us a quantum view of the world: our fields don't take just one trajectory, they take every trajectory at the same time. It can be shown that this reduces to the classical case in the limit $\hbar \rightarrow 0$, and we will now drop $\hbar$ for brevity.  

The correlators are also amplitudes and look like:

$$
\langle \varphi_1 \dots \varphi_n \rangle := \langle \Omega \vert T\\{\hat\varphi(x_1) \dots \hat\varphi(x_n)\\} \vert \Omega \rangle = \int \mathcal{D}\varphi \ e^{iS[\varphi]} \varphi(x_1) \cdots \varphi(x_n),
$$

which is the "probability" of observing field excitations (particles), created by field operators $\hat\varphi(\vec x_i, t_i)$ ordered by time, so that earlier time operators act before later time operators.  This business of earlier & later times is what the [time ordering operator](https://en.wikipedia.org/wiki/Path-ordering) $T\\{\dots\\}$ has to do with, though I am not going to go into the details of how it works, as it is not essential to the story I am trying to tell.  In fact, here it just works, so we don't even have to worry about it. 

<br>

## The Generating Functional
We can now build the central object of quantum field theory: *the generating functional*

$$
Z[J] = \int \mathcal{D}\varphi \ e^{iS[\varphi] + i \int d^4x J(x) \varphi(x)}.
$$

Here, $J(x)$ is *"the classical source"*, and via [the functional derivative](https://en.wikipedia.org/wiki/Functional_derivative), allows us to define $n$-point amplitudes in terms of $Z(J)$:

$$
\langle \varphi_1 \dots \varphi_n \rangle  =  (-i)^n \frac{1}{Z(0)} \frac{\delta^n Z[J]}{\delta J(x_1)\cdots \delta J(x_n)} \Bigg\vert_{J = 0}
$$

Which can be easily derived using the identity

$$
\frac{\delta J(x)}{\delta J(x_i)} = \delta(x - x_i).
$$

Now let's perform a [wick rotation](https://en.wikipedia.org/wiki/Wick_rotation), brushing the details and justification under the rug like any good physicist would, as well as expand the Lagrangian as the sum of a term quadratic in $\varphi$ and a potential functional $V[\varphi]$ containing everything else.  Also, let's introduce the notation $J \cdot \varphi = \int d^4x J(x) \varphi(x)$, for a vector $J(x)$, where the usual matrix multiplication rules are implied.  The result is:


$$
Z[J] = \int \mathcal{D}\varphi \ e^{-\frac{1}{2} \varphi \cdot A \cdot \varphi - V[\varphi] + J \cdot \varphi}.
$$

<br>

## The Central Identity

As physicists lets abuse our notation even further, expanding $V[\varphi]$ as power series in $\varphi$:

$$
V[\varphi] = \sum_{k \geq 3} \frac{1}{k!}\lambda_k \varphi^k
$$

Here what we mean is that each term $\varphi^k$ is some combination of $k$ field elements and their derivatives (which are all included in our big vector $\varphi$).  The $\lambda_k$s are the coupling constants of these interaction terms. 

This allows us to write, using some slick notation,

$$
\begin{align*}
Z[J] &= \int \mathcal{D}\varphi \ e^{-V[\varphi]} e^{-\frac{1}{2} \varphi \cdot A \cdot \varphi + J \cdot \varphi} \\\\\\
&= e^{-V\left[ \frac{\delta}{\delta J}\right]} \int \mathcal{D}\varphi e^{-\frac{1}{2} \varphi \cdot A \cdot \varphi + J \cdot \varphi}. \\\\\\
\end{align*}
$$

Which, in combination with an generalized identity for multidimensional Gaussian integrals (derived in the next section), gives us, up to normalization, *the central identity of quantum field theory:*

$$
\boxed{Z[J] = e^{-V\left[ \frac{\delta}{\delta J}\right]} e^{\frac{1}{2} J \cdot A^{-1} \cdot J}}
$$

This formula is a very useful for calculating correlators by taking derivatives and doing perturbation theory.  There is a caveat - we can't guarantee that $A$ is invertible. Resolving this issue, when it arises, like in the case of the Maxwell action, takes some extra work, specifically a topic called *gauge fixing*, which will be discussed in a follow-up post.  


<br>

## Gaussian Integrals

Assuming familiarity with the famous one dimensional Gaussian integral, it is relatively straight forward to generalize it to the following form:

$$
I = \int_{-\infty}^\infty \ dx e^{-\frac{1}{2}ax^2 + Jx} = \left( \frac{2\pi}{a}\right)^{\frac{1}{2}}e^{J^2 / 2a}.
$$

Which is a result of "completing the square": 

$$
-\frac{1}{2}ax^2 + Jx = -\frac{a}{2}\left(x^2 - \frac{2Jx}{a}\right) = -\frac{a}{2}\left(x - \frac{J}{a}\right)^2 + \frac{J^2}{2a}.
$$  

Changing variables by taking $x \rightarrow x - J/a$ does not change the measure $dx$ and allows the integral to be done as usual, giving the result above. 

Now let's consider the integral 

$$
I' = \int_{-\infty}^\infty \prod_{j=1}^N dx_j \ e^{-\frac{1}{2} x \cdot A \cdot x + J \cdot x},
$$

with $A$ being a real symmetric $N\times N$ matrix, and $x, J$ as $N$-dimensional vectors. 

The trick to this multidimensional version of our original integral, $I'$ is to convert it into a product of the original integral $I$. We can do this by diagonalizing $A = O^{-1} D O$, with an orthogonal transformation $O$, and a diagonal matrix $D$. We can then let $y_i = \sum_j O_{ij} x_j$; the measure is invariant under this relabeling and the multidimensional integral breaks up into a product of "normal" integrals like so:

$$
\begin{align*}
I' &= \int\_{-\infty}^\infty \prod\_{j=1}^N dx_j \ e^{-\frac{1}{2} x \cdot O^{-1} D O \cdot x + J \cdot x } \\\\\\
&= \prod_{j=1}^N\int\_{-\infty}^\infty dy_j \ \exp \left\\{-\frac{1}{2} D\_{jj} \  y_j^2 + (OJ)_j \ y_j \right\\} \\\\\\
&= \prod\_{j=1}^N \ \left( \frac{2\pi}{D\_{jj}}\right)^{\frac{1}{2}} \exp \left\\{-\frac{1}{2}\left(\sum_k O\_{jk} J_k \right)^2 \ D^{-1}\_{jj} \right\\}  \\\\\\
&= \left( \frac{(2\pi)^N}{\prod_j D\_{jj}}\right)^{\frac{1}{2}} \exp \left\\{-\frac{1}{2}\sum\_{j,k,l} J_l O\_{jl} D^{-1}\_{jj} O\_{jk} J_k \right\\}  \\\\\\
&= \left( \frac{(2\pi)^N}{\det A}\right)^{\frac{1}{2}} e^{-\frac{1}{2} J \cdot O^{-1} D^{-1} O \cdot J }  \\\\\\
&= \left( \frac{(2\pi)^N}{\det A}\right)^{\frac{1}{2}} e^{-\frac{1}{2} J \cdot A^{-1} \cdot J}  \\\\\\
\end{align*}
$$

This is what we wanted, phew! Now, if you made it this far you are either regretting it or wondering how this applies to the continuous fields and operators in our original path integral - the answer is that the definition of the path integral measure looks like

$$ 
\int \mathcal{D}\varphi = \lim_{N \rightarrow \infty} \mathcal{N}  \int_{-\infty}^\infty \prod_{j=1}^N d\varphi_j.
$$

Here $\mathcal{N}$ is a complicated normalization constant and $\varphi_j = \varphi(x_j)$ discretises the field so that in the limit $N \rightarrow \infty$ we go towards the continuum.  Going back and forth from the lattice (discretised space) to the continuum is an essential skill for field theorists. A big open problem in physics is quantum gravity; one approach (see my earlier post on [lattice quantum gravity](https://aarontrowbridge.github.io/blog/2021/the-freeman-method/), seeks to find a way to take the continuum limit of a discretised version of the Einstein-Hilbert action, a task that is not trivial. 