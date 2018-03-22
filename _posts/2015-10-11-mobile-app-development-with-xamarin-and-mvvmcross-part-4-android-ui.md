---
id: 635
title: 'Mobile App Development with Xamarin and MvvmCross &#8211; Part 4: Android UI'
date: 2015-10-11T18:00:30+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=635
permalink: /mobile-app-development-with-xamarin-and-mvvmcross-part-4-android-ui/
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
  This entry is part 4 of 5 in the series <a href="http://www.tiefenauer.info/series/mobile-app-development-with-xamarin-and-mvvmcross/" class="series-47" title="Mobile App Development with Xamarin and MvvMCross">Mobile App Development with Xamarin and MvvMCross</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-38">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Android UI 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this article we are going to create our first Android view. To do this, we will create an AXML file, which will hold the layout of the individual UI components. This AXML file will also create bindings to the ViewModel, so that the view is automatically updated when the data in the ViewModel changes. Additionally, we will create a backing C#-class, which will hold the view logic for our layout.

<!--more-->

# Android view layer

Android separates its view layer into two types of assets:

  * **AXML-Files**, which will define the layout, size and constraints of the individual UI components with an XML-based syntax
  * **Activities**, which load AXML-defined layouts, access the contained UI elements and connect them with the application code

## AXML files

AXML is an XML dialect for files to define both whole views as well as individual, reusable UI components. Android comes with a set of ready-made standard components, which can be extended and combined in order to create new components. Traditionally, AXML files are of static nature, but the contained components can be programmatically changed at runtime e.g. by changing their size, adding or removing components or registering event listeners.

MvX introduces its own tags to include framework functionality such as two-way data binding already in the AXML-layout. However, currently VisualStudio does not support content assist for these tags. To use the tags, their namespace must be imported with an arbitrary name. The following example illustrates using the _MvxItemTemplate_-Tag by including the MvX-namespace under the _local_ prefix.

The following table shows a selection of commonly used MvX-tags in AXML along with a usage example: [table id=2 /] 

# Creating the Activity

In order to use the newly defined AXML-layout we need to create an Activity, which is any class that extends _Android.App.Activity_. The Activity represents the UI logic of the layout and can be used for example to register event handlers. When using MvX, every Activity must be extended from _Cirrious.MvvmCross.Droid.Views.MvxActivity (_which extends _Android.App.Activity_) and follow a strict naming convention to be loaded by MvX when navigating to a ViewModel. MvX will load the Android activity based on its class name. That&#8217;s why a class must be named like the corresponding ViewModel, without the &#8230;_Model_-suffix (e.g. for _MyViewModel.cs_ the corresponding Android activity must be named _MyView.cs_).

In Xamarin/MvX, every displayed view in Android can be created by following three simple steps:

  1. Define the view&#8217;s layout by creating an AXML file. The AXML file syntax is identical with the one of a standard Android application written in Java with the exception of the special MvX tags.
  2. Create an Activity class extending MvxActivity which is annotated with [Activity]. If the view serves as entry point when the app starts, the MainLauncher-attribute must be set to true. This is the case if the view belongs to the ViewModel that was registered with the AppStart (see previous article).
  3. Override the onCreate() function to load the layout when the activity is created.

The following code snipped shows a very basic implementation of MyView.cs, which can be used as view in the Android UI project for the MyViewModel-ViewModel.

<div id='gallery-9' class='gallery galleryid-635 gallery-columns-3 gallery-size-thumbnail'>
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://www.tiefenauer.info/mobile-app-development-with-xamarin-and-mvvmcross-part-4-android-ui/android_view_1/#main'><img width="150" height="150" src="http://www.tiefenauer.info/wp-content/uploads/2015/10/Android_View_1-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-9-694" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-9-694'>
      Step 1: Create AXML file for layout
    </dd>
  </dl>
  
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://www.tiefenauer.info/mobile-app-development-with-xamarin-and-mvvmcross-part-4-android-ui/android_view_2/#main'><img width="150" height="150" src="http://www.tiefenauer.info/wp-content/uploads/2015/10/Android_View_2-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-9-691" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-9-691'>
      Step 2: Create layout using Xamarin toolbox (drag&#038;drop)
    </dd>
  </dl>
  
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://www.tiefenauer.info/mobile-app-development-with-xamarin-and-mvvmcross-part-4-android-ui/android_view_3/#main'><img width="150" height="150" src="http://www.tiefenauer.info/wp-content/uploads/2015/10/Android_View_3-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-9-692" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-9-692'>
      The AXML-representation of the created layout
    </dd>
  </dl>
  
  <br style="clear: both" />
  
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://www.tiefenauer.info/mobile-app-development-with-xamarin-and-mvvmcross-part-4-android-ui/android_view_4/#main'><img width="150" height="150" src="http://www.tiefenauer.info/wp-content/uploads/2015/10/Android_View_4-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-9-693" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-9-693'>
      Step 4: Create Activity as ordinary C#-class
    </dd>
  </dl>
  
  <br style='clear: both' />
</div>

## Additional Views

Any other Android view can be created just the way it was described above. Any activity can have the _MainLauncher_ attribute set to true, whether its ViewModel is registered as main ViewModel upon app start or not. The _MainLauncher_ attribute simply defines that the activity can serve as an entry point (for example when launching from another app via Intent).

# Navigating between views (activities)

As stated before, navigation in MvX happens over ViewModels, not views. This is to ensure the navigation logic has to be implemented only once and is consistent across platforms. A view can be changed by calling _ShowView<ViewModel>(View)_ on the ViewModel. Because the method is protected, it must be wrapped in an _ICommand_-property which is made public. This _ICommand_ property can be used for data binding with MvX (for example upon a click on a UI element) and will be triggered by MvX when the bound event occurs.

MvX uses reflection also for command binding. The ICommand property name must end in &#8230;_Command_ and the bound property in the AXML file must match the name exactly (without the _Command_-suffix). The following example illustrates binding a navigation from _MyViewModel.cs_ to _OtherViewModel.cs_ upon click on a button in _MyViewLayout.axml_.

# What we have done so far

In this chapter we have defined an Android view by defining its layout in AXML and creating the corresponding Activity as a C# class. We have connected some of the displayed data with the data in the ViewModel by using MvX-tags in the layout.