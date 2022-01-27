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

In 2014 Ian Goodfellow, then at OpenAI, published his seminal paper, titled "Generative Adversarial Networks", detailing how competition between *generator* and *discriminator* functions, approximated by neural networks, can train the generator to produce realistic images.
 
In this article I will be discussing the theory behind this idea, my own implementation in Julia (mirroring the network structure in Goodfellow's original paper), and show some of the images I was able to get out.
 
## theory
 
To begin with let's model our generator as a parameterized function $G(z; \theta)$ that outputs images that are the same size as the data; this function is over a lower dimensional latent space, which we assign a prior distribution $p_z(z)$. 
 
We will also model the discriminator as a parametrized function $D(x; \omega)$ which takes in an image $x$ and outputs a single scalar interpreted as the probability of $x$ being in the training data set.  
 
In practice, $D$ and $G$ are usually both implemented as neural networks, either fully connected multi-layer perceptrons (MLPs) or convolutional and "deconvolutional".  
 
> **Deconvolutional layers**, also called convolutional transpose layers, "upsample" from a lower dimensional space to a higher dimensional space, and while the term is sometimes used, it implies an inverse to a convolutional layer, which it is not. The alternative name (convolutional transpose) is more apt and more frequently used lately -- at least Flux.jl implements a [`ConvTranspose`](https://fluxml.ai/Flux.jl/stable/models/layers/#Flux.ConvTranspose) layer. 
 
### training
 
At a high level, in training these networks, we want $D$ to accurately tell a real image from a fake image and we want $G$ to trick $D$ into believing the generated images are real.  This results in the *minimax* optimization problem:
 
$$
\min_G \max_D \ \mathbb{E}\_{x \sim p_{data}(x)}\left[\log D(x)\right] + \mathbb{E}\_{z \sim p_z(z)} \left[ \log\left(1 - D(G(z)) \right)\right]
$$
 
Here, $1 - D(G(z))$ is the probability that a generated image is fake, which we want to minimize w.r.t. $G$, while simultaneously maximizing $D$'s ability to tell real from fake.
 
Thus we can iteratively update $G$ and $D$ by gradient descent in turn.  
 
 
## implementation

### MNIST


### CIFAR-10

 
## results
