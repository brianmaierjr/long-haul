---
id: 165
title: 'CI for Flex Mobile Applications &#8211; Part 0'
date: 2014-03-04T21:22:35+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=165
permalink: /ci-for-flex-mobile-applications-part-0-the-setup/
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
  This entry is part 1 of 9 in the series <a href="http://www.tiefenauer.info/series/flex-ci/" class="series-35" title="Continuous Integration for Flex Apps">Continuous Integration for Flex Apps</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-72">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      The setup 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

This is the first in a series of posts where I&#8217;ll describe the process of setting up a Continuous Integration process to build a mobile app created with Flex. I will use Jenkins as a CI server and ANT for my build scripts.

This first article is about getting started and setting up the right tools.

<!--more-->

# Getting started

Before you get started you should make sure you have the following ready:

  * a server running Windows that you have administrator rights to and that you can access over your local network (or over the internet, if you prefer). **It is important that your server runs on Windows, since Adobe has abandoned Linux support some time ago.** An old PC will do for most cases, although the build process can get quire ressource intensive, especially when having multiple jobs. I used my old P4 with 1GB Ram and 2.53GHz for it, which was just enough.
  * your Code hosted on Github. The steps in this tutorial assume you have your code on GitHub, but you can also host your code on your own Git server. The steps should be similar.
  * An Android certificate in the `*.p12` format.
  * An iOS development certificate in the `*.p12` format
  * An iOS mobile provisioning profile in the `*.mobileprovision` format

# Tools used in this tutorial

To accomplish what is described in the following articles you will need to install the following tools on your server.  I won&#8217;t go through the process of installing the tools. Please refer to the official documentation if you need further help with the installation. Make sure you download the latest version in each case (for Flex it is 4.12.0 and for AIR 4.0 as of the time of this writing).

  * **Apache Flex SDK**: You need to download the SDK in the version you built your app with on your local machine. If you have multiple apps with different versions of Flex, you need to have a copy  of each version in separate folders (see description below for a proposed folder structure). The easiest way to do this is to use the Flex Installer, which lets you select the AIR version you wish to use (see next point).
  
    <a title="Apache Flex" href="http://flex.apache.org" target="_blank">http://flex.apache.org</a>
  * **Adobe AIR SDK**: You need to have the AIR ADK in the version you want to build your app with (generally the newest version). As stated above, the easiest way to get it is downloading Flex with the installer available at the Apache Flex homepage. However, should you wish to install the AIR SDK over an existing copy of the Flex SDK (e.g. if you want to build the bleeding edge version of the SDK manually or you have a very old version of Flex, which is not in available for download in the Flex Installer), you can get it from Adobe under the link below. To install the AIR SDK simply unzip the contents of the downloaded ZIP-file into the base folder of your Flex SDK. If you combine the same Flex version with different AIR versions, you need a separate folder for each combination.
  
    <a title="Adobe AIR SDK" href="http://www.adobe.com/devnet/air/air-sdk-download.html " target="_blank">http://www.adobe.com/devnet/air/air-sdk-download.html </a>
  * **Jenkins**: Jenkins is a CI server which will run all the automated tasks we are going to create later.
  
    <a title="Jenkins CI" href="http://www.jenkins-ci.org/" target="_blank">http://www.jenkins-ci.org/</a>
  * **ant**: We will use ANT as the scripting language to describe the tasks needed to run the automated tasks.
  
    <a title="Apache ANT" href="http://ant.apache.org/" target="_blank">http://ant.apache.org/</a>
  * **ant-contrib**: Some steps described later will need the support of some extensions to ANT that are included in ant-contrib.
  
    <a title="ant-contrib" href="http://ant-contrib.sourceforge.net/" target="_blank">http://ant-contrib.sourceforge.net/</a>
  * **Java JDK**: Although a JRE (Java Runtime Environment) would be sufficient I recommend installing the JDK on a server since it contains additional tools you may or may not need and includes the JRE.
  
    [http://www.oracle.com/technetwork/java/javase/downloads/index.html](http://www.oracle.com/technetwork/java/javase/downloads/index.html "Java JDK")
  * **Git client:** We will need this client to check out your code from Github and also check out some other projects we are going to need. Make sure you install the client following the [instructions from Github](https://help.github.com/articles/set-up-git). You should generate and add your keys to your Github account in order for Jenkins to check out code.
  
    [http://www.git-scm.com/](http://www.git-scm.com/ "Git SCM")

<div id='stb-container-5084' class='stb-container-css stb-alert-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/alert.png' /></aside>
  
  <div id='stb-box-5084' class='stb-alert_box stb-box' >
    If you didn&#8217;t use the Flex installer to download the Flex and AIR SDK, make sure you select the Original SDK without the new compiler, since the new Falcon compiler does not support MXML files, which are used by Flex!
  </div>
</div>

# Step 1: Setting up the server

Your CI server **must run on Windows** since Adobe AIR is not supported on Linux anymore. Although running the scripts on a Unix server may work for Android deploys to some extent, **you will not be able to release iOS-Versions of your app under Linux**.

## <span style="line-height: 1.3;">Folder structure</span>

I recommend the following folder structure. Of course you are free to install the tools in the locations of your choice, but the rest of this tutorial relies on the files lying in the following folders:

  * Root folder (in my case it&#8217;s the D:/ drive) 
      * jenkins (this folder contains the Jenkins installation and nothing else)
      * sdk (this folder will host any SDKs you have on your machine, including Flex SDKs) 
          * flex (sub-folder for the different Flex/AIR-SDKs 
              * 4.11.0_AIR4.0
              * 4.11.0_AIR3.9
              * &#8230; (one folder for each Flex/AIR combination
          * &#8230; (any other SDKs you may have, e.g. in case you are building native Android applications on the same server)
      * tools 
          * ant (your installation of Ant, including ant-contrib)
          * &#8230; (other tools you may have, such as Maven, which is not needed in this tutorial)
      * cert (this folder contains all the certificate and mobileprovisioning profiles)

Please note the naming pattern for the Flex-SDK folders. It is always build up as

`Flex-Version + "_AIR" + AIR-Version`

This is a convention I have come to use  which lets me build my app using different versions of Flex or AIR with the same job, without having separate build scripts or different jobs.

## <span style="line-height: 1.3;">Setting the paths</span>

After you have installed the tools, you need to set some environment variables on your machine. This step is not explicitly required to run a build script with jenkins since Jenkins comes with the option to define the paths directly over the web interface.  However, you may want to test your script on your local machine before uploading it to GitHub or make the tools globally accessible for any other tool you might want. For this you need to set the following environment variables to make sure your scripts will find the executables for each tool:

  * `%ANT_HOME%`: path to your ant installation folder (e.g. `D:\tools\ant`)
  * `%JAVA_HOME%`: path to your JDK installation folder (e.g. `C:\Program Files (x86)\Java\jdk1.8.0`)
  * `%GIT_HOME%`: path to your Git installation folder (e.g. `C:\Program Files (x86)\Git`)
  * `%HOME%`: path to the directory, where you have your`.ssh`-Folder (usually your user home path, e.g. `C:\Users\Daniel`)

Next: add the following paths to your system environmental variables:

`%ANT_HOME%\bin;%JAVA_HOME%\bin;%GIT_HOME%\bin`

# Step 2: Installing Jenkins

This should also not be a problem since Jenkins comes with its own installer. Just make sure you install it as a service (which should be done automatically on Windows) so you don&#8217;t have to start it manually each time you restart your server. Install Jenkins into the directory specified above.

## Plugins

Jenkins should be able to run the ANT-scripts without the need of additional plugins. However, for convenience purposes I recommend the installation of the following plugins (if not installed by default):

  * <a title="Jenkins Ant Plugin" href="https://wiki.jenkins-ci.org/display/JENKINS/Ant+Plugin" target="_blank">Ant plugin</a>
  * <a title="Jenkins GitHub plugin" href="https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin" target="_blank">GitHub plugin</a>
  * <a title="Jenkins Git plugin" href="https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin" target="_blank"><span style="line-height: 1.5;">Git Plugin</span></a><span style="line-height: 1.5;"> if you host your code on your own server</span>
  * <a title="Jenkins FTP-Publisher plugin" href="https://wiki.jenkins-ci.org/display/JENKINS/FTP-Publisher+Plugin" target="_blank">FTP-publisher plugin</a>
  * <a title="Jenkins Javadoc plugin" href="https://wiki.jenkins-ci.org/display/JENKINS/Javadoc+Plugin" target="_blank">Javadoc plugin</a>
  * <a title="Jenkins GreenBalls plugin" href="https://wiki.jenkins-ci.org/display/JENKINS/Green+Balls" target="_blank">Green Balls</a> and <a title="Jenkins ChuckNorris plugin" href="https://wiki.jenkins-ci.org/display/JENKINS/ChuckNorris+Plugin" target="_blank">ChuckNorris</a> plugin 🙂

## Configuring Jenkins

<span style="font-family: 'Source Sans Pro', Helvetica, sans-serif; font-size: 16px; line-height: 1.5;">Your Jenkins Server should be accessible under its url (<em>http://YourServerName:8080</em>). After you installed the plugins, some minimal configuration is neccessary to get started. Go to Jenkins > Manage Jenkins > Configure System.</span>

### Configuring Git

For Jenkins to be able to check out your code, it must know where your Git client is located. For this we have to specify a Git installation with the path to the executable.

<img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/948.png" alt="" />

Unter the section _Git_ enter the full path to your _git.exe_:

<img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/320.png" alt="" />

### Jenkins environment variables

Next, you need to set two environmental variables which will be available in any job:

  * _sdk_dir_: This variable specifies the directory, where Jenkins will look for Flex SDKs
  * _cert_dir_: This variable specifies the directory, where Jenkins will look for certificates or provisioning profiles.

<img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/466.png" alt="" />

It is also possible to set it individually for each job (read below where we set up the job parameters), but since it is unlikely that you have different locations for your SDK, this doesn&#8217;t make much sense.

<span style="line-height: 1.5;">That&#8217;s it. That should be enough for jenkins to get ready and check out your code.</span>

# Step 3: Preparing the job

To run the whole CI process we need to create a new job in Jenkins. You can easily do this from the start page of Jenkins by .

<img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/721.png" alt="" />

Next, choose a name for your project. Any name will do. Just make sure you selected &#8220;Build a free-style software project&#8221; as your option and then click OK.

<img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/790.png" alt="" />

This will take you to the job configuration page, where we will set some parameters used by our job and/or build script.

## Job parameters

Since we&#8217;re building a GitHub project, enter the URL (the one you would use for cloning with your client) into the field provided:

<img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/817.png" alt="" />

I recommend using a parameterized job with the following parameters. You can do this by checking the following parameter in your job configuration on Jenkins.

<img class="aligncenter" style="line-height: 1.5;" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/687.png" alt="" />

This will allow us to run certain steps conditionally by querying the environmental parameters in the script file. Like this we can specify the steps being executed in each run or just use the defaults.  This makes our job extremely flexible and easy to test, since you may not want to run the whole script if you only made changes to a single step. I found the following parameters to be useful:

  * _flex_version_ (choice parameter): Prepare a list of Flex versions available on your server (in the C:\tools\sdk\flex directory). Make sure you don&#8217;t have any typos here and that only versions are listed that are actually installed on your machine since the build script we are going to build relies on the SDK versions lying in folders following a specific naming pattern (see above).
  
    ![](http://www.tiefenauer.info/wp-content/uploads/2014/03/977.png)
  * _air_version_ (choice parameter): Likewise, prepare a list of AIR versions that you have the SDK of
  
    ![](http://www.tiefenauer.info/wp-content/uploads/2014/03/437.png)
  * _generate_asdoc_ (boolean parameter): A parameter to specify whether the ASDOC should be built or not
  
    ![](http://www.tiefenauer.info/wp-content/uploads/2014/03/970.png)
  * _run_unittests_ (boolean parameter): A parameter to specify whether the FlexUnit-Tests should be run or not
  
    ![](http://www.tiefenauer.info/wp-content/uploads/2014/03/266.png)
  * _package_ipa_ (boolean parameter): Whether an IPA-file should be created for installation on iOS-Devices (this comes in handy if you just want to test your job quickly, because this step requires by far the most time).
  
    ![](http://www.tiefenauer.info/wp-content/uploads/2014/03/737.png)
  * _package_apk_ (boolean parameter): Whether an APK-File should be created for installation on Android-Devices (you can check this to see if your package-task is generally set up correctly, since packaging an APK is much faster than packaging an IPA and the differences in the script are only minimal).
  
    ![](http://www.tiefenauer.info/wp-content/uploads/2014/03/394.png)
  * _output_dir_ (Text parameter): Where the artifacts (SWF File, APK/IPA-File, Documentation, Test Report, &#8230;) should be written to. All files will be inside this directory or a subfolder of it.
  
    ![](http://www.tiefenauer.info/wp-content/uploads/2014/03/858.png)

## Source Code Management

<span style="line-height: 1.5;">Under &#8220;Source Code Management&#8221; and &#8220;Build Triggers&#8221; set checkboxes as follows. You can leave away the credentials, since you stored your credentials within your Git authentication agent. If you created your keys, added them to your GitHub project and were able to check out your source code using the Git client on your server, checkout should also work when checking out with Jenkins since Jenkins will use the same client.</span>

![](http://www.tiefenauer.info/wp-content/uploads/2014/04/270.png)

## Our first build step

<span style="line-height: 1.5;">As a final step in this first part you have to add &#8220;Invoke Ant&#8221; as a build step:</span><img style="line-height: 1.5;" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/838.png" alt="" />

We are  goint to add more steps later. This first steps just makes sure our build.xml build script is going to be executed by Jenkins.

After all is set, save your changes and you&#8217;ll have your build job ready for execution &#8211; almost. Since we don&#8217;t have a build script yet, the build step &#8220;Invoke Ant&#8221; will fail, because it will not find a build script ready for execution. So let&#8217;s get this done quickly.

## Preparing the build script

By default, Ant will look for a file called _build.xml_ in the root folder. Our build script will continue of this file and two more parts. You also need to place two files into the source directory of your codebase

  * **build.xml**: This is the main script-file containing the different ANT targets (compilation, packaging, testing, documentation, &#8230;). Each target will be explained in the following chapters. To get started, I&#8217;ll provide you with a scaffolding, which will do nothing excep print out some information.
  * **build.properties**: This separate file contains platform specific properties that can be used to configure the script-file mentioned above. The file contains for example all the platform and project specific attributes and will be loaded by the build-script and is a simple way of externalizing variable values that are used in the build script. If the build-script does not contain any project specific attributes, you can re-use the _build.xml_ for any project you have, simply by replacing the _build.properties_-file with another version containing the appropriate values.
  * **build.init.xml:** To make the main build file a bit more readable, I outsourced the script part for initialization (run at the beginning of the script) to a separate file.

Below you&#8217;ll find a scaffolding of the _build.xml_ and the _build.init.xml_ together with a _build.properties_ file where you only have to fill in/change your server specific data. We will expand thescaffolding in the following steps.

<span style="line-height: 1.5;"></span>

<div id='stb-container-7479' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-7479' class='stb-info_box stb-box' >
    You should adjust at least the following parameters:</p> 
    
    <ul>
      <li>
        <code>META.name</code>: Name of your project (can be any value)
      </li>
      <li>
        <code>META.author.name</code>: Your name
      </li>
      <li>
        <code>META.author.email</code>: Your e-mail address
      </li>
      <li>
        <code>META.copyright</code>: Any copyright information
      </li>
      <li>
        <code>OUTPUT.name.android</code>: Name of your APK file (should not contain spaces or extra characters)
      </li>
      <li>
        <code>OUTPUT.name.ios</code>: Name of your IPA file (should not contain spaces or extra characters)
      </li>
      <li>
        <code>PROJECT.app.name</code>: Name of your app (must correspond with the *.mxml file in the main source folder)
      </li>
    </ul>
  </div>
</div>

After you created the files locally, don&#8217;t forget to add and push them to your GitHub repository project.

# Step 4: Test everything out

## Checking the paths

To check whether your paths are correctly set, open a command line and type the following commands:

`<img src="http://www.tiefenauer.info/wp-content/uploads/2014/03/157.png" alt="" />`

This should produce some output as seen in the screenshot above. If you get an error saying Windows can&#8217;t find the command, you have to check your paths.

<span style="line-height: 1.5;">

<div id='stb-container-5971' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-5971' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>Setting environment variables in Windows</span>
    
    <div id="stb-tool-5971" class="stb-tool">
      <img id="stb-toolimg-5971" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-5971' class='stb-info-body_box stb_body stb-body-box' >
    Windows may require you to log off and on again in order for the environment variables to become active.
  </div>
</div></span>

<div id='stb-container-6726' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-6726' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>Setting an environmental Variable for Flex</span>
    
    <div id="stb-tool-6726" class="stb-tool">
      <img id="stb-toolimg-6726" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-6726' class='stb-info-body_box stb_body stb-body-box' >
    You can set an environment variable pointing to the root directory of a Flex distribution if you like. Just make sure you add the %Flex_HOME%\bin to the path as descripbed above. That way, you will be able to run any command line tools that come with Flex/AIR (such as the MXMLC-Compiler, which is used in the next chapter) directly without specifying the full path to the executable. However, this is optional, since we will be using Ant scripts rather than shell scripts.
  </div>
</div>

## Checking your Git client by cloning your repository

To check if your Git client is all set up, you should try and check out your project to some arbitrary folder to see if this works. If it doesn&#8217;t, it won&#8217;t work with Jenkins either! If it works, you can delete the newly created folder with the checked out code immediately afterwards, because the cloning/pulling will be part of the Jenkins job afterwards.

<div id='stb-container-7353' class='stb-container-css stb-alert-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/alert.png' /></aside>
  
  <div id='stb-box-7353' class='stb-alert_box stb-box' >
    You can&#8217;t continue unless your paths are correct, since Jenkins needs to find the executables for each tool and be able to check out your code!
  </div>
</div>

## Running your Jenkins job for the first time

To see if we are ready to continue with the actual tasks (i.e. the build script) just run the job by selecting it from the list on the home page and click &#8220;Build with parameters&#8221;. This will bring you to the mask where you can set the parameters as defined in the job configuration page previously. The first value is selected by default, so make sure the most recent Flex/AIR version is on top of your list in the job configuration page.

<img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/03/568.png" alt="" /><img class="aligncenter" src="http://www.tiefenauer.info/wp-content/uploads/2014/04/617.png" alt="" />

If everything works out as expected, you should get a green ball (or a blue one, if you haven&#8217;t installed the GreenBalls plugin) which means everything is ok. We haven&#8217;t done anything useful to the code yet, but that&#8217;s part of the next chapter.

# What we have done so far

In this part of the tutorial, we have installed the tools required for building our app on a Windows server. We also have set up Jenkins as our CI server and created a parameterized job, whose main part consists of executing the _build.xml_ build script which we created as a stub and which is on our GitHub repository.

If you&#8217;re all set, continue with [Part 1: Compiling your code](http://www.tiefenauer.info/ci-for-flex-mobile-applications-part-1-compiling-your-code/ "CI for Flex Mobile Applications – Part 1: Compiling your code").