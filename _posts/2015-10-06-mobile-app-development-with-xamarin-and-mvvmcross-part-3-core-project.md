---
id: 633
title: 'Mobile App Development with Xamarin and MvvmCross &#8211; Part 3: Core project'
date: 2015-10-06T10:18:29+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=633
permalink: /mobile-app-development-with-xamarin-and-mvvmcross-part-3-core-project/
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
  This entry is part 3 of 5 in the series <a href="http://www.tiefenauer.info/series/mobile-app-development-with-xamarin-and-mvvmcross/" class="series-47" title="Mobile App Development with Xamarin and MvvMCross">Mobile App Development with Xamarin and MvvMCross</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-45">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Core project 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this article we are going to add some classes to our PCL project. These classes will contain the business logic for our app.

<!--more-->

# Create new ViewModel

ViewModels are the foundation for MvX-based apps and represent the connection between the views in the UI projects and the business logic. To do their task, ViewModels often rely on the help of services, which contain shared logic between different ViewModels, such as reading and writing from/to a database. Additionally, ViewModels are at the core of navigation: Navigation in MvX is done over ViewModels, not views (we will see that this can be changed by using Storyboards in a later article). For each view in a UI project there is a corresponding ViewModel. MvX connects these two parts over reflection based on the class name. That means that for each view class called MyView.cs there must be a corresponding ViewModel class called MyViewModel.cs, which must inherid from MvxViewModel. in MvX, a view in a UI project can not be used without corresponding ViewModel.

A new ViewModel can be created by creating a class that extends MvxViewModel. This class can hold additional logic, properties and methods as required. The following class is just an example:

# Define app start

You can define as many ViewModels as needed. One specific ViewModel however must be defined as the main ViewModel and serve as central point of entry for the first app start. After adding MvvmCross as NuGet package you should have a file called App.cs in your PCL project. In this class you register the ViewModel used when starting the app as follows:

This will result in MvX selecting MyViewModel.cs as the main ViewModel for the first app start. MvX will load this ViewModel and search for a view called MyView.cs, which must exist in each of the UI projects. Lookup will be done in the MyProject.Droid or MyProject.iOS project, depending on the target platform, but a class with this name must exist, otherways app start will fail. We will see in the following articles, how such a view can be defined in each UI project.

# What we have done so far

In this article we have created our first ViewModel and defined it as the main ViewModel for app starts.