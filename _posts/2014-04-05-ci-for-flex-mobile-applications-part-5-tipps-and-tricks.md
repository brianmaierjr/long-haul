---
id: 285
title: CI for Flex Mobile Applications – Part 7
date: 2014-04-05T11:38:55+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=285
permalink: /ci-for-flex-mobile-applications-part-5-tipps-and-tricks/
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
  This entry is part 8 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-80">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Tipps and Tricks 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this part of the tutorial I&#8217;ll collect some scripts and tipps you might find useful, after you have implemented the build script as described in the last chapters.

<!--more-->

# Updating the build label automatically

If you want the `<buildLabel>` node in your application descriptor to contain the Build-ID used in Jenkins, you can use the following script:

# Updating the TestRunner automatically

In case you have all your test classes in one folder (like me) you might find you wondering whether you could add all those classes to your TestRunner application each time before running the unit tests instead of having them to add manually each time you write a new test class. In short: you can! Just include the following macro in your build script and call it as the first macro before any other macros in your FlexUnit target.

Just extend your TestRunner application with code comments containing the phrases _UNIT\_TESTS\_IMPORT_START_ and _UNIT\_TESTS\_IMPORT_END _to define the start and end section where the import statements will be made.

Likewise, add two comments containing the phrases _UNIT\_TESTS\_ARRAY_START_ and _UNIT\_TESTS\_ARRAY_END_ to mark the sections where the test classes will be pushed into the array in the `currentRunTestSuite()`-function