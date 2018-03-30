---
id: 279
title: CI for Flex Mobile Applications – Part 3
date: 2014-04-03T19:46:20+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=279
permalink: /ci-for-flex-mobile-applications-part-3-performing-unit-tests/
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
  - FlexUnit
  - jenkins
  - mobile
  - testing
series:
  - Continuous Integration for Flex Apps
---
<div class="seriesmeta">
  This entry is part 4 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-92">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Performing Unit Tests
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this third part of the tutorial we are going to set up our build process to perform automated unit tests. The results are the transformed into a readable format in HTML and can also be included in your job dashboard to see the status of the last build at a glance.

<!--more-->

Note: This is a part in a series of articles. The other parts are:

  * [Part 0: The Setup](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-0-the-setup/ "CI for Flex Mobile Applications – Part 0: The setup")
  * [Part 1: Compiling your code](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-1-compiling-your-code/ "CI for Flex Mobile Applications – Part 1: Compiling your code")
  * [Part 2: Packaging your app](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-2-packaging-your-app/ "CI for Flex Mobile Applications – Part 2: Packaging your App")
  * [Part 4: Generating Documentation](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-4-generating-documentation/ "CI for Flex Mobile Applications – Part 4: Generating Documentation")
  * [Part 5: Tipps & Tricks](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-5-tipps-and-tricks/ "CI for Flex Mobile Applications – Part 5: Tipps and Tricks")
  * [Part 6: Troubleshooting](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-6-troubleshooting/ "CI for Flex Mobile Applications – Part 6: Troubleshooting")

# Some background

In order to run the Unit Tests and write the results to a report in a format that can be used in Jenkins for display we need to write our own TestRunner-Application.

If you use Flash Builder as your IDE, the Premium version integrates running FlexUnit tests and displaying the results in a separate view. The method Flash Builder uses is the same: When you add your first unit test, Flash Builder automatically imports all the neccessary libraries and creates two applications: a FlexUnitApplication and a FlexUnitCompilerApplication, each one represented by a MXML file with the same name and an app descriptor with the &#8220;-app.xml&#8221;-suffix. The latter one is simply here to make sure all the test classes are taken into account when running the tests via context menu > &#8220;Execute FlexUnit Tests&#8221;. It is updated automatically for each run or on request.

The first  application Flash Builder creates is the  Application which  is actually used to  run the tests. It adds an XML Listener, which produces output in XML format which is then parsed for display in the FlexUnitView.

We are going to follow a very similar aproach to run our unit tests. However, we can&#8217;t use the FlexUnitApplication from FlashBuilder for CI purposes, because we need a different Listener for our purposes and then run all our tests. We are going to write a (very) simple TestRunner-Application which does exactly this: Adding a CIListener (instead of a XMLListener) and running all of our tests.

We can even extend our build script to automatically update the Application in order to run all unit tests without having to manually add them to the TestRunner-Application each time we have a new test. But this is a topic in the last chapter, where I&#8217;ll provide you with some useful tips and tricks to make your CI-life easier.

But first, let&#8217;s get started with getting the right tools.

# Step 1: Getting the FlexUnit libraries

FlexUnit is an open source project, which is still actively developed. You can get the lastest version from the following GitHub repository:

<a title="FlexUnit GitHub repository" href="https://github.com/flexunit/flexunit" target="_blank">https://github.com/flexunit/flexunit</a>

Just clone the repository into a directory of your choice and run the build script by navigating to the root repository with a command line and typing &#8220;ant&#8221;. This will compile and tests all of the sub-projects into separate libraries. In some cases, this can be quite cumbersome, because you need to have an environment variable pointing to a Flex SDK of your choice (possibly the latest one) and you need to have the Debugger version of Flash Player set as the default application to open *.swf files. You might also need to open the command line as an Administrator and run the build script repeatedly.

However, since we&#8217;re only going to need a part of the FlexUnit project, just make sure you get the following two *.swc-libraries:

  * [flexunit-cilistener-4.1.0-x.y.y.y.y.swc](https://github.com/tiefenauer/FlexCITutorial/blob/master/flexUnit/libs/FlexUnitAIRcilistener.swc)
  * [FlexUnitAIRCIListener.swc](https://github.com/tiefenauer/FlexCITutorial/blob/master/flexUnit/libs/flexunit-cilistener-4.1.0-x-y.y.y.y.swc)

<div id='stb-container-5554' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-5554' class='stb-info_box stb-box' >
    I won&#8217;t go through the hassle of describing every single step needed to compile the FlexUnit projects, but should you not be able to get the two libraries mentioned above, you can always get them from my GitHub repository by clicking the links above. However you have to take into account that these files might be outdated by the time you&#8217;re reading this!
  </div>
</div>

# Step 1: Writing a TestRunner Application

As stated above, our TestRunner-Application is a simple application along with the application descriptor with the following structures:

What this application does is simply registering a CI-Listener, take a number of classes, add them to a test suite and then run that test suite with the CI-Listener producing the output. Just make sure you add all your Test Classes, that you want to include, in the `currentRunTestSuite()`-function.

<div id='stb-container-4700' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-4700' class='stb-info_box stb-box' >
    In Part 5: Tipps&Tricks I&#8217;ll show you how to automate this step so that all test classes inside a certain folder are automagically included in your test runner!
  </div>
</div>

# Step 2: Defining the FlexUnit Tasks

In order to get ant to recognize `<flexUnit>` as a valid ant task, we need to import the task definitions (as we did with the mxmlc-Task).

<span style="line-height: 1.5;">The value of the </span>`${TEST.build}`<span style="line-height: 1.5;"> variable is defined in our </span>`build.properties`<span style="line-height: 1.5;"> file.</span>

# Step 3: Adding to the build the script

In order to keep the build script readable, we are going to separate the steps needed to perform the unit tests into the following steps, whereas each step is represented as a separate macro in the build script:

  * Compile our TestRunner application (`compile-runner` macro)
  * Execute the tests using our TestRunner application (`execute-tests` macro)
  * Generating HTML reports (`generate-html-reports` macro)

## Compiling the TestRunner application (macro)

This macro simply compiles our TestRunner application together with all the test classes into a *.swf file, which can then be executed with the `<flexunit>`-target. You&#8217;ll notice that this macro contains another mxmlc-target, which is structurally identical with the one we use to compile our app.

## Executing the unit tests (macro)

This macro executes the Ant-target for FlexUnit, taking our compiled TestRunner-swf as an input and producing the output in the directory specified in _reportdir_.

## Generating the HTML reports (macro)

When the _execute-tests_-macro has finished running its test, it has produced a number of XML files in the specified directory. These files can now be converted to HTML, which is much more user-friendly to read.

# Step 4: Putting it all together

Now that we splitted our unit test task into single steps using the macros above, combining them is simple. Just add the following script under the unit tests task which we prepared earlier and which is still empty:

Note that we first need to define the classes to be included in the TestRunner application. Luckily , using Ant&#8217;s built-in `<fileset>`-task makes this part a breeze. Just make sure all your test classes end with &#8230;_Test_.

# Step 5: Test everything out

As before (you may have guessed it), we&#8217;re going to see if what we did actually works by executing the build script with ant. This should produce a number of files in the flexUnit output directory.

# What we did so far

In this chapter, we wrote a simple application to run our unit tests, compiled it together with the test classes and ran it to get the test report in both XML and HTML.

When you&#8217;re all set, continue with [Part 4: Generating ASDOC](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-4-generating-documentation/ "CI for Flex Mobile Applications – Part 4: Generating Documentation").