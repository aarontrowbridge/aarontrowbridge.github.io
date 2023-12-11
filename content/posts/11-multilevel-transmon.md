---
title: "multilevel transmon qubits"
url: "posts/multilevel-transmon"
date: 2023-12-10
description: "a walkthrough of applying the rotating wave approximation to a driven multilevel transmon qubit"
tags: ["quantum mechanics", "quantum computing", "quantum control"]
categories: ["physics"] 
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
    image: "images/multilevel-transmon/transmon-circuit.png" # image path/url
    alt: "transmon circuit diagram" # alt text
    caption: "transmon circuit diagram" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
editPost:
    URL: "https://github.com/aarontrowbridge/aarontrowbridge.github.io/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

The *transmon* qubit, first proposed in 2007 by Koch et al. [^1], has become a top contender for realizing large-scale NISQ devices.  This transmon is based on an anharmonic oscillator realized by a Josephson junction shunted by a capacitor. The anharmonicity is important for enabling a stable two-level subsystem where the qubit state will live. 

The circuit diagram (taken from [^1]) is shown below. 

![transmon circuit diagram](/images/multilevel-transmon/transmon-circuit.png)

## the Hamiltonian

Without going into all the details of this circuit (see [^1] for more), the simplified Hamiltonian for this system is given by

$$
\begin{equation}
\hat{H} = 4E_C \hat{n}^2 - E_J \cos (\hat{\varphi}) 
\end{equation}
$$

where $\hat{n}$ is the charge number operator and $\hat{\varphi}$ is the phase operator; $\hat{n} \equiv \partial_{\hat{\varphi}}$ and $\hat{\varphi}$ are canonically conjugate variables. The first term is the charging energy of the capacitor and the second term is the Josephson energy.

For small $\varphi$, we can expand the cosine term to fourth order:

$$
\begin{equation}
\hat{H} = 4E_C \hat{n}^2 - E_J \left( 1 - {\hat{\varphi}^2 \over 2} + {\hat{\varphi}^4 \over 24} \right) 
\end{equation}
$$



Using $\hat{n} = {i \over 2} \sqrt[4]{E_J \over 2E_C}(\hat{a}^\dag - \hat{a})$ and $\hat{\varphi} = {i \over 2} \sqrt[4]{2E_C \over E_J}(\hat{a}^\dag + \hat{a})$, we can rewrite the Hamiltonian (dropping constant terms, see [^2] for details) with the annihilation and creation operators $\hat{a}$ and $\hat{a}^\dag$:

$$
\begin{equation}
\hat{H} = \omega \hat{a}^\dag \hat{a} + {\delta \over 12} \left(\hat{a} + \hat{a}^\dag \right)^4
\end{equation}
$$

where $\omega = \sqrt{8E_J E_C}$ is the resonant frequency of the oscillator and $\delta = -E_C$ is the anharmonicity.

## rotating wave approximation


## 








[^1]: Koch, Jens, et al. "Charge-insensitive qubit design derived from the Cooper pair box." [arXiv:cond-mat/0703002](https://arxiv.org/abs/cond-mat/0703002) (2007).
[^2]: insert ref to thesis here 
 
