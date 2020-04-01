---
layout: post
mathjax: true
title: "Hsieh model" 
date:   2020-04-01
---

### Hsieh Model to missalocation in labor market


#### Introduction

The utility of the individual is given by:


\begin{equation}\label{eq1}
U(c, s) = c^\beta(1 - s)
\end{equation}


Where:

$$c \rightarrow$$ consumption   \\
$$s \rightarrow$$ time spent at school   \\
$$\beta \rightarrow$$ trade between consumption and accumulation of human capital  

People working in a region $$r$$ and occupation $$i$$ is paid a net wage of $$(1 - \tau_{ir}^w)w_{ir}$$. 


$$w_{ir}\rightarrow$$ the net wage per efficiency unit of labor    \\
$$\tau_{ir}^w \rightarrow$$ is a distortion specific for occupation $$i$$ and location $$r$$  


Human capital choices are also distorted due to tax on educational goods.

$$\tau_{ir}^h \rightarrow$$ tax paid by a person that invest in education  

The formation of human capital of a worker in a region $$r$$ is given by:

\begin{equation}\label{eq2}
h_r(e,s) = H_{tr}^\varphi s^\phi e^\eta
\end{equation}

$$e \rightarrow$$ consumption of educational goods   \
$$s \rightarrow$$ time spent in school               \
$$H_{tr} \rightarrow$$ aggregate human capital of teachers        \
$$\phi_i \rightarrow$$ elasticity of human capital with respect to time in school     \
$$\eta \rightarrow$$ elasticity of education goods in the human capital function      \
$$\varphi \rightarrow$$ elasticity of teacher human capital in the human capital function


Abilities dispersion is modeled as multivariated Fréchet distribution. Let $$\epsilon$$ the abilities dispersion in modeled as a multivariate Fréchet distribution. So, we have:

\begin{equation}\label{eq3}
F(\epsilon_1, ..., \epsilon_N) = exp\left[-\left( \sum_{i=1}^N \epsilon_i^{-\frac{\bar{\mathbb{\theta}}}{1-\rho}} \right)^{1-\rho}  \right]
\end{equation}

$$\bar{\mathbb{\theta}} \rightarrow$$ skill dispersion    \
$$\rho \rightarrow \rho \in [0, 1]$$ gives the correlation of individual skills 

let $$\theta = \frac{\bar{\mathbb{\theta}}}{1-\rho}$$. \\

The representative firm has the following production function:
\begin{equation}\label{eq4}
Y = \sum_{r=1}^R\sum_{i=1}^N A_r H_{ir}
\end{equation}


$$Y \rightarrow$$ output    \
$$A_r \rightarrow$$ total factor productivity




#### Firm's problem

The firm's problem can be written as:

\begin{equation}\label{eq5}
\mathop{\text{Max}}_{H_{ir}}\quad \sum_{r=1}^R\sum_{i=1}^N A_r H_{ir} - \sum_{r=1}^R\sum_{i=1}^N w_{ir}H_{ir}
\end{equation}
CPO:\
\begin{equation*}
\frac{\partial\Pi}{\partial H_{ir}} =  \sum_{r=1}^R\sum_{i=1}^N A_r - \sum_{r=1}^R\sum_{i=1}^N w_{ir}  = 0
\end{equation*}

\begin{equation}\label{eq6}
\sum_{r=1}^R\sum_{i=1}^N A_r = \sum_{r=1}^R\sum_{i=1}^N w_{ir}
\end{equation}

If the condition in equation 6 is satisfied, so $$H_{ir}^d = x \in \mathbb{R_+}$$. If $$A_r < w_{ir}$$ the profit function will be negative, so $$H_{ir}^d = 0$$. If $$A_{r} > w_{ir}$$, $$H_{ir}^d = \infty$$, because the profit function is linear in $$H_{ir}$$, so, the firms will produce infinitely.




```python
5+5 
```


```python

```

