---
layout: article
title: Machine Learning
image: ml_title.jpg
intro: | 
    Machine Learning has fascinated me since I first heard about it. The idea of being able to teach my computer something without having to explicitly program it is electrifying.
    A lot of what I know I have learned from the following sources:
    
    - Free and paid courses on [Coursera](https://www.coursera.org/)
    - free lecture videos of [Stanford University](http://cs231n.stanford.edu/)
    - courses at [FHNW](https://www.fhnw.ch/) where I am earning my master's degree with a focus on ML
    
    I summarized what I have learned in my own words and have decided to put it online for you to read. I distinguish the following topics (roughly following Andrew Ng's courses on [Machine Learning](https://www.coursera.org/learn/machine-learning)/[Deep Learning](https://www.coursera.org/specializations/deep-learning) on Coursera):
    
permalink: /ml
toc: true
eta: true
---

* [Introduction to Machine Learning]({% link pages/ml_intro.md %}) (11 weeks)
* Deep Learning (16 weeks)
    * [Neural Networks and Deep Learning]({% link pages/dl_1_neural_networks.md %}) (weeks 1-4)
    * [Improving Deep Neural Networks]({% link pages/dl_2_improving_deep_neural_networks.md %}) (weeks 5-7)
    * [Structuring ML projects]({% link pages/dl_3_structuring_ml_projects.md %}) (weeks 8-9)
    * [Convolutional Neural Networks]({% link pages/dl_4_convolutional_neural_networks.md %}) (weeks 10-13)
    * [Sequence Models]({% link pages/dl_5_sequence_models.md %}) (weeks 14-16)

## Why the hassle?

_"Writing down what some one else has already said... what's it worth?"_ you might ask. Well, for me summarizing in my own words what I have learned is a good opportunity to consolidate my knowledge and refine my thoughts. Plus, with a written summary I also get a searchable reference for later use that I can go through without having to watch the videos again. 

I'm putting this online in the hope someone else might find it useful too. At the end of the day, sharing is caring. If you like what you see please feel free to [drop me a line]({% link contact.md %}). If you find mistakes (typos, wrong formulas, wrong explanations, …) or the descriptions seem unclear to you, please do not hesitate to send me a correction. Since this website is hosted on GitHub Pages you can also just fork my repository and send me a pull request!

## About the Coursera courses

Andrew Ng's courses are among the best [MOOC](https://en.wikipedia.org/wiki/Massive_open_online_course) have seen so far on the internet. The explanation are very comprehensive and illustrated with real-world examples. Each course consists of a series of videos with occasional (ungraded) mini-quizzes inside them. Those quizzes mostly contain just one or two questions and are quite easy if you have followed Andrew’s explanations. You still should do them to check if you’re still on track with your understanding of the matter.

The videos are followed by a (graded) quiz, which is a bit more difficult and requires you to really understand the theory. You also have to pass some hands-on programming exercises in order to finish the course. The instructions in those assignments are always very extensive and clear and go over some of the theory again to make sure you get the context. Most of the time you're given some code where you have to complete the key parts, so you don't have to waste your time implementing boilerplate code (although I think it would make sense to do this at least once).

For me, those programming assignments are some of the highlights of this course. They provide an example of what an application of the theory might look like if put into practice. Most of the time you end up with a working application that you can try out with your own data. They are not always challenging, i.e. sometimes you're made to implement a formula that is only provided a few lines above. But heck, they're always motivating. It is fun to e.g. try out an image classifier that recognizes sign language with own images of your own hands.

You can also earn a certificate for each course. To do so, you have to pass all the assignments (quizzes and programming assignments) with at least 80% of the maximum number of points. The suggested time needed to complete one of Andrew's courses on coursera ranges from 2 to 11 weeks. It took me between 3 to 6 hours to complete a single week but you might need less/more time, depending on how thorough you go through the material and how much you play around in the assignments.

### Machine Learning (11 weeks)

This is an introductory course on various ML techniques. You learn about the distinction of supervised and unsupervised learning as well as some key algorithms in each of these areas. This course has become a de-facto standard for people wanting to break into ML. It is free of charge which might attribute to its immense popularity. The exercises in this course are all done in Matlab. A lot of universities have student licenses to give away, so you might ask your tech department for one if you’re currently enrolled in a university. If not you can also use Octave (Matlab’s open-source twin).

### Deep Learning Specialization (16 weeks)

This is a 16-week specialization with a focus on Deep Learning including all kinds of variations of Neural Networks. Although it is not explicitly built on top of the introductory course I think it’s a very good idea finishing that one first before starting the specialization (in fact Andrew Ng [explicitly recommends this in the FAQs](https://www.coursera.org/specializations/deep-learning#faq-list)). In contrast to the introductory course all assignments are in Python 3. Most of the time you get an IPython notebook with code that you have to complete. The notebook contains detailed instructions about what to do and the relevant positions in the code are marked. The specialization consists of five courses:


