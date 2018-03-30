---
id: 606
title: 'Mockito + PowerMock &#8211; Part 2: Using Matchers'
date: 2015-03-29T13:02:39+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=606
permalink: /mockito-powermock-part-2/
categories:
  - Coding
tags:
  - junit
  - mock
  - mocking
  - mockito
  - powermock
series:
  - Mockito
---
<div class="seriesmeta">
  This entry is part 3 of 3 in the series <a href="http://www.tiefenauer.info/series/mockito/" class="series-40" title="Mockito">Mockito</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-99">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Using Matchers 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this chapter you will get to know some advanced techniques of Mockito such as Argument captors, spies, exception handlers and verifying method calls.

<!--more-->

# Simple matchers

## Matchers for class type

If you want to stub out a parameterized method and you want it to return a specific value regardless of the parameter value, you can use the _any()_-Matcher.

## Matcher for object reference

If you want your method to return a value only when being called with a specific object reference as parameter value, you can use the _eq()_-Matcher.

# Using the built-in matchers

<div id='stb-container-4279' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-4279' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>Eclipse autocomplete for Mockito matchers</span>
    
    <div id="stb-tool-4279" class="stb-tool">
      <img id="stb-toolimg-4279" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-4279' class='stb-info-body_box stb_body stb-body-box' >
    If the autocomplete feature in Eclipse does not work with the matchers used by Mockito (any(), eq(), &#8230;), try adding an autoimport reference in your settings (Window > Preferences > Java > Editor > Favorites):</p> 
    
    <p id="aGkReJp">
      <img class="alignnone size-full wp-image-610 " src="http://www.tiefenauer.info/wp-content/uploads/2015/03/img_5517f16d178c3.png" alt="" srcset="http://www.tiefenauer.info/wp-content/uploads/2015/03/img_5517f16d178c3.png 773w, http://www.tiefenauer.info/wp-content/uploads/2015/03/img_5517f16d178c3-300x284.png 300w" sizes="(max-width: 773px) 100vw, 773px" />
    </p>
  </div>
</div>

Mockito comes with a set of built-in matchers. These are basically just syntactic sugar for primitive types and some common complex types as Strings, Lists and other:

  * **Mockito matchers for primitive types**: 
    <pre>anyInt(), anyLong(), anyBoolean(), anyByte(), anyChar(), anyDouble(), anyFloat(), anyShort()</pre>

  * **Mockito matchers for complex types:** 
    <pre>anyString(), anyList()/anyListOf(), anyMap()/anyMapOf(), anySet()/anySetOf(), anyCollection()/anyCollectionOf(), anyVararg()</pre>

These matchers for complex types  are only here for convenience and could also be implemented using the standard syntax. This means the following matchers are identical:

<pre>anyString()
any(String.class)</pre>

# Custom Matchers

Sometimes it may be necessary to create a matcher, that compares objects using a more complex logic than object type, reference or primitive value. Take a method with a parameter of type String for example. You may want the method to return a specific value only when being called with a String of two characters length. You can build a custom matcher which will resolve to true if the parameter meets this criterion. The matcher is used for comparison each time the stubbed method is called.

# Using matchers on methods with multiple parameters

If you want to stub out a method with multiple parameters, make sure you use matchers on either all or none of the parameters. Mixing matched and un-matched parameters does not work and will result in a runtime exception. See the following code as an example:

# What we have done so far

In this chapter you have learned how to use matchers in order to stub methods with one or more parameters. You have also learned how to build custom matchers to validate parameters using a more complex logic.