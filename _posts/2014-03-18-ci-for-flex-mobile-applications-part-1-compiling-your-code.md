---
id: 252
title: CI for Flex Mobile Applications – Part 1
date: 2014-03-18T19:21:22+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=252
permalink: /ci-for-flex-mobile-applications-part-1-compiling-your-code/
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
  This entry is part 2 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-24">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Compiling your code 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this first part of my tutorial on how to set up a CI process for your mobile app written with Flex I will show you how to compile your code. <span style="line-height: 1.5;">If you haven&#8217;t already followed the steps described in </span><a style="line-height: 1.5;" title="CI for Flex Mobile Applications – Part 0: The setup" href="http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-0-the-setup/">Part 0 </a><span style="line-height: 1.5;">you should do so now before you start.</span>

As a result of this second part we should get our compiled code in form of a \*.swf-File which will contain the compiled classes (i.e. your application logic). This file can later be bundled together with other assets you may have (images, audio, config-files &#8230;) as well as the AIR runtime, resulting in an \*.ipa (iOS) or *.apk (Android) file for publication in the AppStore resp. PlayStore.

<!--more-->

Note: This is a part in a series of articles. The other parts are:

  * [Part 0: The Setup](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-0-the-setup/ "CI for Flex Mobile Applications – Part 0: The setup")
  * [Part 2: Packaging your app](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-2-packaging-your-app/ "CI for Flex Mobile Applications – Part 2: Packaging your App")
  * [Part 3: Performing Unit Tests](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-3-performing-unit-tests/ "CI for Flex Mobile Applications – Part 3: Performing Unit Tests")
  * [Part 4: Generating Documentation](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-4-generating-documentation/ "CI for Flex Mobile Applications – Part 4: Generating Documentation")
  * [Part 5: Tipps & Tricks](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-5-tipps-and-tricks/ "CI for Flex Mobile Applications – Part 5: Tipps and Tricks")
  * [Part 6: Troubleshooting](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-6-troubleshooting/ "CI for Flex Mobile Applications – Part 6: Troubleshooting")

## The MXML-Compiler

To compile our \*.mxml or \*.as-Files we use the MXML-Compiler shipped with the AIR-SDK. You find it in the \bin-Folder of your Folder, where you store the Flex-SDK used to create your app (e.g. C:\tools\sdk\flex\4.12.0_AIR4.0\bin). You can run the compiler from the command line, if you like, but we will use an Ant-Target instead, which is much easier to read.

However, for the sake of completeness, here&#8217;s the full command line syntax (also available from the command line by typing amxmlc -help list)

<div id='stb-container-9760' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-9760' class='stb-info_box stb-box' >
    <ul>
      <li>
        For more help on the compiler options visit the <a title="MXMLC Compiler options" href="http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf69084-7a92.html" target="_blank">reference page</a>
      </li>
      <li>
        For general help on running the MXMLC compiler from the command line visit the <a title="Using the MXMLC application compiler" href="http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf69084-7fcc.html" target="_blank">official documentation</a>
      </li>
    </ul>
  </div>
</div>

# Step 1: Getting the Ant Task Definitions

In order for Ant to recognize the target we are going to use to run the MXMLC compiler we need to define the tasks first. Doing this is easy: Just add a `taskdef`-target on top of your script pointing to the `flexTasks.jar`-File lying in a sub-folder of your Flex SDK root.

The `FLEX_ROOT` property should be set in your `build.properties` file and point to the base directory of your Flex SDK.

# Step 2: Implementing the ANT-Script

An easier way to run the MXMLC command is via its ant target, which is syntactically similar to the command line. To compile your code with our build script we therefore simply have to include the target. The exact characteristics of the target are specific to your project. However, to give you a rough start, here&#8217;s a sample of how it might look like:

<div id='stb-container-6448' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-6448' class='stb-info_box stb-box' >
    To find out more about the MXMLC Ant task visit the official documentation:</p> 
    
    <ul>
      <li>
        <a title="Using Flex Ant tasks" href="http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf678b2-7ffc.html" target="_blank">About Flex Ant tasks</a>
      </li>
      <li>
        <a title="Working with compiler options" href="http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf69084-7a63.html" target="_blank">Working with compiler options</a>
      </li>
      <li>
        <a title="Using the mxmlc Ant task" href="http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf678b2-7ff3.html" target="_blank">Using the mxmlc Ant task</a>
      </li>
      <li>
        <a title="Adobe Flex Ant tasks" href="http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf678b2-8000.html" target="_blank">Adobe Flex Ant tasks</a>
      </li>
    </ul>
  </div>
</div>

## Step 3: Test everything out

To check whether we did everything correctly, simply run the job again. It should now run MXMLC via its Ant target and (if you don&#8217;t have any syntax errors in your source code and resolved all the dependencies in the Ant script) produce a *.swf file in the _target_ folder.

## What we have done in this chapter

In this chapter we extended our build script to compile our code using  the Ant target for the MXMLC compiler. We now have a *.swf files containing the compiled classes, which can be used to package our app for development or release to different platforms.

When you&#8217;re all set, continue with [Part 2: Packaging your app](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-2-packaging-your-app/ "CI for Flex Mobile Applications – Part 2: Packaging your App").