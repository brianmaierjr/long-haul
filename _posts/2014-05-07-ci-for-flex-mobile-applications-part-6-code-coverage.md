---
id: 459
title: 'CI for Flex Mobile Applications: Part 6'
date: 2014-05-07T14:29:14+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=459
permalink: /ci-for-flex-mobile-applications-part-6-code-coverage/
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
  - coverage
  - flex
  - jenkins
  - mobile
series:
  - Continuous Integration for Flex Apps
---
<div class="seriesmeta">
  This entry is part 7 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-52">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Code Coverage 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

Another important step when creating a CI suite for your mobile application is code coverage. Code coverage measures the amout of code covered by unit tests by class and/or by line, giving valuable information on which parts of your application need more unit testing and which are already pretty well covered.

<!--more-->

To get this step to work we need a modified version of FlexUnit. The process then is as follows:

  1. We compile our TestRunner.mxml application (which we created in [Part 3 of this tutorial](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-3-performing-unit-tests/ "CI for Flex Mobile Applications – Part 3: Performing Unit Tests")) using the modified FlexUnit libraries. This enables FlexUnit to record which lines of the code are being executed (and which not).
  2. We then run the compiled application using a slightly different (modified) Ant task for FlexUnit providing the source files to compare the whole application code with the code that is executed during the unit tests.
  3. The modified FlexUnit Ant task results in the `Test-....xml` files that we already got when running the regular FlexUnit, but also in some additional files containing the reusults of the code coverage.

To get this to work, we need to do some things first.

# Step 1: Download FlexUnit with Code Coverage

A guy called Jason developed a modified version of the FlexUnit SWC files. You can get the files along with some description [here](https://code.google.com/p/flexunit-with-code-coverage/). You need to at least download the three SWC files found under &#8220;Downlaods&#8221;. Alternatively you can checkout the code using SVN by entering the following command in your command line:

`<span style="color: #000000;">svn checkout </span><strong style="color: #000000;"><em>http</em></strong><span style="color: #000000;">://flexunit-with-code-coverage.googlecode.com/svn/trunk/ flexunit-with-code-coverage-read-only</span>`

Store the three SWC files in a subfolder of your tools-folder called &#8220;flexcover&#8221; (i.e. C:\tools\flexcover).

# Step 2: Create a new Ant file

Because this step involves modified libraries of FlexUnit, we keep the Ant step for code coverage separated from our main buildfile (`build.xml`) to prevent the libraries from interfering with each other (and also to keep our original buildfile a bit simpler). We then call this script from our main build script.

Create a new file called b`uild.coverage.xml` at the same level as your original buildfile. Fill it with the following base structure:

This script looks pretty similar to our original build script. However, notice these differences:

  1. instead of the Flex Ant tasks that came with our Flex SDK, we use the modified version downloaded in Step 1.
  2. Instead of the original MXMLC Ant task, we create a modified task using taskdef and the modified Ant task.
  3. Instead of the original FlexUnit Ant task we use the modified version downloaded in Step 1.

This should provide us with a scaffolding that we&#8217;re going to fill with some macros and a single target.

# Step 3: Create the macros

To build and execute the `TestRunner.mxml` application we need to create two macros that look almost identical to the ones used to run the unit tests. However, they take into account the features of the modified FlexUnit libraries.

## Build the TestRunner

Add the following macro to the `build.coverage.xml` script.

This macro is identical with the one used in the main build script. But since we have overridden the MXMLC Ant task above, we&#8217;re using the modified MXMLC to build the application.

## Execute the TestRunner

Add the following macro to the `build.coverage.xml` script.

<span style="line-height: 1.5;">This macro is almost identical to the one used in the main build script. However, notice the two additional nodes:</span>

  * `<coverageSource>`
  * `<coverageExclude>`

These are needed to compare the executed code with the whole application code and will result in a coverage report.

# Step 4: Adding to the script

That&#8217;s all. Well almost. What we need to do now is to update our `TestRunner.mxml` with the latest unit tests, compile the TestRunner-application and then execute it with the modified Ant task for FlexUnit. For the first part, we can use the same macro that was already defined in the main build script. For the second and third part we call the macros inside the `build.coverage.xml` file that we just added.

So all we need to do is add the following script to `build.coverage.xml`:

We then only need to call the coverage script by calling the ant file from the main build script. So add the following lines to your `build.xml`:

This will conditionally run our `build.coverage.xml` depending on the value of the environmental variable `code_coverage`.

# Step 5: Test everything out

That&#8217;s it. All you have to do now is run your build.xml from jenkins with `code_coverage `set to true.

&nbsp;

&nbsp;