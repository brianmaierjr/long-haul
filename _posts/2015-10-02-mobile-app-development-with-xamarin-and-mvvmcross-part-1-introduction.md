---
id: 629
title: 'Mobile App Development with Xamarin and MvvmCross &#8211; Part 1: Introduction'
date: 2015-10-02T09:04:29+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=629
permalink: /mobile-app-development-with-xamarin-and-mvvmcross-part-1-introduction/
categories:
  - Coding
  - Mobile
tags:
  - Android
  - iOS
  - mobile
  - MvvMCross
  - Storyboard
  - Xamarin
series:
  - Mobile App Development with Xamarin and MvvMCross
---
<div class="seriesmeta">
  This entry is part 1 of 5 in the series <a href="http://www.tiefenauer.info/series/mobile-app-development-with-xamarin-and-mvvmcross/" class="series-47" title="Mobile App Development with Xamarin and MvvMCross">Mobile App Development with Xamarin and MvvMCross</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-80">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Introduction
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this article series I will cover the process of creating a mobile application using [Xamarin](https://xamarin.com/) and MvvMCross (MvX). There is a lot to know about both technologies to get started and neither [Xamarin](https://xamarin.com/) nor MvX provide a level of documentation sufficient to enable a total beginner to build apps efficiently. The goal of this series is to faciliate the entry into topic and to mitigate common problems and pitfalls occurring from things you just have to know.

<!--more-->

The series will consist of the following articles

  * [Part 1: Introduction](http://www.tiefenauer.info/mobile-app-development-with-xamarin-and-mvvmcross-part-1-introduction/) (this article), giving you a quick overview of [Xamarin](https://xamarin.com/) and MvvmCross (and also introduces [Xamarin.Forms](https://xamarin.com/forms) briefly)
  * Part 2: Set up, describing the steps required to get you started
  * Part 3: Core project, describing the steps required to add some classes to your core project
  * Part 4: Android UI, describing how to create a beautiful UI for Android
  * Part 5: iOS UI, describing how to create the corresponding UI for iOS
  * Part 6: iOS UI with Storyboard, describing an alternative was of creating iOS UI with the help of a Storyboard-based project
  * Part 7: Final thoughts, in which we will be wrapping it all up and drawing conclusions

# Xamarin in a nutshell

[Xamarin](https://xamarin.com/) is a commercial product to allow development of cross-platform mobile applications for Android, iOS and Windows Phone (WP8). The app is build using a common set of tools and a single programming language (C#) and runs natively on the target platform. Running natively is a unique feature that sets [Xamarin](https://xamarin.com/) apart from other hybrid solutions such as Ionic or Flex.

There is often confusion about the terms _cross-platform_ and _hybrid_. This is why I&#8217;m gonna explain them briefly:

  * **Hybrid:** A hybrid app can be run on different target platforms. In that respect there&#8217;s no difference to a cross-platform app. However, with hybrid apps usually both code for business logic and code for the UI of this app lie in a single project. Tthere is usually only one code base for the UI, regardless of the target platform. In consequence, this often means that the UI is required to _imitate_ the native look&feel of the target platform, without really running natively on it. JavaScript is often used as a programming language to be run inside a web-container, which in turn is packaged inside an installable app (.apk for Android or .ipa for iOS).
  
    The advantage of this approach is that the UI only needs to be implemented once, which can be a huge productivity boost because most of the code can be shared between platforms.
  
    The downside is that the look&feel can often not live up to the way the user expects it to be, both performance- and appearance-wise. There are often limitations relating to the possibilities for designing the UI.
  
    There are various technologies and programming languages that follow this approach, such as Ionic (JavaScript) or Apache Flex (AS3).
  * **Cross-Platform:** In contrast to hybrid apps, cross-platform apps are specifically designed to be run natively on the target platform. This often results in a core project with a common, shared code containing the business logic and several UI projects, one for each target platform.
  
    The good thing about cross-platform technologies is that the developer can rely on a single technology stack and only has to know one programming language. The end user can&#8217;t tell whether the app was made using standard technologies or programming languages (such as Objective-C for iOS or Java for Android). Because the UI is built for a specific target platform, the app&#8217;s UI looks and feels like it was built exclusively for the target platfrom, running with native performance.
  
    The downside of this approach is that only a part of the code can be shared between platforms. The talk is about 60%-80%, but that heavily depends on the used technology and the type of app you want to build.
  
    Examples for this category of mobile app development are [Xamarin](https://xamarin.com/) (C#) and Appcelerator Titanium (JavaScript). [table id=1 /] 

We will focus on [Xamarin](https://xamarin.com/) as a technology to build apps in the following articles. Xamarin is a commercial product following the cross-platform approach. This means you will be building apps using C# as a programming language and the .NET toolset like VisualStudio (IDE), NuGet (package manager) and NUnit (testing framework).

[Xamarin](https://xamarin.com/) does not dictate the usage of a particular framework. However, because a framework can relieve you of a big part of boilerplate coding, the usage of one is heavily recommended. An example framework for Xamarin is MvvmCross (short: MvX), which propagates the MvvM-Paradigm to the cross-platform development of apps. MvX is not an official product of Xamarin, but has become immensely popular among Xamarin developers. It is described in short in the next chapter.

[Xamarin](https://xamarin.com/) consists mainly of two sub-projects, called Xamarin.Android and Xamarin.iOS. Both projects generally provide an implementation of the native APIs of the target platform, but written in C#. Often, you can find that class and method names of the C# implementations are identical to the ones in the original SDK. This is a huge advantage if you come from one of these technologies and already know the SDK quite well. However, it also means you need to know how to create an app for iOS and/or Android using standard technologies, before you can start with Xamarin.

## Xamarin.Forms

Some time ago, [Xamarin](https://xamarin.com/) started developing its own framework, called [Xamarin.Forms](https://xamarin.com/forms), following a similar, but still different approach. The idea of [Xamarin.Forms](https://xamarin.com/forms) is the same as in hybrid technologies: You only have to write the UI only once. In contrast to other hybrid technologies, the resulting app still runs natively on the target platform, conserving the advantages of a cross-platform solution like performance and look&feel. You can still use a single programming language and a common set of UI elements, which will be transformed to their native counterparts for each platform, making it look like a a traditional Xamarin app (i.e. a traditional native app).

However, this benefit comes at a price, which happens to be the same like in other hybrid technologies: You are limited to what [Xamarin.Forms](https://xamarin.com/forms) gives you when it comes to designing the UI. [Xamarin.Forms](https://xamarin.com/forms) uses only a subset of the [Xamarin.Android](https://developer.xamarin.com/guides/android/)/[Xamarin.iOS](https://developer.xamarin.com/guides/ios/)-API. You can create your UI using elements of the [Xamarin.Forms API](https://developer.xamarin.com/api/root/Xamarin.Forms/), but you&#8217;re somewhat stuck with them. This is no problem as long as your app doesn&#8217;t require a very complex UI or some fancy UI elements which exist only for one of the platforms. However, if you want to use the full scope of what the UI has to offer, you&#8217;re better off with a normal Xamarin app.

[Xamarin.Forms](https://xamarin.com/forms) is built ontop of the [Xamarin](https://xamarin.com/)-Tech-stack and is not to be confused with [Xamarin.Android](https://developer.xamarin.com/guides/android/) or [Xamarin.iOS](https://developer.xamarin.com/guides/ios/). The following table summarizes the differences between Xamarin and Xamarin.Forms. [table id=3 /] 

# MvvmCross in a nutshell

MvvmCross (in short: MvX) is an open source framework, developed specifically for mobile app development with [Xamarin](https://xamarin.com/). The underlying principle for this framework is MvvM, which is used as architectural pattern over all target platforms. To do so, data binding is often as one of the key features of MvX, resulting in an automated update of the UI when there are changes in the model (i.e. within the common part of the application).

MvX relies heavily on coding by convention. This means that in order to use the framework, a deeper knowledge of how to use it is required. This knowledge can often not be gained exploratively, but must be documented somewhere if the user should not be required to dig into the inner workings of the framework. This approach has significant advantages in terms of efficiency: You can develop at a much faster pace, focusing on your business logic, once you have figured out how to use the framework. In contrast, it is often difficult for beginners to get started with a framework following the coding by convention approach, if the steps and features of how to build an app are not carefully described (and for MvX they&#8217;re not IMHO!).

The source code of the framework is open for changes by the community, but in reality its development is heavily driven by Stuart Lodge. Documentation is confined to a few markdown files on GitHub, a blog and a series of videos on YouTube with accompanying sample projects. However, if you want to know more about a specific feature, you are required to watch the whole video and/or download the source code, because the corresponding blog posts are often very short.. The descriptions on GitHub are often not detailed enough to get you started. Stuart uses Stackoverflow for questions and issues.

## Coding by convention

[Coding by conventions](https://en.wikipedia.org/wiki/Convention_over_configuration) (CBC) aims at reducing complexity by hiding a lot of the internals of a system or framework from the user and having him adhere to certain guidelines.  MvX follows this principle for example by having the developer follow some naming guidelines. This is required so that MvX can resolve classes from different projects by [reflection](https://en.wikipedia.org/wiki/Reflection_(computer_programming)). This becomes especially obvious in the following cases (examples):

  * **Views/ViewModels:** Every view called MyView.cs has to be accompanied with a ViewModel called MyViewModel.cs, which must inherit directly or indirectly from MvxViewModel.
  * **Converters**: Converter classes of any kind, which are used by means of the Swiss-Databinding, must have the ValueConverter suffix (i.e. MyDateValueConverter for example) in order to be recognized by MvX as valid converters.

MvX uses reflection a lot. This results in the developer not being completely free as of how to choose class names. On the other hand it also relieves the developer of the struggle of stitching the different parts together &#8211; it is all done automagically by the framework.

Unfortunately, MvvmCross is not terribly well documented (at least I&#8217;m used to a different level of documentation), which is a very bad thing for a CBC-framework. There may be more conventions of this kind that are not listed here or that I don&#8217;t know myself. The thing is: if certain conventions are not or not exactly enough followed, MvX throws an exception which is not always self-explanatory. Often, you are required to use Google or Stackoverflow to find out what you may have done wrong.

# Where to go from here

In this article you have learned about the difference between hybrid and cross-platform applications an got to know Xamarin as an example for building cross-platform applications. You have caught a glimpse of two popular Xamarin frameworks, Xamarin.Forms and MvvmCross. MvvmCross seems to be very popular in the Xamarin community, but is also quite hard to learn, not least because of its inofficial nature and rudimentary documentation. Nevertheless, MvX offers some more possibilities when it comes to building the UI, because it does not limit itself to a subset of UI elements but can make use of the full potenttial of the Xamarin platform.

You are now ready to start building your own Xamarin app with the help of the MvX-Framework.