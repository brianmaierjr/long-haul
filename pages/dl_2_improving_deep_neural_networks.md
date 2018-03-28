---
layout: article
title: "Deep Learning (2/5): Improving Deep Neural Networks"
intro: | 
    This course focuses on common problems you might encounter when working on DL-projects. The course includes some useful recipes that might help you where to tune your algorithm when it does not perform the way it should. It also introduces some best practices for training your own NN and also some useful techniques to speed up the learning process.
permalink: /ml/deep-learning/2
tags:
    - probability distributions
    - bias/variance
    - over-/underfitting
    - regularization
    - L2-Regularization
    - dropout
    - early stopping
    - data augmentation
    - input normalization
    - weight decay
    - exploding/vanishing gradient
    - Mini-Batch Gradient Descent
    - Exponentially Weighted Average
    - Momentum
    - RMSprop
    - Adam
    - learning rate decay
    - local optima
    - softmax
    - pandas & caviar
    - hyperparameter tuning
    - batch norm
    - TensorFlow
toc: true
---

{% include toc.md %}

## Course overview
**Week 1** introduces the various hyperparameters of a model and how to choose reasonable values for them. You will also learn how to identify problematic behavior of algorithm and where it may be rooted.
**Week 2** introduces some optimization algorithms that may speed up the overall learning process. 
**Week 3** wraps up on hyperparameters and how to find optimal values for them. It also introduces Softmax as an alternative activation function for multiclass-classification. This is also the week where you get to know a DL-Framework (TensorFlow) for the first time.

## Hyperparameter tuning

We have learned in [part 1]({% link pages/dl_1_neural_networks.md %}) that setting up a NN is a highly iterative and empirical process. There is no algorithm that can calculate the optimal number of layers, hidden units or learning rate for you. Sometimes there are a few rule of thumbs but more often the values for the hyperparameters are chosen more or less intuitively.
It is also true that results from one domain can seldom be transferred to another. So if you have a NN that works well in computer vision, it is not guaranteed that this NN also works well for audio or language processing tasks. Most of the time it is impossible to "guess" the optimal values in the first try. They have to be manually adjusted to improve learning. This requires experience which can be obtained through practice - or by someone who tells you what works (and what not). And this is exactly what this course is aimed at.