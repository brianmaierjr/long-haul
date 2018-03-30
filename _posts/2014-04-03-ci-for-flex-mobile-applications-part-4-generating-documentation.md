---
id: 282
title: CI for Flex Mobile Applications – Part 4
date: 2014-04-03T20:21:21+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=282
permalink: /ci-for-flex-mobile-applications-part-4-generating-documentation/
frutiful_posts_template:
  - "2"
  - "2"
categories:
  - Coding
  - Technical
tags:
  - ant
  - as3
  - asdoc
  - continuous integration
  - flex
  - FlexUnit
  - jenkins
  - mobile
series:
  - Continuous Integration for Flex Apps
---
<div class="seriesmeta">
  This entry is part 5 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-66">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Generating Documentation 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

Now that we have compiled, packaged and tested our app, it is high time we create a documentation for our app &#8211; automatically of course. For this step to work you should have commented your classes, functions and variables with the ASDOC syntax. Otherwise, the ASDOC-compiler will not recognize the comments and not be able to produce the documentation.

The good thing is that if you dutifully described your code with ASDOC comments, you get the documentation virtually for free &#8211; and it&#8217;s also **very** similar to compiling the code as we did in [the first part](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-1-compiling-your-code/ "CI for Flex Mobile Applications – Part 1: Compiling your code") of this tutorial, since it&#8217;s only a special way of compiling the code not into a \*.swf or \*.swc file but in a set of HTML documents to put in a directory (or Jenkins in our case). That&#8217;s the reason why this part of the tutorial is the shortest of all.

<!--more-->

# The ASDOC command line tool

The command line syntax of asdoc is very similar to the mxmlc syntax. You can always get this list by typing `asdoc -help list`:

<div id='stb-container-7962' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-7962' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>ASDOC command line arguments</span>
    
    <div id="stb-tool-7962" class="stb-tool">
      <img id="stb-toolimg-7962" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-7962' class='stb-info-body_box stb_body stb-body-box' >
    If you want to know more information about the asdoc command line tool and its options, visit <a title="Using the ASDOC tool" href="http://help.adobe.com/en_US/flex/using/WSd0ded3821e0d52fe1e63e3d11c2f44bc36-7ffa.html" target="_blank">the official documentation</a>.</p> 
    
    <p>
      For general help on commenting code using the ASDOC syntax, visit <a title="ASDoc" href="http://help.adobe.com/en_US/flex/using/WSd0ded3821e0d52fe1e63e3d11c2f44bb7b-7fe7.html" target="_blank">the official documentation</a>.
    </p>
  </div>
</div>

# The ASDOC Ant task

As with the mxmlc compiler, the ant task is very similar to its command line counterpart.

<div id='stb-container-7201' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-7201' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>Using the ASDOC task</span>
    
    <div id="stb-tool-7201" class="stb-tool">
      <img id="stb-toolimg-7201" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-7201' class='stb-info-body_box stb_body stb-body-box' >
    For more information on the ASDOC Ant task, visit <a title="Using the asdoc task" href="http://help.adobe.com/en_US/flex/using/WSda78ed3a750d6b8f4ce729f5121efe6ca1b-8000.html" target="_blank">the official documentation</a>.
  </div>
</div>

# Test everything out

Now let&#8217;s run our build script. If we did everything correct, we should get a nice doc-folder in our target directory containing a bunch of HTML files. Just open index.html to see an overview.

# What we did so far

In this chapter we extended our script to run the ASDOC-compiler, which generates a code documentation in the HTML format instead of a *.swf file.

When you&#8217;re all set, continue to [Part 5: Tipps&Tricks](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-5-tipps-and-tricks/ "CI for Flex Mobile Applications – Part 5: Tipps and Tricks")