---
layout: post
title:  the Freeman algorithm
date:   2021-06-09 
description: an accelerated approach to the Metropolis algorithm for lattice quantum gravity
---

### Intro 

Just about a year ago today, I began working on implementing an algorithm my undergrad research advisor had devised to speed up [the Metropolis algorithm](https://en.wikipedia.org/wiki/Metropolis-Hastings_algorithm), in the regime where the acceptance probability is very low, which is the case in lattice simulations of quantum gravity. 

### Quantum Gravity

Physics has experienced its most rapid advancement when theories are unified:

- electromagnetism $$\leftarrow$$ electricy + magnetism + light
- general relativity $$\leftarrow$$ special relativity + curved spacetime (gravity)
- quantum field theory $$\leftarrow$$ quantum mechanics + special relativity + electromagnetism + matter + nuclear forces

And hopefully soon...

- quantum gravity $$\leftarrow$$ quantum field theory + general relativity

It turns out the problem is pretty simple... to state. We just need to solve the following path integral:

$$
Z = \int \mathcal{D}[g] \exp \left(\frac{1}{16\pi G}\int d^4 x \sqrt{-g}(R - 2\Lambda) \right) 
$$

Ignoring for a moment the subtleties of evaluating a path integral in general, in this case it turns out that the term inside of the exponential, [the Einstein-Hilbert action](https://en.wikipedia.org/wiki/Einstein-Hilbert_action), causes some serious problems. $$Z$$ is perturbatively non-renormalizable, which is technical jargon that means the theory spits out infinities when we try to calculate simple interactions and those infinities only get worse when we attempt to "cancel them off", which is a prescription that miraculously works in other (renormalizable) theories, like quantum electrodynamics.  

Hope remains though... while a perturbative expansion of $$Z$$ blows up, an idea known as [asymptotic safety](https://en.wikipedia.org/wiki/Asymptotic_safety_in_quantum_gravity) might save the day. This is what the group I became a part of is working on.  More specifically we are using a computational technique called dynamical triangulation to calculate a discretized version of $$Z$$ on a lattice of 4-dimensional simplices.

### The Freeman Algorithm 

The beauty of science is that every solution only leads to more problems... our new problem is that the algorithm we want to use to evolve our simplex lattice is inherently slow, or more accurately picky: it chooses to do nothing about 9,999 times out of every 10,000 times we ask it do something. Which is annoying!

The new algorithm basically goes as follows:

1. think about every possible thing we could do and assign a number (probability) to each possibility
2. imagine every possibility as a book on a shelf, with the width of the book corresponding to the probability of picking it
3. blindly approach the book shelf and choose a book

This way, each time we want to do something, we actually do something.  Which is great!

There are some more subtleties and technical points - if interested, details can be found in the [slides](/assets/pdf/quantum_gravity_pres.pdf) of a presentation I made about this research.  If *very* interested, you can also watch a recording of the presentation:

<br>

<p align="center">
   <a href="http://www.youtube.com/watch?feature=player_embedded&v=_Ppx0e3aG-E" target="_blank">
      <img src="http://img.youtube.com/vi/_Ppx0e3aG-E/maxresdefault.jpg" 
      alt="IMAGE ALT TEXT HERE" width="90%">
   </a>
</p>
