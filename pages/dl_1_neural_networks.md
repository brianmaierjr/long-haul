---
layout: article
title: "Deep Learning (1/5): Neural Networks and Deep Learning"
intro: | 
    In this course you will learn about the basics of Neural Networks (NN). You will get to know the nuts and bolts of neural networks. Starting out with simple Logistic Regression with a single node you gradually add complexity by expanding this to a one-layer network and finally a deep network with multiple layers. You will also get a short introduction of Python, IPython notebooks and Numpy in the first programming assignment.
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

## Course Overview
The **first week** focuses on theoretical aspects, different types of NN and possible appliances. There is no programming assignment in this week yet.
In the **second week** you will learn how to see Logistic Regression with one unit as the simplest form of a neural network. You will learn what an activation function is and why you should use one. You will do two programming assignments. The first one is an (optional) introduction to Numpy and vectorization, which you can skip if you are already familiar with this module. If not, you should do this assignment and maybe even invest a bit more time on those technologies using extracurricular tutorials because Numpy is a very common Python module for ML. In the second assignment you will implement logistic regression “bare metal”, i.e. by just using Python and Numpy.
The **third week** will introduce shallow neural networks, i.e. NN with one hidden layer. You will get to know alternative activation functions. You will see how forward- and backpropagation can be implemented in a vectorized manner as well as why parameters should be initialized randomly. In the programming assignment you will implement a first "real" NN, although it only has one hidden layer (i.e. not a Deep-NN).
Finally in **week four** you will implement your first Deep-NN step by step. The network will be used in a follow-up assignment for a binary classifier that can recognize cat pictures with fairly high accuracy. You can even test it with your own pictures!
