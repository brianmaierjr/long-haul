---
id: 500
title: 'Mockito + PowerMock &#8211; Part 0: Introduction'
date: 2014-12-16T18:08:30+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=500
permalink: /mockito-powermock-part-0-introduction/
categories:
  - Coding
tags:
  - junit
  - mock
  - mocking
  - mockito
  - powermock
series:
  - Mockito
---
<div class="seriesmeta">
  This entry is part 1 of 3 in the series <a href="http://www.tiefenauer.info/series/mockito/" class="series-40" title="Mockito">Mockito</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-75">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Introduction
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

When running Unit Tests, a class under test usually has a lot of dependencies. Since Unit Tests are [meant to test a class in isolation](http://en.wikipedia.org/wiki/Unit_testing "Wikipedia: Unit Tests"), these dependencies often make it hard to test a class, since the dependencies have an influence on the state of an object. In some cases, these dependencies make unit testing impossible alltogether. But what if you could replace these dependencies and have them hehave exactly how you want in each tests? This is where Mockito and its bigger brother PowerMock come in. Both frameworks are described in this series.

<div class="ffs-sep" id="ffs-sep-98" style="border-bottom:1px solid #ebebeb;  height:10px; ">
</div>

<div class="clearfix">
</div>

<!--more-->

The series consists of 6 parts:

  * [Part 1: Simple Stubbing and Mocking](http://www.tiefenauer.info/mockito-powermock-part-1/ "Mockito + PowerMock: Part 1")
  * [Part 2: Using Matchers](http://www.tiefenauer.info/mockito-powermock-part-2/ "Mockito + PowerMock: Part 2")
  * Part 3: Advanced Stubbing and mocking
  * Part 4: Spying and verifying assumptions
  * Part 5: Mocking final, static and private methods
  * Part 6: Triggering Exceptions

Mockito is hosted on GitHub. PowerMock is hosted on Google Code, but is expected to change to GitHub too since Google [has decided to shut down their code hosting service](http://google-opensource.blogspot.ch/2015/03/farewell-to-google-code.html).

<span class="ffs-bs"><a href="https://github.com/mockito/mockito" class="btn btn-small btn-primary " style="color:#fff;" ><span class="ffs-icon-container left"><i class="fa fa-github"></i></span>Visit Mockito on GitHub</a></span> <span class="ffs-bs"><a href="https://code.google.com/p/powermock/" class="btn btn-small btn-primary " style="color:#fff;" ><span class="ffs-icon-container left"><i class="fa fa-github"></i></span>Visit PowerMock on Google Code</a></span> 

&nbsp;

Some sample code for the steps in this tutorial can be found in my own GitHub repository. It is an Eclipse project with two sample classes that are being tested using Mockito and PowerMock. The project comes with an included distribution of Mockito and PowerMock. This means that tests can be run out-of-the-box, but there may be newer versions of Mockito and/or PowerMock available. Feel free to fork and improve this project. Feedback is always welcome.

<span class="ffs-bs"><a href="https://github.com/tiefenauer/MockitoExample" class="btn btn-small btn-primary " style="color:#fff;" ><span class="ffs-icon-container left"><i class="fa fa-github"></i></span>Go to GitHub repository</a></span> 

All set? Then let&#8217;s start with some basic mocking.