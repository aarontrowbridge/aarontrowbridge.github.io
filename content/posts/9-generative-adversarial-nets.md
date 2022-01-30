---
title: "generative adversarial networks"
url: "posts/generative-adversarial-nets"
date: 2022-01-26T10:17:17-05:00 
description: "a look at the theory behind the GAN model and an implementation in Julia using Flux.jl"
tags: ["machine learning", "julia", "optimization"]
categories: ["computer science", "mathematics"] 
draft: true 
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

In 2014, Ian Goodfellow, then at OpenAI, published his seminal paper, titled "Generative Adversarial Networks"[^1], detailing how competition between *generator* and *discriminator* functions, approximated by neural networks, can train the generator to produce realistic images.
 
In this article I will be discussing the theory behind this idea, my own implementation in Julia (mirroring the network structure in Goodfellow's original paper), and show some of the images I was able to get out.
 
## theory
 
To begin with let's model our generator as a parameterized function $G(z; \theta)$ that outputs images that are the same size as the data; this function is over a lower dimensional latent space, which we assign a prior distribution $p_z(z)$. 
 
We will also model the discriminator as a parametrized function $D(x; \omega)$ which takes in an image $x$ and outputs a single scalar interpreted as the probability of $x$ being in the training data set.  
 
In practice, $D$ and $G$ are usually both implemented as neural networks, either fully connected multi-layer perceptrons (MLPs) or convolutional and "deconvolutional".  
 
> **Deconvolutional layers**, also called convolutional transpose layers, "upsample" from a lower dimensional space to a higher dimensional space, and while the term is sometimes used, it implies an inverse to a convolutional layer, which it is not. The alternative name (convolutional transpose) is more apt and more frequently used lately -- at least [Flux.jl](https://fluxml.ai/Flux.jl/stable/models/layers/#Flux.ConvTranspose) implements a  `ConvTranspose` layer. 
 
###  the *minimax* problem 
 
At a high level, in training these networks, we want $D$ to accurately tell a real image from a fake image and we want $G$ to trick $D$ into believing the generated images are real.  This results in the *minimax* optimization problem:
 
$$
\begin{equation}
\min_G \max_D \ \mathbb{E}\_{x \sim p_{data}(x)}\left[\log D(x)\right] + \mathbb{E}\_{z \sim p_z(z)} \left[ \log\left(1 - D(G(z)) \right)\right]
\end{equation}
$$
 
Here, $1 - D(G(z))$ is the probability that a generated image is fake, which we want to minimize w.r.t. $G$, while simultaneously maximizing $D$'s ability to tell real from fake.
 
Using the value function in (1), denoted $V(G, D)$, we can iteratively update $G$ and $D$, in turn, using minibatch stochastic gradient descent; see Algorithm 1 in [Goodfellow et al.] for details.


### global optimality

Ultimately, we want the distribution of generated images to match the data distribution, i.e., $p_g = p_{\text{data}}$.

For any fixed (suboptimal) generator $G$ we want to find $D^\*_G(x)$ which maximizes $V$:

$$
\begin{align}
V(G, D) &= \int_x p_{\text{data}}(x) \log(D(x)) \ \mathrm{d}x + \int_z p_{z}(z) \log(1 - D(G(z))) \ \mathrm{d}z \nonumber \\\\\\
&= \int_x p_{\text{data}}(x) \log(D(x)) + p_{g}(x) \log(1 - D(x)) \ \mathrm{d}x 
\end{align}
$$

The integrand of (2), which has the form $y \to a \log y + b \log(1 - y)$ with $(a, b) \in \mathbb{R}^2 \backslash \\{0,0\\}$ with a maximum in $[0,1]$ at $a \over a+b$. So we then have

$$
\begin{equation}
D^\*_G(x) = \frac{p\_{\text{data}}(x)}{p\_{\text{data}}(x) + p_g(x)} 
\end{equation}
$$

Now, looking back at (1) we can see that we need to minimize 

$$
\begin{align}
C(G) &= \max_D V(G, D) = V(G, D^\*_G) \nonumber \\\\\\
&= \mathbb{E}\_{x \sim p\_{\text{data}}}[\log D^\*_G(x)] + \mathbb{E}\_{z \sim p_z}[\log(1 - D^\*_G(G(z))] \nonumber \\\\\\
&= \mathbb{E}\_{x \sim p\_{\text{data}}}[\log D^\*_G(x)] + \mathbb{E}\_{x \sim p_g}[\log(1 - D^\*_G(x))] \nonumber \\\\\\
&= \mathbb{E}\_{x \sim p\_{\text{data}}}\left[\log \frac{p\_{\text{data}}(x)}{p\_{\text{data}}(x) + p_g(x)} \right] + \mathbb{E}\_{x \sim p_g}\left[\log \frac{p_g(x)}{p\_{\text{data}}(x) + p_g(x)} \right] 
\end{align}
$$

With equation (3) we can clearly see that $D^\*_G(x) = {1 \over 2}$ when $p_g = p\_{\text{data}}$, which implies that at its absolute minimum 

$$
C(G^\*) = \mathbb{E}\_{x \sim p\_{\text{data}}}[-\log 2] + \mathbb{E}\_{x \sim p_g}[-\log 2] = -\log 4.
$$ 


>We now note that the [Kullback-Leibler divergence](https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence) is defined as 
>
>$$
>\begin{align*}
>D_{KL}(p \ \Vert \ q) &\equiv \int_x p(x) \log {p(x) \over q(x)} \ \mathrm{d}x \\\\\\
>&= \mathbb{E}\_{x \sim p(x)} \left[ \log {p(x) \over q(x)} \right]
>\end{align*}
>$$
>
>and the [Jenson-Shannon divergence](https://en.wikipedia.org/wiki/Jensen%E2%80%93Shannon_divergence), is defined as 
>
>$$
>\begin{align*}
>D_{JS}(p \ \Vert \ q) &\equiv {1 \over 2}D_{KL}\left(p \ \Bigg\Vert \ {p + q \over 2} \right) + {1 \over 2}D_{KL}\left(q \ \Bigg\Vert \ {p + q \over 2} \right) \\\\\\
>&= {1 \over 2} \mathbb{E}\_{x \sim p(x)} \left[ \log {2 \ p(x) \over p(x) + q(x)} \right] + {1 \over 2} \mathbb{E}\_{x \sim q(x)} \left[ \log {2 \ q(x) \over p(x) + q(x)} \right] \\\\\\
>&= {1 \over 2} \left( \mathbb{E}\_{x \sim p(x)} \left[ \log {p(x) \over p(x) + q(x)} \right] + \mathbb{E}\_{x \sim q(x)} \left[ \log {q(x) \over p(x) + q(x)} \right] + \log 4 \right)
>\end{align*}
>$$

Thus, using (4), the cost function for the generator $G$, for optimal $D^\*_G$, can be written as

$$
\begin{equation}
C(G) = -\log 4 + 2 \cdot D\_{JS}(p\_{\text{data}} \ \Vert \ p_g). 
\end{equation}
$$



## experiments

An implementation of the "simple" GAN model described here (plus some more advanced models that aren't yet implemented at the time of writing this) can be found on github at [FluxGAN.jl](https://github.com/aarontrowbridge/FluxGAN.jl).  The package runs on the gpu (if available) and can be easily installed and used.

### training

Visualizing the training of a GAN can be tricky; I found it helpful to make the following gif which shows the generator's output for specific points in the latent space during the training process. 

![alt](/images/GANs/mlp_n_15000_grid_5_5.gif#center)

The following are randomly sampled outputs from generators trained with different architectures on different data sets:

### MNIST

**fully connected network** ([code](https://github.com/aarontrowbridge/FluxGAN.jl/blob/main/scripts/mnist_goodfellow.jl)) 

![](/images/GANs/MLP_n_50000_m_100_grid_5_5.png)

### CIFAR-10

**convolutional network** ([code](https://github.com/aarontrowbridge/FluxGAN.jl/blob/main/scripts/cifar10_conv_goodfellow.jl))

![](/images/GANs/animals_conv_n_25000_m_50_grid_5_5.png)

**fully connected network** ([code](https://github.com/aarontrowbridge/FluxGAN.jl/blob/main/scripts/cifar10_mlp_goodfellow.jl)) 

![](/images/GANs/animals_mlp_n_25000_m_50_grid_5_5.png)

###

[^1]: Goodfellow et al. (2014) "Generative Adversarial Networks" [arXiv:1406.2661](https://arxiv.org/pdf/1406.2661.pdf)