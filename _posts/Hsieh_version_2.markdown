---
layout: post
mathjax: true
title: "Misallocation in brasilian labor market" 
date:   2020-07-22
---

In this presentation we employ the modified Hsieh's model to verify if there are misallocation in brasilian labor market. First I will import libraries.

```python
import os
os.getcwd()
os.chdir('D:\\Git projects\\college_works\\Thesis')
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize
from math import gamma
import time
import pandas as pd
```

Now, I need define the parameters of model.

```python

def par():
    global beta, eta, varphi, theta, rho, i, r, gamma1, phi, kappa, alfa, psi, sig, pi, nu
    beta = 0.69
    eta = 0.25
    varphi = 0.25
    theta = 3.44
    rho = 0.19
    alfa = 0.6
    kappa = np.divide(1, (1- eta) )
    nu = 1 + np.multiply(alfa, np.multiply(varphi, kappa))
    pi = 1 - np.multiply(np.multiply( (1 - alfa), varphi), kappa )
    sig = np.divide(np.multiply(eta, kappa), pi )
    psi = np.multiply(np.power(eta, eta), np.power( (1-eta), (1-eta) ) )
    i = 7
    r = 27
    gamma1 = gamma(   1 - np.multiply( np.divide(1, np.multiply(theta, (1-rho)) ), np.divide(1, (1 - eta) ) ) )   
    phi = np.array([0.138, 0.174, 0.136, 0.1, 0.051, 0.084, 0.168]).reshape(i, 1)

```

So I will define my initial guess of $\tau^w$, $\tau^h$, and $w$.

```python

def taus2():
    par()
        
    tau_h = np.random.uniform(low=-0.99, high=40, size=(i,r))
    tau_h[0, :] = 0

    tau_w = np.random.uniform(low=-0.99, high=0.999, size=(i,r))
    tau_w[0, : ] = tau_w[0, 0]
    
    w =np.random.uniform(low=0.001, high=30, size=(i,r))
    w[:, r-1] = 1
    
    x1 = np.array( [tau_w, tau_h, w] )
    
    return x1

x1 = taus2()
```

 The time spent in school is given by:
 
$$s^* = \left(1 + \frac{1-\eta}{\beta \phi}\right)^{-1}$$



```python
def sf( ):
    global s
    s = np.power( (1+ np.divide( (1-eta), ( np.multiply(beta, phi) ) ) ), -1 )
    s = s.reshape(i, 1)
    return s
```

The fraction of teachers, $p_{tr}$, can be written as:



$$p_{tr} = \frac{ \left[ \frac{1- \tau^w_{tr}}{(1 + \tau^h_{tr})^\eta} w_{tr} s_t^{\phi_t}(1-s_t)^{\frac{1-\eta}{\beta}} \right]^\theta} 
{\sum_{j=1}^N \left[ \frac{1 - \tau_{jr}^w}{(1 + \tau_{jr}^h)^\eta} w_{jr} s_j^{\phi_j} (1-s_j)^{\frac{1-\eta}{\beta}} \right]^\theta } $$



```python
def p_trf(x1):    
    s = sf( )    
    A = np.divide( (1 - x1[0]) , np.power( ( 1 + x1[1] ), eta) )     
    b = np.power(s, phi ) 
    B = np.multiply(b.reshape(i,1), x1[2] )     
    C = np.power( (1 - s), np.divide((1-eta), beta) )
    d = np.multiply(np.multiply(A, B), C )
    k = np.power(d, theta)
    p_tr = np.divide( k[i-1], np.sum(k, axis=0) )
    return p_tr
 
```

The teacher's human capital is given by:

$$
	H_{tr} = p_{tr}^{\frac{\nu}{\pi}} (s_t^{\phi_t} \eta^\eta)^{\frac{\kappa}{\pi}} 
\left( \frac{1-\tau_{tr}^w}{1+ \tau_{tr}^h} w_{tr}\right)^\sigma \gamma^\frac{1}{\pi}
$$

Where $\kappa = 1/(1 - \eta)$, $\pi = 1-(1-\alpha)\varphi\kappa$,  $\nu = 1+ \alpha\varphi\kappa -\theta\kappa$, and $\sigma = \frac{\eta \kappa}{\pi}$.




```python
  
def H_trf(x1):    
    p_tr = p_trf(x1)  
    A = np.power(np.multiply( np.divide( (1 - x1[0]), (1 + x1[1]) ), x1[2] ), sig )    
    A = A[i-1]     
    P = np.multiply(np.power(p_tr, (nu/pi)), np.power(eta, sig ) )
    g = np.divide(np.multiply(phi[i-1], kappa ), pi )
    C = np.multiply( np.power(s[i-1], g ), np.power(gamma1, np.divide(1, pi) ) )
    H_tr = np.multiply(np.multiply(P, A), C )       
    return H_tr

```

\begin{equation*}
\tilde{w}_{ir}= \psi  \left( \frac{1-\tau_{ir}^w }{(1+ \tau_{ir}^h)^\eta} w_{ir} \right)   (p_{tr}^{\alpha}H_{tr}^{1-\alpha})^{\varphi} s_i^{\phi_i}  (1-s_i)^{\frac{1-\eta}{\beta}} 
\end{equation*}
where $\psi = \eta^\eta(1-\eta)^{1-\eta}$. 
We can interpret $\tilde{w}_{ir}$ as a liquid reward for a person with mean ability from region $r$ and occupation $i$. So, $\tilde{w}_{ir}$ is composed by wage per efficiency unit in the occupation $w_{ir}$ schooling, teacher's human capital and frictions. 


```python
def w_tilf(x1):
    H_tr = H_trf(x1) 
    p_tr = p_trf(x1)                 
    C = np.power((1 - s), np.divide( (1-eta), beta )).reshape(7, 1)
    pp = np.power(s, phi)        
    A = np.multiply(psi, np.multiply( np.divide( (1 - x1[0]), np.power( (1 + x1[1]), eta ) ), x1[2] ) )    
    b = np.power(np.multiply(np.power(p_tr, alfa), np.power(H_tr, (1-alfa) ) ), varphi )    
    B = np.multiply(b, pp.reshape(7,1))
    w_til =  np.multiply(np.multiply(A, B), C )
    return w_til 

```

\begin{equation}\label{eq17}
p_{ir} =  \frac{\tilde{w}_{ir}^\theta} {\sum_{j=1}^N \tilde{w}_{jr}^\theta}
\end{equation}

Where $p_{ir}$ is the fraction of people that work in occupation $i$ in region $r$


```python

def p_irf(x1):    
    w_til = w_tilf(x1)
    w_til2 = np.power(w_til, theta) 
    w_r = w_til2.sum(axis = 0)    
    p_ir = np.divide(w_til2 , w_r ) 
    return np.array(p_ir), np.array(w_r)

```

Let $W_{ir}$ be the gross average earnings in occupation $i$ in region $r$. Then:

\begin{equation}\label{eq27}
W_{ir} = w_{ir}\mathbb{E}[h(e_{ir}, s_{i})\epsilon_i] = \frac{(1-s_i)^{-1/\beta}}{(1-\tau_{ir}^w)}\gamma \eta \left( \sum_{i=1}^N \tilde{w}_{ir}^\theta  \right)^{\frac{1}{\theta(1-\eta)}}
\end{equation}

Where $\gamma= \Gamma(1-(\theta(1-\rho))^{-1}(1-\eta)^{-1})$ is related to the mean of the Fréchet distribution for abilities.




```python
def Wf(x1):
    p_ir, w_r = p_irf(x1)         
    z = np.multiply(np.multiply(gamma1, eta), np.power(w_r, np.divide(1, np.multiply(theta, (1 - eta)) ) ) )
    A = np.divide( np.power( (1 - s), (-1/beta) ), ( 1 - x1[0] )  )                
    W = np.multiply(A, z)
    return W, p_ir

```

Now I need import PNAD data.



```python
def simul():
    global p_t, W_t
    p_t = pd.read_csv('pt.csv', sep=';')
    p_t = p_t.iloc[0:7]
    p_t.set_index('ocup', inplace=True)
    p_t = np.array(p_t)
    
    W_t = pd.read_csv('wt.csv', sep=';')
    W_t.set_index('ocup', inplace=True)
    W_t = np.array(W_t)
    
    return p_t, W_t

simul()

```



So, the problem consist in minimize equation below,  using L-BFGS-B. Others algorithms can be used, for example genetic algorithm.


\begin{equation}\label{eq28}
Dist = \sum_{i=1, r=1}^{N, R} \left(  \frac{W_{ir}^M - W_{ir}^T}{W_{ir}^T}  \right)^2 + \sum_{i=1, r=1}^{N, R} \left(  \frac{p_{ir}^M - p_{ir}^T}{p_{ir}^T}  \right)^2 
\end{equation}


```python
def obj(x1):
    
    x1 = x1.reshape((3, i, r)) 
    x1[0, 0, : ] = x1[0, 0, 0]    
    x1[1, 0, :] = 0
    x1[2, :, r-1] = 1
            
    W, p_ir = Wf(x1)
    
    D =  (np.power(np.divide( (W-W_t), W_t ), 2) + np.power(np.divide( (p_ir-p_t), p_t ), 2) ).sum()
    D = np.log(D)
    
    return D

```


```python
%time obj(taus2())
```


### Constraints


```python

Bd = ((-0.99, 0.999), )*189 + ((-0.99, 40), )*189 + ((0.001, 30), )*189
Bd = np.array(Bd)

def hessp(x, l):
    return np.zeros((3, i, r))

```

### Optimization


```python
## Nelder Mead

def callback(x):
    fobj = obj(x)
    print(f'\033[1;033mObjetivo: {np.around(fobj, 4)}') 

if __name__ == '__main__':

    %time sol2 = minimize(obj, x1,  method='Nelder-Mead', callback=callback, options={'maxiter':1e6})

```
