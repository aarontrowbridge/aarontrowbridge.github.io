---
layout: post
title: the Heston stochastic volatility model  
description: experimentation and calibration of a model describing the behavior of the asset underlying a financial derivative
tags: mathematical-finance stochastic-processes numerical-methods optimization
---


The development of mathematical finance, much like the processes it aims to study, has had a particularly jumpy history.  A major leap came in 1973, when the [Black-Scholes option pricing model](https://en.wikipedia.org/wiki/Black-Scholes_model) was published and mathematically understood. The essential idea is to model the underlying asset $$S_t$$ of an option as a geometric brownian motion, with a stochastic differential equation (SDE), given by

$$
dS_t = \mu S_t \ dt + \sigma S_t \ dW_t
$$

containing a drift parameter $$\mu$$ and a *constant* variance (really the square root of the variance) parameter $$\sigma$$. Taking the price of an option at time $$t$$ to be a function $$C(S,t)$$, [Ito's lemma](https://en.wikipedia.org/wiki/It%C3%B4%27s_lemma) applies and the famous Black-Scholes formula can be derived.

Possibly the most momentous year, 1993, saw legislation cancelling the [Superconducting Super Collider](https://en.wikipedia.org/wiki/Superconducting_Super_Collider#Cancellation), which was signed by then President Bill Clinton, in favor of the space shuttle program. Suddenly an entire generation of physicists saw their prospective careers evaporate and a new career path materialize into the financial industry.  Accompanied by mathematicians, statisticians and computer scientists, this lost generation of scientists rewrote the rules of Wall Street and forever changed the financial markets.  

1993 also saw the publication of one of the first solved stochastic volatility models by Steven Heston, which aims to correct the shortcomings of the Black-Scholes model and is what will be studied here.  

<br>

## The Heston Model

This model is essentially the same as the Black-Scholes model, except that on top of modelling the underlying asset $$S$$ as a stochastic process, the variance parameter is also modelled as a stochastic process. In terms of SDEs

$$
\begin{align}
dS_t &= \mu S_t \ dt + \sqrt{v_t} S_t \ dW_t^{(1)}, \nonumber \\
dv_t &= \kappa(\bar{v} - v_t) \ dt + \sigma \sqrt{v_t} \ dW_t^{(2)}, \nonumber
\end{align}
$$

with

$$
dW_t^{(1)}dW_t^{(2)} = \rho dt
$$


<br>

## Pricing Derivatives

#### **The Risk-Neutral Measure**

#### **Numerical Integration Scheme**

<br>

## Calibrating The Model

#### **Analytic Gradient**

#### **The Levenberg-Marquardt Method**

<br>

## Implementation and Results

