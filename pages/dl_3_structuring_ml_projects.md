---
layout: article
title: "Deep Learning (3/5): Structuring ML projects"
intro: | 
    This course focuses on conceptual aspects and workflow planning rather than introducing new algorihms or frameworks. The goal of this course is to equip you with knowledge you would otherwise have to earn through experience. Therefore, despite being the shortes of all, this course can make a huge difference for you when you start out with your own project. In fact, it can save you from going in the wrong direction for months and then realizing your work was all for nothing. Due to the less technical nature of this course there are no quizzes or programming assignments. Instead you get to sit in a _“Machine Learning flight simulator”_, where you are presented with a real-world problem and then have to decide how to act next.
permalink: /ml/deep-learning/3
tags:
    - Orthogonalization
    - F1-Score
    - Precision
    - Recall
    - satisficing and optimizing metrics
    - Train/Dev/Test-Set distributions
    - avoidable bias
    - human level performance
    - Bayes Optimal Error
    - error analysis
    - label cleaning
    - Transfer Learning
    - Multi-Task learning
    - E2E-Deep Learning
---

{% include toc.md %}

## Course overview
The **first week** focuses on setting up a strategy when working on a DL task. It also reflects on how to measure an algorithms performance and how to improve it.
The **second week** introduces common errors that can lead to poor performance. It also shows how to find those errors and how to deal with them.

## ML Strategy
There comes a point in every ML project where you have trained your Deep-NN and you are still not satisfied with its performance. You therefore want to improve it. You have learned a few methods to do this in [part 2]({% link pages/dl_2_improving_deep_neural_networks.md %}):

* Gather more training data
* try a different optimizer
* ...

Deciding on what action to take next is not trivial. However, where are a few strategies that can help choosing the measure that will produce the biggest performance gain.

### Orthogonalization

I have introduced the term **orthogonalization** in [part 2]({% link pages/dl_2_improving_deep_neural_networks.md %}) quickly. I am going to lay it out in more detail here.
Training a NN in ML usually involves the following steps:

* Optimize the cost function on the training set
* Optimize the cost function on the dev set (validation set)
* Optimize the cost function on the test set
* Rely on the assumptions that a NN trained this way will generalize well on unseen (and unlabelled) data.

An important principle when optimizting the parameters for the cost function is orthogonalization. This term generally states that a specific action should only affect one of the above steps, not several at the same points. Andrew uses an old TV as a metaphor for this. Such a TV usually had different knobs you could use: one for image height, one for image width, one for horiziontal translation, one for vertical translation and so on. You could fine-tune the image using all of these knobs, but a single knob would only affect one specific property of the image.

Simliarly we can fine-tune our NN on the individual steps mentionned above with a set of actions ("knobs"):

|Step/Problem|Action|
|---|---|
| NN does not perform well on training set |Try out bigger NN <br/>try out different NN archtecture<br/>try out a different optimizer (Momentum, RMSprop, Adam, ...)<br/>train longer (more iterations)|
| NN does not perform well on dev set | use regularization<br/>use a bigger training set|
| NN does not perform well on test set | use a bigger dev-set |
| NN does not generalize well for unseen instances | use a different dev set (different probability distribution)<br/>try out a different cost function|

### Setting up your goal

In order to evaluate your model it is often useful to have a metric, that indicates the model's performance with a single number. That way you can compare this metric before and after taking an action. The best known metric to do this is the **F1-Score** ($$F$$), which uses the sub-metrics **Precision** ($$P$$) and **Recall** ($$R$$).

$$
P=\frac{TP}{TP+FP} \\\\
R = \frac{TP}{TP+FN} \\\\
F = \frac{2}{\frac{1}{P} + \frac{1}{R} } = 2\cdot \frac{P\cdot R}{P+R}
$$

An alternative for this metric would be to simply calculate the average error over all instances. When optimizing a NN you usually have several metrics that you want to fine-tune. When doing this, you typically distinguish two different types of metrics:

* **Optimizing metric**: The metric should produce an _optimal_ value (e.g. the NN should have maximal accuracy)
* **Satisficing metric**: The metric should produce an _acceptable_ value (e.g. the NN should have a runtime that is feasibile for training)

When fine-tuning your NN, it often makes sense to treat one of the metrics as optimizing and all the other as satisficing in order to reach your goal.

### Train/Dev/Test set distributions

Carefully defining your training-, dev- and test-set can have a huge impact on your NN's performance. It is crucial that the data in these sets all come from the same **probability distribution**. What I mean by this can be illustrated with an example: Suppose you're training a NN that can classify pictures as cat-pictures or not. If your train your NN with training images of cats that are indoor (or even worse: only cats of a specific race or color), your NN will have a hard time classifying pictures of cats that were taken outdoors (or cats of different races or color).

Mismatched training and dev/test-sets often root in the nature of DL algorithms, which usually require a lot of labelled data. Such data must then be obtained from all available sources. This can become problematic, if for example you train a variant of the above cat classifier to recognize cats from small resolutions images of mobile phones. Representative training data might not be available in the neccessary quantity. However, there are more than enough pictures of cats on the internet. But these are usually high-resolution images and hence come from a different distribution. You usually have two options dealing with such situations:

* **Option 1**: Integrate all pictures (high- and low-res) in one set, shuffle it adn the split into training-, dev- and test-set. This approach usually works out badly because the dev-set should set the goal for optimization and only a small part of the images in the dev-set actually come from the desired distribution (in this case low-res images)
* **Option 2**: Use only low-res images for dev- and test-set. Put all high-res images into the training set and add the remaining low-res images.

As mentionned, option 1 does usually not work very well. Option 2 has the disadvantage that the different sets have different distributions, but there are methods to handle that (see below)

As mentioned in [part one]({% link pages/dl_1_neural_networks.md %}), a common split of labelled data into training-, dev- and test set was 60/20/20. However, with the availability of big data this has gradually shifted to the proportion of 98/1/1. Sometimes it may be OK to have no validation set at all. When doing this you should make sure not to use data from the test set to optimize the parameters because the test set should in any case only contain data the NN has never seen before.

#### Bias and variance with mismatched data distributions.

If your train/dev/test sets end up having different distributions (e.g. from option 2 above) you can further split up the training set in the actual training data and a set we can call _train-dev-set_ which has the same distribution as the training data. You can use this train-dev-set for validation and compare the error with the error on the real validation set to finid out whether you have a variance problem:

- if the difference between the errors is big, you have a variance problem (i.e. the algorithm does not generalize well)
- if the difference between the errors is small, the differences can be attributed to the different distributions (data mismatch problem)

You can of course also address the data mismatch problem by collecting more training data from the desired distribution (i.e. data like the one in the dev/test-set) or you can synthetisize data (data augmentation).

### Comparing to human-level performance

ML can improve very quickly in the beginning and surpass human-level performance at some point. For example contemporary face recognition algorithms are capable of identifying people with remarkable accuracy nowadays. I synchronize my photos with Google Photos, which finds faces of people on the photos and groups them into photos of the same people. I'm often surprised how well this works when sometimes even I as a human would not have found a particular face on a photo or would not be able to identify one particular face.

As long as an algorithm performs worse than a human it can be relatively easily be optimized by feeding it additional labelled data. However, after surpassing human-level performance it can become difficult to optimize it even further.

After an initial steep learning curve, the performance gain gradually flattens out and approximates an (unknown) value which is referred to as **Bayes Optimal Error** (BOE). This value defines the hypothetical best possible performance an algorithm can reach. It does not neccecarily mean a 0% error rate! The BOE can be estimated for some ML problems (e.g. image classification) by comparing it to human-level performance. In these settings it can be assumed that the optimal error rate is close to the BOE. When training an algorithm one should consider this error rate.

The difference between the performance on the training set and the BOE is called **avoidable bias**. If the avoidable bias is big it should be reduced by additional training. In case the accuracy on the training set is already pretty close to the BOE the algorithm is already pretty well-trained. It can however still be improved by focussing on the error on the validation set (focus on variance).

In settings like above, comparing to human-level performance can help in deciding how useful a model is. As soon as a model surpasses human-level performance, it is impossible to determine how high the avoidable bias is (because we don't know where the BOE will be). This is usually the case with structured data, where ML-algorithms are usually better than humans.

## Error analysis

To reduce the error rate of an algorithm it is often useful to examine the instances more closely, where the algorithm did not perform well. If you for example train your cat-classifier you could inspect a sample of 100 images that were erroneously classified as cats. If it turns out that the larger part of these samples are dog pictures, this indicates that the model should primarily be trained with respect to dog pictures. In other words: Training the algorithm to distinguish better between cats and dogs will probably have the biggest impact on the error rate.

### Cleaning up incorrectly labelled data

Inspecting samples can generally help identifying problematic areas of an algorithm. Likewise, mislabeled training data can also be identified by using samples. Wrong labels in the training data are rarely a problem, as long as they are not systematic. However, ML algorithms are usually prone to systematically mislabelled training samples.
Fixing mislabelled training data is time consuming and only makes sense if the wrong labels are responsible for a big part of the errors. However, if you need to fix your labels you should also have a look at samples of correctly classified samples to see if not any of them are actually wrong.

### Build quickly, then iterate

When starting out with an ML project there are usually a lot of directions to go in the beginning. It is therefore crucial to set up a first goal by defining a dev/test set and a metric to optimize. This helps to prioritize the next steps. After having a first goal you can optimize your algorithm towards it and then set up your next goal (rinse and repeat). This process helps you to streamline your actions towards your end goal and reach intermediate results more quickly.

## Transfer learning

When trainin data is scarce you can try to apply the results from one NN to another. To do this you can download a pre-trained NN and try to tune it into your desired direction. If for instance you train a classifier for X-ray images, you could download a pre-trained NN that performs well on photographic images and then optimize it for x-ray images. This is called **transfer learning**.

Transfer learning usually involves replacing the last layer of a NN and optimize only this. If you have more training data you can also replace/optimize the last few layers. This way you don't need to optimize _all_ the parameters of your NN and can focus on optimizing only the parameters of the replaced layers with your training data.

Transfer learning makes sense if...

* ... there is a lot of training data for a general problem and only little data for a specific problem
* ... a general problem has the same input data as a specific problem
* ... low-level features of a general problem are relevant for high-level features of a specific problem

## Multi-task learning
A NN can be optimized for several targets. You can for example train a NN not only to recognize cars, but also people, signs and red lights (autonomous driving). This is called **multi-task learning**. In such settings, the label $$y$$ is usually a vector and not a scalar. The set of labels $$Y$$ is then consequently not a vector, but a $$(k\times m)$$ matrix of $$k$$ labels whereas not all labels need to be known (sparse matrix).

Multi-task learning makes sense if...

* ... the individual tasks can benefit from the same low-level features
* ... the amount of training data per task is about the same
* ... a single NN can be trained, which is big enough to learn all the tasks

## End-to-end Deep Learning

Several steps in a pipeline can be combined to a single NN. This is called **End-to-end Deep Learning** (E2E-DL). An example for such steps are (from speech recognition):

* extraction of features from audio
* identification of single phonemes
* concatenation of phonemes to words
* ...
* creation fo a transcript

Such E2E-Settings usually require a lot more data than traditional approaches. For some tasks (like machine translation) however this is less of a problem, because data is available in sufficient quantities.

Advantages of E2E-DL are:

* the training data really matters and the results don't contain implicit human previous knowledge ("_lets the data speak_")
* no time delay by manual design of intermediate components

Disadvantages of E2E-DL are:

* higher demand for labelled data
* potentially manually designed components that would be helpful are disregarded.