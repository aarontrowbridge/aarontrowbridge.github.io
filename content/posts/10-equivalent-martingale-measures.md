---
title: "risk neutrality: the equivalent martingale measure"
url: "posts/equivalent-martingale-measures"
date: 2022-03-20
description: "an explanation of the risk-neutral measure, a result of Girsanov's theorem, commonly deployed by \"sell-side\" financial institutions to simplify derivative pricing"
tags: ["mathematical finance", "stochastic processes", "data visualization"]
categories: ["mathematics"] 
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

In the realm of mathematical finance there are two relatively disjoint worlds: the "buy-side" and the "sell-side". Buyers are analyzing the available financial products (e.g. stocks, bonds, derivatives, etc.) and are trying to predict, and profit off of, the future prices of these assets---i.e. they are trying to estimate the *real-world* probability distribution, commonly denoted $P$, of the future stochastic price movements.

On the other side, sellers (aka market-makers) are trying to set a fair price for more illiquid assets, like derivatives, using the prices of more liquid assets, like stocks, which are priced by supply and demand. One particular challenge is that investors all have different risk preferences.  One way to quantify this risk is with the [sharp ratio](https://en.wikipedia.org/wiki/Sharpe_ratio), which measures risk relative to a *numeraire*, like a US treasury security, which has a *risk-free* rate of return $r$. One model for the price of derivative is to use a [stochastic discount factor](https://en.wikipedia.org/wiki/Stochastic_discount_factor) (SDF), also called a pricing kernel, $\tilde M_t$. The price $F$ of a derivative at time $t$, which pays out at future time $T$, is then given by

$$
P_t = \mathbf{E}_{P}\left[M_T P_T\right] = e^{-r(T-t)} \mathbf{E}\_{Q}\left[ P_T \right]
$$

Where in the last step we factored out the risk-free interest and merged the SDF into the probability measure.  This is allowed given the measures are equivalent---written $P \sim Q$---and we assume no arbitrage exists; the *fundamental theorem of asset pricing* encapsulates this.

Pricing derivatives using the risk-neutral measure $Q$ comes with a few advantages over the real world measure $P$. For one, it is often simpler---requires fewer parameters, and we don't need to worry about SDF---to calibrate pricing models; two, as we will see, the underlying asset becomes a *martingale* w.r.t. $Q$; lastly, we don't need to account for investors specific risk preferences.


## the fundamental theorem of asset pricing

## preliminaries

Let's get some definitions out of the way before deriving the main result below.  We will start with the definition of a martingale process, and then define what is required for two probability measures to be called equivalent. 

For the remainder of the article we will work on the probabilty space $(\Omega, \mathcal{F}, \\{\mathcal{F_t}\\}, P)$, where $\Omega$ is the sample space of possible paths, $\mathcal{F}_t$ is the filtration (think available information) of the $\sigma$-algebra $\mathcal{F}$ up to time $t$, and $P$ is the probability measure on the sample space. 

>Note that a sample path, denoted $\omega \in \Omega$, allows us to think of stochastic variables, given a sample path, as deterministic functions of time: $t \mapsto X_t(\omega)$ 

### martingales

Intuitively a martingale process is one which is not biased, i.e. it does not drift. This can be made rigorous by requiring that on a stochastic process $Y_t$ satisfies (using a generalization of conditional expectation)

$$
\mathbf{E}_P[Y_t | \mathcal{F}_s] = Y_s 
$$

for $s < t$. This says that the conditional expectation of the future value, given the present information, will always be equal to the present value. 



### equivalence of measures

A probability measure is not unique on a sample space is not unique; changing measures requires some notion of equivalence. Chiefly, if we want to transform $P \to Q$, we must have

$$
P(H) = 0 \implies Q(H) = 0
$$ 

for all $H \in \mathcal{F}_T$, where we fix $t = T$. We then say $Q$ is *absolutely continuous* w.r.t. $P$ and write $Q \ll P$, which by the [Radon-Nikodym theorem](https://en.wikipedia.org/wiki/Radon%E2%80%93Nikodym_theorem) occurs only if 

$$
dQ(\omega) = Z_T(\omega)dP(\omega)
$$

Here our $Z_T(\omega) = Z_t(\omega) > 0$ a.s., which implies $P\ll Q$, allowing us to assert equivalence and write $P \sim Q$.

### Bayes' theorem for conditional expectation

Here we state a result needed layer that can be proven using basic properties of conditional expectation.

If 


## Girsanov's theorem

Given an [Ito process](https://en.wikipedia.org/wiki/It%C3%B4_calculus#It%C3%B4_processes) $X_t$ on the probability space $(\Omega, \mathcal{F}, \\{\mathcal{F}_t \\}, P)$, described by the stochastic differential equation

$$
dX_t = \mu(t, \omega) dt + \sigma(t,\omega)dW_t
$$

where $\omega \in \Omega$ represents a sample path in the sample space of all possible paths, $\mathcal{F}_t$ is the filtration of the $\sigma$-algebra $\mathcal{F}$ up to time $t$ (not actually important for what are we are doing), and most importantly $W_t$ is a [wiener process](https://en.wikipedia.org/wiki/Wiener_process) (brownian motion) with respect to the measure $P$. 

## the generalized Black-Scholes model