---
layout: article
title: Machine Learning
image: ml_title.jpg
intro: | 
    Machine Learning has captivated me since I first heard about it. I find it fascinating how I can teach my computer something without having to explicitly program it for it.
    A lot of what I have learned so far came from the following sources:
    
    - Free and paid courses on [Coursera](https://www.coursera.org/)
    - free lecture videos of [Stanford University](http://cs231n.stanford.edu/)
    - courses at [FHNW](https://www.fhnw.ch/) where I am earning my master's degree with a focus on ML
    
    I summarized what I have learned in my own words and have decided to put it online for you to read. I divided the content into the following topics (following the structure from Andrew Ng's courses on Machine Learning/Deep Learning on Coursera):
    
    * Introduction to Machine Learning (11 weeks)
    * Deep Learning (16 weeks)
        * [Neural Networks]({% link pages/dl_1_neural_networks.md %}) (weeks 1-4)
        * Improving Deep Neural Networks
        * Structuring ML projects
        * Convolutional Neural Networks
        * Sequence Models
        
    You will find my summaries by following the links above.
permalink: /ml
toc: true
eta: true
---

## Why the hassle?

Writing about what you have learned is a good opportunity to consolidate your knowledge and refine your thoughts. So I found it a good idea to write down what I have learned about ML in my own words. A lot of the content is based on [Andrew Ng’s introductory course about ML](https://www.coursera.org/learn/machine-learning/home/welcome). I later completed Andrew’s [specialization in DL](https://www.coursera.org/specializations/deep-learning) because I wanted to learn more about Neural Networks. A side goal of this summary is therefore also to serve as searchable reference work for later use without me having to go over the videos again. I put all this online in the hope someone else might find it useful too. If you do like what I wrote please feel free to drop me a line below. If you find mistakes (typos, wrong formulas, wrong explanations, …) or the descriptions seem unclear to you, please don’t hesitate to send me a correction. Since this website is hosted on GitHub Pages you can also just fork my repository and send me a pull request!

## About the courses

The time needed to complete the course varies. The shortest course is 2 weeks, the longest 11 weeks. It took me between 3 to 6 hours to complete each week but you might need less/more time (depending on how thorough you go through the material and how much you play around in the assignments). You can earn a certificate for each course.

Each course consists of a series of videos followed by some graded assignments which you have to pass with at least 80% of the maximum number of points in order to get the certificate. The videos occasionally contains mini-quizzes which are not graded. The quizzes mostly contain just one or two questions and are quite easy if you have followed Andrew’s explanations. You still should do them to check if you’re still on track with your understanding of the matter.

Each week finishes with a graded quiz, which is a bit more difficult and requires you to really understand the theory. You also have to pass some graded programming exercises in order to finish the course. These exercises give you the chance of putting the theory into practice. They might not be the most challenging for some of you: often the steps needed to complete the assignments are described in detail, so you basically only have to follow the instructions. I still find the exercises very useful because the graded parts focus on core elements of the theory and freeing you of having to deal with a lot of boilerplate code each time. They are also quite motivating because you can apply your algorithm on your own data.

I have divided up the content into different summaries (one per course). You can find each course’s gist below. Each summary’s roughly follows the course structure, so there is a separate chapter for each week. Please follow the links if you want to know more.

## Course Overview

### Machine Learning (11 weeks)

This is an introductory course on various ML techniques. You learn about the distinction of supervised and unsupervised learning as well as some key algorithms in each of these areas. This course has become a de-facto standard for people wanting to dig into ML. It is free of charge which might attribute to its immense popularity. The exercises in this course are all done in Matlab. A lot of universities have student licenses to give away, so you might ask your tech department for one if you’re currently enrolled in a university. If not you can also use Octave (Matlab’s open-source twin).

### Deep Learning Specialization (16 weeks)

This is a 16-week specialization with a focus on Neural Networks. Although it is not explicitly built on top of the introductory course I think it’s a very good idea finishing that one first before starting the specialization. In contrast to the introductory course all assignments are in Python 3. Most of the time you get an IPython notebook with code that you have to complete. The notebook contains detailed instructions about what to do and the relevant positions in the code are marked. The specialization consists of five courses:

#### Neural Networks and Deep Learning (4 weeks)

In this course you will learn about the basics of Neural Networks (NN). You will get into the bolts and nuts of neural networks. Starting out with simple Logistic Regression with a single node you gradually add complexity by expanding this to a one-layer network and finally a deep network with multiple layers. In the first programming assignment (week 2) you will get a short introduction of Python, IPython notebooks and Numpy. This should be no problem if you already know Python, but if you feel unfamiliar with these technologies you should maybe invest a bit more time on this using extracurricular tutorials. It will also be week two where you will implement logistic regression “bare metal”, i.e. by just using Python and Numpy. In later programming assignments you will implement a 1-Layer-NN (week 3) and finally your first Deep-NN step by step (week 4). In the last week’s assignment you will implement a binary classifier that can recognize cat pictures with fairly high accuracy as a Deep-NN. You can test it with your own pictures!

| **Week**                   | **Content**                   | **Introduced Concepts** |
| 1                   | The first week focuses on theoretical aspects, different types of NN and possible appliances. There is no programming assignment in this week yet.                   | DL as an empirical process<br>GPU performance<br>structured/unstructured data<br>ReLU<br>Convolutional Neural Networks (CNN)<br>Recurrent Neural Networks (RNN) |
| 2                   | In the second week you will learn how to see Logistic Regression with one unit as the simplest form of a neural network. You will learn what an activation function is and why you should use one.                   | logistic regression<br>hidden layers/units<br>activation function (Sigmoid-Function)<br>logistic loss<br>cost function<br>computation graph<br>forward- and backpropagation<br>Gradient Descent<br>Numpy<br>vectorization |
| 3                   | The third week will introduce shallow neural networks, i.e. NN with one hidden layer. You will get to know alternative activation functions. You will see how forward- and backpropagation can be implemented in a vectorized manner as well as why parameters should be initialized randomly.                   | Alternative Activation functions (Tanh, ReLU, Leaky ReLU)<br>Random Initialization |
| 4                   | The final week will generalize the usual steps for building a shallow NN to get a Deep-NN.                   | &nbsp; |

#### Improving Deep Neural Networks (3 weeks)

This course focuses on common problems you might encounter when working on your own DL-projects. The course introduces some useful recipes that might help you when your algorithm is not performing as well as it should. It also introduces best practices when training your own NN and some useful techniques. You will deepen your understanding of how to optimize your hyperparameters and convergence speed. In the last week you get into touch with a DL-Framework (TensorFlow) for the first time.

| **Week**                   | **Content**                   | **Introduced Concepts** |
| 1                   | Week 1 focuses on the various hyperparameters of a model. You also learn how to recognize problems with your algorithm and where they are rooted.                   | probability distributions<br>bias and variance<br>over- and underfitting<br>regularisation techniques (L2, Dropout, Early Stopping)<br>data augmentation<br>input normalization<br>weight decay<br>exploding/vanishing gradients |
| 2                   | Week 2 introduces some optimization algorithms that can speed up the overall learning process.                   | Mini-Batch Gradient Descent<br>Exponentially Weighted Average<br>Momentum<br>RMSprop<br>Adam<br>Learning Rate Decay<br>Local optima |
| 3                   | Week 3 wraps up on hyperparameters and how to find optimal values for them. It also introduces Softmax as an alternative activation function for multiclass-classification.                   | Pandas & Caviar<br>Hyperparameter Tuning<br>Batch Norm<br>TensorFlow |

#### Structuring Machine Learning Projects (2 weeks)

This course focuses on conceptual aspects and workflow planning rather than introducing new algorihms, technologies or frameworks. The goal of this course is to equip you with knowledge you would otherwise have to earn through experience. Therefore, despite being short, this course can make a huge difference for you when you start out with your own project. It can save you from going in the wrong direction for months and then realizing your work was all for nothing. Due to the nature of this course there are no quizzes or programming assignments. Instead you get to sit in a “Machine Learning flight simulator”, where you are presented with a real-world problem and then have to decide how to act next.

| **Week**                   | **Content**                   | **Introduced Concepts** |
| 1                   | The first week focuses on setting up a strategy when working on a DL task. It also reflects on how to measure an algorithms performance and how to improve it.                   | Orthogonalization<br>satisficing and optimizing metrics<br>Train/Dev/Test-Set distributions<br>avoidable bias<br>human level performance |
| 2                   | The second week introduces common errors that can lead to poor performance. It also shows how to find those errors and how to deal with them.                   | error analysis<br>label cleaning<br>Transfer Learning<br>Multi-Task learning<br>E2E-Deep Learning |

#### Convolutional Neural Networks (4 weeks)

In this course you get to know more about Convolutional Neural Networks (CNN). Because CNNs are often used in computer vision, the key concepts are often illustrated with image processing problems. The course contains a few case studies as well as practical advices for using ConvNets. In the first week’s programming assignments you implement the key steps for a CNN that can recognize sign language. In the second week you will get to know Keras as a high-level DL-Framework that uses TensorFlow. You will implement a ResNet that is able to detect whether a person is happy or not. The programming assignment in the third week is all about autonomous driving. You will implement a YOLO-Model that can detect vehicles inside a picture, state their positions an classify them as buses or cars. In the last week you will implement a CNN that is able to generate art images from photos (Neural Style Transfer) and also a face recognition system that can identify people.

| *Week*                   | *Content*                   | *Introduced Concepts* |
| 1                   | The first week explains the advantages of CNN and illustrates convolution by example of edge detection in images. You will get to know the different layers that make the difference between an ordinary NN and a CNN.                   | CONV-Layer<br>POOL-Layer<br>FC-Layer<br>Max- and Avg-Pooling<br>Kernel<br>Filter<br>Channels<br>Padding & Stride<br>Parameter Sharing |
| 2                   | In the second week you get to know a few classic NN-architectures. You learn about the problems of very deep CNNs and how ResNets can help. Finally you are given some practical advides for using ConfNets in context of computer vision.                   | LeNet-5<br>AlexNet<br>VGG-16<br>Residual Networks (ResNets)<br>1x1 Convolutions<br>Inception networks |
| 3                   | Week three is about detection algorithms. You learn how a CNN can not only classify but also localize objects inside an image.                   | Object Localization<br>Landmark and object detection<br>Sliding Windows<br>YOLO-Algorithm (You Only Look Once)<br>Intersection over Unit (IoU)<br>Non-Max Suppression<br>Anchor- & Bounding-Boxes<br>Region Proposal (R-CNN) |
| 4                   | The last week introduces face recognition as a DL problem for CNN. Additionally you get to know Neural Style Transfer (NST) as a special application of CNNs.                   | One-Shot Learning<br>Face Recognition<br>Face Verification<br>similarity function<br>Siamese Networks<br>Triplet Loss<br>Neural Style Transfer (NST)<br>Content- & Style Cost Function |

#### Sequence Models (3 weeks)

The last course introduces various forms of NN-Models that take their input as a sequence of tokens. Starting with Recurrent Neural Networks (RNN) for speech/text processing you get to know word embeddings as a special form of Natural Language Processing (NLP). Finally, you learn about Sequence-to-Sequence Models that take a sequence as an input and also produce a sequence as an output. In the first week’s assignment you will implement two generative models: a RNN that can generate music that sounds like improvized Jazz. You also implement another form of an RNN that deals with textual data which can generate random names for dinosaurs. In the second week you will implement some core functions of NLP models such as calculating the similarity between two words or removing the gender bias. You will also implement a RNN that can classify an arbitrary text with a suitable Emoji. Finally you will put your newly learned knowledge about Attention Models into practice by implementing some functions of an RNN that can be used for machine translation. You will also learn how to implement a model that is able to detect trigger words from audio clips.

| **Week**                   | **Content**                   | **Introduced Concepts** |
| 1                   | In the first week you know Recurrent Neural Networks (RNN) as a special form of NN and what types of problems they’re good at. You also learn why a traditional NN is not suitable for these kinds of problems.                   | Recurrent Neural Network (RNN)<br>Sequence Tokens<br>Many-to-Many/Many-to-One/One-To-Many-Architectures<br>Gated Recurrent Unit (GRU)<br>Long Short Term Unit (LSTM)<br>Bidirectional RNN (BRNN)<br>Deep-RNN |
| 2                   | The second week is all about NLP. You learn how word embeddings can help you with NLP tasks and how you can deal with bias.                   | Word Embeddings<br>t-SNE<br>Word2Vec & GloVe<br>Cosinus-Similarity<br>One-Hot-Encoding<br>Skip-Gram and CBOW<br>Negative Sampling<br>Context & Target-Wort<br>Sentiment Classification<br>Debiasing |
| 3                   | The last and final week of this specialization introduces the concept of Attention Models as a special form of Sequence-to-Sequence models and how they can be used for machine translation.                   | Sequence-to-Sequence Models<br>Encoder/Decoder-Networks<br>Conditional Language Models<br>Attention Models<br>Greedy vs. Beam search<br>Length Normalization<br>Bleu Score<br>Connectionist Temoral Classification (CTC)<br>Trigger Word Dettection |

## Credits

Andrew’s courses some of the best MOOC I have met to this date. The explanation are very comprehensive and illustrated with suitable examples. The programming assignments are not always challenging, but always motivating. It is fun to e.g. try out an image classifier with your own images.