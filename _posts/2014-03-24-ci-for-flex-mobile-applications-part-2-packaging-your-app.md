---
id: 276
title: CI for Flex Mobile Applications – Part 2
date: 2014-03-24T09:50:33+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=276
permalink: /ci-for-flex-mobile-applications-part-2-packaging-your-app/
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
  This entry is part 3 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-39">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Packaging your App
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this part of the tutorial we are going to package the compiled classes together with other external, non-compiling assets (e.g. image, audio, configuration files, &#8230;) to get a package that is ready to be installed on mobile devices such as smartphones or tablets.

If you haven&#8217;t done already, follow the steps described in [the first part of the tutorial](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-1-compiling-your-code/ "CI for Flex Mobile Applications – Part 1: Compiling your code") to get the compiled classes as an *.swf-File.

<!--more-->

# The ADT Tool

ADT (Adobe AIR Developer Tool) is used to package the SWF and other, non-compilable assets together to an executable file. Its command line syntax is pretty straightforward and also consistent with the Ant task we are going to use. Again, for completness here&#8217;s the command line syntax (also available by typing `adt -help` from the command line):

<span style="line-height: 1.5;">

<div id='stb-container-4914' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-4914' class='stb-info_box stb-box' >
    If you want to know more about the ADT command line syntax, have a look at the </span><a style="line-height: 1.5;" title="Adobe AIR * AIR Developer Tool (ADT)" href="http://help.adobe.com/en_US/air/build/WS5b3ccc516d4fbf351e63e3d118666ade46-7fd9.html">official documentation</a><span style="line-height: 1.5;">.</div></div></span></p> 
    
    <h1>
      Packaging for development or for release
    </h1>
    
    <p>
      If you want to test your application on individual devices before releasing them in the AppStore or the PlayStore, you can create an ad-hoc IPA file resp. a devloper version of your APK. This file can be installed on a limited set of devices for test purposes, without having the user visit the App- or PlayStore.
    </p>
    
    <p>
      If you want to package your app for public release in one of the stores, you create an release version of your IPA respectively a release version of your APK. The only difference in the Build script is that you&#8217;ll use different certificates for the two types. Additionally, you also need a separate provisioning profiles (<code>*.mobileprovision-</code>Files) to install application on files without having them released in the AppStore.
    </p>
    
    <p>
      In this tutorial we assume you want a developer version of your app for installation on single devices. If you plan to build for release, simply  set up a new job or script which packages the files for release in the AppStore resp. PlayStore, just replace the paramters values for <code>OUTPUT.keystore.android</code>  and <code>OUTPUT.keystore.ios</code> in the <code>build.properties</code> file so that they point to the release certificates/provisioning profile.
    </p>
    
    <p>
      You could also add new variables for release parameters (e.g. <code>OUTPUT.keystore.ios.release</code>) so you can keep both developer and release values. Or you could have separate <code>build.properties</code> files for developer-builds and release-builds. Whatever approach you may take, just make sure you don&#8217;t forget to update the Passwords in the <code>build.properties</code> file and also set the path to the provisioning profile correctly.
    </p>
    
    <h1>
      Step 1: Implementing the Ant task to package for Android
    </h1>
    
    <p>
      Unfortunately, there is no Ant task for the ADT command. But that&#8217;s not a problem, since we can call any executable file with Ant&#8217;s built-in <code>&lt;exec&gt;</code>-task. That&#8217;s the approach we are going to use to call our ADT executable, which makes the Ant target for this step syntactically identical to its command-line counterpart.
    </p>
    
    <p>
      Again, to give you a rough start, here&#8217;s an Ant script to include in your build script. Just add any other assets folders you may have (and of course make sure the variables exist in your <em>build.properties</em> file and are correctly set).
    </p>
    
    <h1>
      Step 2: Implementing the Ant task to package for iOS
    </h1>
    
    <p>
      This step is more or less the same as for Android.  The main difference is the different variable values for the certificates in the <code>build.properties</code> file (see above) as well as a <code>-provisioning-profile</code> parameter pointing to the <code>*.mobileprovision</code> file , which is only needed when packaging for iOS.
    </p>
    
    <h1>
      Step 3: Test everything out
    </h1>
    
    <p>
      As alway, let&#8217;s run our script to see if we get an APK and an IPA file. If you did everything correctly, you should have  two Apps in your target folder that are ready to be installed (more about how to set up links for test users to downlad and installs these files under Tipps and Tricks).
    </p>
    
    <div id='stb-container-2073' class='stb-container-css stb-warning-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
      <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/warning.png' /></aside>
      
      <div id='stb-box-2073' class='stb-warning_box stb-box' >
        Be aware: The packaging process for iOS file takes significantly longer than for Android (up to 20 minutes or even more, depending on the size of your app), so don&#8217;t worry, if your job keeps hanging at &#8220;Packaging for iOS&#8230;&#8221; for a while.
      </div>
    </div>
    
    <h1>
      What we did so far
    </h1>
    
    <p>
      In this chapter we extended our build script to package our compiled classes together with other assets into an executable file suitable for installation on Android or iOS devices.
    </p>
    
    <p>
      When you&#8217;re all set, continue with <a title="CI for Flex Mobile Applications – Part 3: Performing Unit Tests" href="http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-3-performing-unit-tests/">Part 3: Performing Unit Tests</a>.
    </p>