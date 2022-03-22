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

In the realm of mathematical finance there are two relatively disjoint worlds: the "buy-side" and the "sell-side". Buyers are analyzing the available financial products (e.g. stocks, bonds, derivatives, etc.) and are trying to predict, and profit off of, the future prices of these assets---i.e. they are trying to estimate the *real-world* probability distribution, commonly denoted $\mathbb{P}$, of the future stochastic price movements.

On the other side, sellers (aka market-makers) are trying to set a fair price for more illiquid assets, like derivatives, using the prices of more liquid assets, like stocks, which are priced by supply and demand. One particular challenge is that investors all have different risk preferences.  One way to quantify this risk is with the [sharp ratio](https://en.wikipedia.org/wiki/Sharpe_ratio), which measures risk relative to a *numeraire*, like a US treasury security, which has a *risk-free* rate of return $r$. One model for the price of derivative is to use a [stochastic discount factor](https://en.wikipedia.org/wiki/Stochastic_discount_factor) (SDF), also called a pricing kernel, $\tilde M_t$. The price $P$ of a derivative at time $t$, which pays out at future time $T$, is then given by

$$
P_t = \mathbf{E}_{\mathbb{P}}\left[M_T P_T\right] = e^{-r(T-t)} \mathbf{E}\_{\mathbb{Q}}\left[ P_T \right]
$$

Where in the last step we factored out the risk-free interest and merged the SDF into the probability measure.  This is allowed given the measures are equivalent---written $\mathbb{P} \sim \mathbb{Q}$---and we assume no arbitrage exists; the *fundamental theorem of asset pricing* encapsulates this.

Pricing derivatives using the risk-neutral measure $\mathbb{Q}$ comes with a few advantages over the real world measure $\mathbb{P}$. For one, it is often simpler---requires fewer parameters, and we don't need to worry about SDF---to calibrate pricing models; two, as we will see, the underlying asset becomes a *martingale* w.r.t. $\mathbb{Q}$; lastly, we don't need to account for investors specific risk preferences.


## the fundamental theorem of asset pricing


## Girsanov's theorem

### equivalence of measures

### martingales

### equivalent martingale measures

## the generalized Black-Scholes model