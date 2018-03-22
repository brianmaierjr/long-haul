---
id: 107
title: Chrome for high-dpi devices
date: 2013-12-22T11:04:21+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=107
permalink: /chrome-for-high-dpi-devices/
cleanretina_sidebarlayout:
  - default
frutiful_posts_template:
  - "2"
categories:
  - Troubleshooting
tags:
  - chrome
  - high-dpi
  - resolution
---
Just bought a new laptop with a screen resolution of 1920&#215;1080 (Full-HD). Unfortunately, Chrome is currently not optimized for screen resolutions like this on comparatively small screens like mine (14&#8243;), meaning that the UI Components (tabs, navigation buttons, bookmark bar items, &#8230;) are tiny and barely readable. [Similar issues](http://support.apple.com/kb/ht5266) came up when Apple launched their MacBook series with Retina display: Some apps were simply not optimzied for this pixel density.

Now that more and more laptops are already shipped with screens providing Full-HD resolution even at very small screens, Windows users begin noticing the same effects.

To fix the issue in my specific case for Chrome I had the following choices:

  1. Change the overall DPI-scaling for Windows (see [here](https://pattersonsupport.custhelp.com/app/answers/detail/a_id/13103/~/how-to-change-dpi-settings-in-windows-7) on how it&#8217;s done). Since I have the laptop in a docking station with external displays at home, this was not an option for me, because I would have to readjust the settings everytime I switch from working on the laptop display to the external display and vice versa.
  2. Change the screen resolution. Since this would result in everything getting bigger (not just the Chrome UI components), this was not an option. After all I want to make use of the high resolution capabilities of my laptop screen and Windows itself looked just fine.
  3. Enable Hight-DPI support for chrome. To do thiss folow these steps: 
      1. Enter chrome://flags in your URL bar
      2. Search for &#8220;high-dpi-suppor&#8221; to jump to the right setting quickly
      3. Set HiDPI-Support to &#8220;Enabled&#8221;
  
        ![](http://www.tiefenauer.info/wp-content/uploads/2014/02/710.png)
  4. Change the DPI-Scaling setting just for chrome and adjusting the content display configuration. To do this follow these steps: 
      1. Find the Chrome executable in your programs folder
      2. Right click and go to the &#8220;Compatibility&#8221; tab, checking the checkbox saying &#8220;Disable display scaling on high DPI setting&#8221;
      3. Open Chrome and type &#8220;chrome://flags&#8221;
      4. Find (CTRL + F) &#8220;#touch-optimized-ui&#8221;, make sure that it is set to &#8220;Enabled&#8221;. This will result in the browser being displayed in a manner optimized for touch devices like tablets. 
          1. ![](http://www.tiefenauer.info/wp-content/uploads/2014/02/626.png)
      5. If you want you can adjust the zoom factor used for displaying web content generally by going to &#8220;Settings&#8221; > &#8220;Advanced Settings&#8221; > &#8220;Page Zoom&#8221;. This will result in all web content being displayed larger.

Unfortunately, even though the last solution proved to be the best for me, it is still only a workaround. The downside is that even if I can get the web content to being displayed reasonably on my laptop screen, it does not look good on external displays. I have a touch-optimized Chrome even when working on the external display. This results in the tab-bar, navigation bar and bookmark bar being much thicker than normal and hence looking unnatural big and taking away space to show HTML content.

It is desirable that Google adjusts its famous browser to support high-res screens ASAP. After all, Google has a notion of being innovative and alway on the bleeding edge with its browser 😉