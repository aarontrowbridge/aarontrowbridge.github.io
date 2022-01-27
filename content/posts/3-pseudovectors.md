---
title: "pseudovectors"
url: "posts/pseudovectors"
date: 2021-06-13T10:17:17-05:00 
description: "a look a the properties of pseudovectors"
tags: ["linear algebra", "tensors", "group theory", "analytical mechanics"]
categories: ["mathematics", "physics"] 
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
    alt: "<alt>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
editPost:
    URL: "https://github.com/aarontrowbridge/aarontrowbridge.github.io/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---


***Pseudovectors***, or ***axial vectors*** as they are sometimes referred to as, are commonly encountered, but mysterious mathematical objects.  In physics they arise in many different areas, particularly when cross products are involved - e.g., magnetic fields, angular momentum, and torque.  

The goal of this post is to address two seemingly different definitions of a pseudovector, in 3 dimensions, and in the process unravel this mystery.    

> **Definition 1** A pseudovector is a tensor on $\mathbb{R}^3$ that transforms like a vector under proper rotations, but picks up a sign under an improper rotation, like a reflection.

> **Definition 2** A pseudovector is a tensor on $\mathbb{R}^3$ that transforms like a vector under proper rotations, and is invariant under inversion, a tranformation also known as parity. 

<br>

## Background

Before jumping into some calculations I will briefly go over some of the aforementioned terminology.

### **Tensors**

I could opt to take the easy way out and use ***the physicist's definition*** of a tensor: *a tensor is a quantity that transforms like a tensor*, and leave it at that.

But, I can't help introducing some notation, and define $T$ to be a ***(real) tensor of type*** $(r, s)$, on an $n$-dimensional  vector space $V$ over $\mathbb{R}$ to be the *multilinear* map

$$
T : \underbrace{V \times \cdots \times V}\_{r \text{ times}} \ \times \underbrace{V^* \times \cdots \times V^*}\_{s \text{ times}} \rightarrow \mathbb{R}
$$

where $V^*$ is the dual vector space to $V$, i.e., the space of linear maps from $V \rightarrow \mathbb{R}$. We will refer to the space of all such tensors to be $\mathcal{T}^r_s(V) = \mathcal{T}^r_s$, when the underlying vector space is understood. It should also be noted that all of these definitions apply to complex vector spaces.

Given a basis $\{e_i\}_{i=1\dots n}$ for $V$, and corresponding dual basis $\{e^i\}$ for $V^*$, satisfying $e^j(e_i) = \delta^j_i$, we can look at the components of a tensor $T \in \mathcal{T}^r_s$,

$$
T_{i_1 \dots i_r}^{\ \ \ \ \ \ \ \ \ j_1 \dots j_s} = T(e_{i_1}, \dots, e_{i_r}, e^{j_1}, \dots, e^{j_s})
$$

While the convention here of putting indices on indices might seem confusing, it is quite elegant once gotten used to.  For arbitrary rank tensors we quickly run out of conventional indices, $i, j, k, l, \dots$, and introducing subscripts on indices is very nice.  Of course, for most tensors we only need a few indicesm, so we will use more conventional notation, for example a tensor $T \in \mathcal{T}^1_1$ has components we can label as

$$
T_i^{\ j} = T(e_i, e^j)
$$

which rightfully resembles the matrix elements of a linear operator. There are some subtle differences that going into will, unfortunately, take us to far astray.  I will postpone a detailed look at matrix representations of linear operators to another blog post.  

### **Transformations**

*In what follows, the [Einstein summation convention](https://en.wikipedia.org/wiki/Einstein_notation), where like indices are implicitly summed over, will be used.*

In some sense the most important aspect of vectors, tensors, pseudovectors, or any other such object you can come up with, is how it changes when we change basis.  This is the essence of the physicist's definition.  For example, we know our basis vectors transform covariantly:

$$
e_i \rightarrow e_{i'} = A^j_{i'}e_j
$$

and the dual basis vectors transform contravariantly:

$$
e^i \rightarrow e^{i'} = A_j^{i'}e^j
$$

Then, our $(1, 1)$-tensor $T$'s components transform like

$$
\begin{align*}
T_i^j \rightarrow T_{i'}^{j'} &= T(e_{i'}, e^{j'}) \\\\\\
&= T(A^k_{i'}e_k, A_l^{j'}e^l) \\\\\\
&= A^k_{i'} A_l^{j'} T(e_k, e^l) \\\\\\
&= A^k_{i'} A_l^{j'} T_k^l \\\\\\ 
\end{align*}
$$

This procedure generalizes to tensors of arbitrary order, which is what it means for a quantity to transform like a tensor!  

Now, for a vector $v \in V$, we can represent the vector in a basis as $v = v^j e_j$, a linear combination of the basis vectors, $e_i$, and the components, $v^i$, of the vector in that basis. Then under a basis transformation the components of our vector will transform, but the vector itself has to remain the same because it is independent of our basis choice, i.e., $v = v'$

$$
\begin{align*}
v \rightarrow v' &= v^{i'}e_{i'} \\\\\\
&= v^{i'}A_{i'}^j e_j \\\\\\ 
&\Rightarrow v^j = v^{i'}A_{i'}^j \\\\\\ 
\end{align*}
$$

and after commuting terms (which is perfectly fine in index notation) and relabeling indices, gives us the familiar transformation rules for vector components:

$$
v^{i'} = A^{i'}_j v^j
$$

Which is what it means for a quantity to transform as a vector.

### **Rotations and Reflections**

An immediate consequence of the vector transformation rules is that

$$
\begin{align*}
v^j &= A_{i'}^j v^{i'} \\\\\\
&= A_{i'}^j \left(A^{i'}_k v^k \right) \\\\\\
&= A^{i'}\_k A\_{i'}^j v^k \\\\\\
&\Rightarrow A^{i'}\_k A\_{i'}^j = \delta^j_k \\\\\\
\end{align*}
$$

which, in matrix notation, reads $A A^T = I \Rightarrow A^{-1} = A^T$.  

This condition defines the group of rotations and reflections in 3 dimensions: the orthogonal group $O(3)$.  Where for $R \in O(3)$ we can show that $\det R = \pm 1$ like so:

$$
\begin{align*}
1 &= (\det R) (\det R)^{-1} \\\\\\
&= (\det R) (\det R^{-1}) \\\\\\
&= (\det R) (\det R^T) \\\\\\
&= (\det R)^2 \\\\\\
&\Rightarrow \det R = \pm 1 \\\\\\
\end{align*}
$$

Where I used the fact that $\det A^T = \det A$ without proof.

Now thinking about these two cases, we can recognize the set of $3\times 3$ matrices $\\{ R \in O(3) \ \vert \ \det R = 1 \\}$ as the group of *proper* rotations, which is also called the ***special orthogonal group***, $SO(3)$.  That leaves us with just the set of *improper* rotations, whose members I will refer to as $\hat R$ and can be written as $\hat R = (-I)R$, where $R \in SO(3)$.  

The improper rotation $-I$ is what was previously referred to as ***inversion***, or ***parity***.  All other improper rotations can be thought of as rotations followed by reflections in the plane perpendicular to the axis of rotation.   

<br>

## Pseudovectors

We can finally get to the topic at hand! The extra work we put in will now aid us as we look at pseudovectors from couple different angles and hopefully mitigate some of the confusion, which I realize might have only built up since we began.

### **Cross Products and the Levi-Civita Tensor**

The cross product is a very special operation in physics and mathematics, as it arises all over the place in various physical theories and is mathematically unique to 3-dimensions, and is in fact a pseudovector as we will see.  Traditionally, given 2 vectors, $\mathbf{a}, \mathbf{b} \in \mathbb{R}^3$, we can can take their cross product

$$
\mathbf{a} \times \mathbf{b} = \| \mathbf{a} \| \| \mathbf{b} \| \sin \theta \ \hat{\mathbf{n}} = a b \sin \theta \ \hat{\mathbf{n}},
$$

where $\theta$ is the angle between $\mathbf{a}$ and $\mathbf{b}$, and $\hat{\mathbf{n}}$ is the unit vector *normal* to the surface spanned by $\mathbf{a}$ and $\mathbf{b}$ and oriented by the *right hand rule*.  

We can also use index notation to write the components of a vector, $v = a \times b$, as

$$
v^i = \underbrace{\sum_{j, k} \epsilon^i_{\ \ jk}a^j b ^k}\_{\text{summing explicitly}} = \epsilon^i_{\ \ jk}a^j b^k
$$

Here we have introduced the ***Levi-Civita symbol***, $\epsilon_{ijk}$, which is totally *antisymmetric* and is related to the ***Levi-Civita tensor*** on $\mathbb{R}^3$, defined by 

$$
\epsilon(u, v, w) \equiv (u \times v) \cdot w, \quad u, v, w \in \mathbb{R}^3.
$$

This definition may appear familiar - it is the formula for the *oriented* volume of a parallelepiped, formed by 3 vectors in $\mathbb{R}^3$.  With this definition in hand, as well as an orthonormal basis $\{ e_i \}$ we can now define the Levi-Civita symbol,

$$
\epsilon_{ijk} \equiv \epsilon(e_i, e_j, e_k) = \left\\{ \begin{array}{cl} +1 & \text{if } (i, j, k) \text{ is a cyclic permutation of } (1, 2, 3)\\\\\\
-1 & \text{if } (i, j, k) \text{ is an anticyclic permutation of } (1, 2, 3) \\\\\\
0 & \text{otherwise} \end{array} \right.
$$

> **Index Conventions** Up until now, we have been rigorously keeping track of upstairs and downstairs indices, which has encoded information about wether a quantity transforms covariantly or contravariantly.  Using this convention, we can raise and lower indices using the euclidean metric, $\delta_{ij} = \delta_i^j = \delta^{ij}$, e.g., $T^{ij} = \delta^{jk} T^i_{\ \ k}$ or $\ T^i_{\ \ j} = \delta_{jk} T^{ik}$.  Because we are living in euclidean space and have the euclidean metric we can relax our index convention, and freely raise and lower indices of objects like $\epsilon_{ijk}$ when convenient. This is justified since, for instance, 
>
>$$
>\epsilon_{ijk} = \delta_{il} \epsilon^l_{\ \ jk} = \delta^i_l \epsilon^l_{\ \ jk} = \epsilon^i_{\ \ jk}.
>$$
>
>So, even though I haven't yet explicitly forbidden it, we will now implicitly sum over any like indices, not just those that appear pairwise upstairs and downstairs.

### **Determinants and Pseudovector Transformations**


With the knowledge we have built up, and a little mathematical sorcery, which I will elucidate in a later post, we can now *define* the determinant of an $n \times n$ matrix $A$:

$$
\vert A \vert \equiv \det A = \epsilon(A_1, \dots, A_n) = \sum_{i_1,\dots,i_n} \epsilon_{i_1,\dots,i_n} A^{i_1}_1 \dots A^{i_n}_n
$$

where $A_i$ is the $i$-th column of $A$. Which implies, with a little bit of extra work, and particularly in the 3-dimensional case, that

$$
\epsilon_{ijk} A^{i}_l A^{j}_m A^{k}_n = \vert A \vert \epsilon\_{lmn}
$$


Let's now see how the components of our pseudovector, $v^i = \epsilon^i_{\ \ j k}a^j b^k$, transform, when we take $e_i \rightarrow e_{i'} = A^j_{i'}e_j$.  Plugging in, we see that

$$
\begin{align*}
v^i \rightarrow v^{i'} &= \epsilon^{i'}_{\ \ j'k'}A^{j'}_l a^l A^{k'}_m b^m \\\\\\
&= \delta^{i'p'} \epsilon\_{p'j'k'} A^{j'}_l A^{k'}_m a^l b^m \\\\\\
&= \epsilon\_{p'j'k'} A^{i'}\_{q} A^{p'}\_{q} A^{j'}_l A^{k'}_m a^l b^m \\\\\\
&= \vert A \vert A^{i'}\_{q} \epsilon\_{qlm} a^l b^m \\\\\\
&= \vert A \vert A^{i'}_j v^j \\\\\\
\end{align*}
$$


Thus, we arrive at the resolution to the original dilemma - the two definitions are equivalent:

>**Under Inversion** (i.e., $A = -I$), 
>
>$$
>v \rightarrow v' = \det(-I) (-I)v = v,
>$$ 
>
>which is exactly what it means for a pseudovector to be invariant under inversion.  

>**Under a General Improper Rotation** (i.e., $A = (-I)R$), 
>
>$$
>v \rightarrow v' = \det\big((-I) R\big) A v = \det(-I) \det(R) A v = - A v, 
>$$ 
>
>which is what it means for a pseudovector to pick up a minus sign. 

Note that in even dimensions, $\det(-I) = 1$, which is why we needed to restrict ourselves to $\mathbb{R}^3$.

If you made it this far, thank you! Stay tuned for a follow up article on bivectors, applications, and generalizations (e.g., pseudoscalars and pseudotensors). 