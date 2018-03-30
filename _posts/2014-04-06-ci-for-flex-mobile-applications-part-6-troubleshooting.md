---
id: 288
title: CI for Flex Mobile Applications – Part 8
date: 2014-04-06T12:02:49+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=288
permalink: /ci-for-flex-mobile-applications-part-6-troubleshooting/
frutiful_posts_template:
  - "2"
  - "2"
categories:
  - Coding
  - Technical
tags:
  - ant
  - as3
  - continuous integration
  - flex
  - jenkins
  - mobile
series:
  - Continuous Integration for Flex Apps
---
<div class="seriesmeta">
  This entry is part 9 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-6">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Troubleshooting
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

Here are some common problems you may run into when trying to set up a CI process for Flex Mobile Applications with Jenkins and Ant.

<!--more-->

# My job keeps running and never finishes. After some time I get an Error &#8220;ERROR: Timeout after &#8230; minutes&#8221;

This error can happen if your git client is not set up correctly. To fix it follow these steps:

  1. First of all. Try if you can clone/fetch from your Github repository using git bash `git clone git@github.com:username/Project.git.` If this does not work, you must fix it by creating a new SSH key pair and adding the key to your Github account.
  2. If your job still loops infinetely,  make sure, you added the path to your Git executable correctly under Jenkins > Manage Jenkins > Configure System
  3. <span style="line-height: 1.5;">If your job still fails it is likely that Jenkins does not find the credentials you provided. Although your git client may work from a CLI, Jenkins runs under an own user and hence needs to know where the keys are. To do this you must create an environment variable called <code>HOME</code> pointing to your own Home directory (e.g. <code>C:\Users\Daniel</code>)</span>

# In the packaging target I get an error &#8220;error 105: application.initialWindow.content contains an invalid value&#8221;

This is probably because you are using FlashBuilder as an IDE. When debugging or exporting a release package with FlashBuilder, FB replaces the `<initialContent>`-node in the application descriptor dynamically with the name of the *.SWF file it generated in its internal build process. You can see this when looking at the node in the application descriptor, containing the following value:

<pre>&lt;content&gt;[This value will be overwritten by Flash Builder in the output app.xml]&lt;/content&gt;</pre>

To get the packaging to work in Jenkins, the node in the application descriptor must contain the same name that is used as output in the compile-step (usually ${PROJECT.name}.swf). Otherwise, ADT won&#8217;t know which SWF-File to link with the Application container. Simply change the node content to this value, and the packaging step should also work:

<pre>&lt;content&gt;MyApp.swf&lt;/content&gt;</pre>