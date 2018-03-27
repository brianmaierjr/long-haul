---
layout: article
title: "Deep Learning (1/5): Neural Networks and Deep Learning"
intro: | 
    In this course you will learn about the basics of Neural Networks (NN). You will get to know the nuts and bolts of neural networks. Starting out with simple Logistic Regression with a single node you gradually add complexity by expanding this to a one-layer network and finally a deep network with multiple layers. You will also get a short introduction of Python, IPython notebooks and Numpy in the first programming assignment (week 2). This should be no problem if you already know Python, but if you feel unfamiliar with these technologies you should maybe invest a bit more time on those technologies using extracurricular tutorials. It will also be week two where you will implement logistic regression “bare metal”, i.e. by just using Python and Numpy. In later programming assignments you will implement a 1-Layer-NN (week 3) and finally your first Deep-NN step by step (week 4). In the last week’s assignment you will implement a binary classifier that can recognize cat pictures with fairly high accuracy as a Deep-NN. You can test it with your own pictures!
permalink: /ml/deep-learning/1
tags:
    - Logistic Regression
    - Gradient Descent
    - hidden layer/units
    - activation function
    - Sigmoid
    - (Leaky) ReLU
    - Tanh
    - Loss
    - cost function
    - computation graph
    - forward propagation
    - backprop
    - Numpy
    - vectorization
    - shallow NN
    - deep NN
    - Random initialization
toc: true
---

{% include toc.md %}

| **Week**                   | **Content**                   | **Introduced Concepts** |
| 1                   | The first week focuses on theoretical aspects, different types of NN and possible appliances. There is no programming assignment in this week yet.                   | DL as an empirical process<br>GPU performance<br>structured/unstructured data<br>ReLU<br>Convolutional Neural Networks (CNN)<br>Recurrent Neural Networks (RNN) |
| 2                   | In the second week you will learn how to see Logistic Regression with one unit as the simplest form of a neural network. You will learn what an activation function is and why you should use one.                   | logistic regression<br>hidden layers/units<br>activation function (Sigmoid-Function)<br>logistic loss<br>cost function<br>computation graph<br>forward- and backpropagation<br>Gradient Descent<br>Numpy<br>vectorization |
| 3                   | The third week will introduce shallow neural networks, i.e. NN with one hidden layer. You will get to know alternative activation functions. You will see how forward- and backpropagation can be implemented in a vectorized manner as well as why parameters should be initialized randomly.                   | Alternative Activation functions (Tanh, ReLU, Leaky ReLU)<br>Random Initialization |
| 4                   | The final week will generalize the usual steps for building a shallow NN to get a Deep-NN.                   | &nbsp; |