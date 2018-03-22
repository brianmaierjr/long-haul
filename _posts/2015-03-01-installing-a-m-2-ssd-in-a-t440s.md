---
id: 538
title: Installing a M.2 SSD in a T440s
date: 2015-03-01T16:47:51+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=538
permalink: /installing-a-m-2-ssd-in-a-t440s/
categories:
  - Technical
tags:
  - lenovo
  - m.2
  - ssd
  - storage
  - t440s
  - upgrade
---
When I recently came to the point of upgrading the storage in my Lenovo T440s, I was looking for ways to do so. Luckliy, the T440s has an additional M.2 slot which allows for inserting various devices, including SSD hard drives. I followed <a title="the instructions from a LaptopMag blog post" href="http://blog.laptopmag.com/install-m2-ssd-lenovo-t440s" target="_blank">the instructions from a LaptopMag blog post</a> for a large part. Since in my case upgrading storage meant replacing the built-in WWAN adapter, I wrote this blog post as an addendum to the one from LaptopMag.

<!--more-->

# Step 1: Choosing the SSD

The first step &#8211; obviously &#8211; was buying an appropriate SSD. M.2 SSDs are pretty new to the game yet and therefore not as widely sold as their predecessors, the mSATA-SSDs. M.2-Disks come in various sizes and form factors, the T440s, however, only supports drives of 42mm width.

<div id='stb-container-8976' class='stb-container-css stb-warning-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/warning.png' /></aside>
  
  <div id='stb-box-8976' class='stb-warning_box stb-box' >
    Make sure you choose the right form factor, since 42mm-drives are the <strong>only</strong> ones supported by the T440s!
  </div>
</div>

After reading various reviews though, it became clear, that <a title="MyDigitalSSD" href="http://mydigitalssd.com/" target="_blank">MyDigitalSSD</a> would be the disk manufacturer of my trust, not only in terms of reputation or disk speed, but also because the prices were really competitive. I finally decided on the <a href="http://mydigitalssd.com/sata-m2-ngff-ssd.php" target="_blank">MyDigitalSSD 256GB Super Boot Drive</a> and ordered it on <a href="http://www.amazon.com/MyDigitalSSD-256GB-Super-Boot-Drive/dp/B00NY4VIPA" target="_blank">Amazon</a>.

## Unboxing

The drive came in a box containing the drive itself along with a tiny screwdriver and a screw (which I didn&#8217;t use since the T440s already has a screw inside holding the WWAN adapter). Thinking I&#8217;ve seen it all, I was still surprised how small and light the drive actually is. Only slightly larger than an ordinary SD card and weighing only a few grams, you will never notice the drive after updating &#8211; apart from the augmented disk space, of course ;-).

Below is a picture of the box the disk came in and a disk ontop of a credit card sized plastic. Unbeliavble how small these things have become&#8230;

<div class="tiled-gallery type-square tiled-gallery-unresized" data-original-width="960" data-carousel-extra='{&quot;blog_id&quot;:1,&quot;permalink&quot;:&quot;http:\/\/www.tiefenauer.info\/installing-a-m-2-ssd-in-a-t440s\/&quot;,&quot;likes_blog_id&quot;:61611150}' itemscope itemtype="http://schema.org/ImageGallery" >
  <div class="gallery-row" style="width: 960px; height: 320px;" data-original-width="960" data-original-height="320" >
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/box/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="551" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/box.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;5&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425219604&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;35&quot;,&quot;iso&quot;:&quot;640&quot;,&quot;shutter_speed&quot;:&quot;0.033333333333333&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="Packaging" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/box-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/box.jpg" src="https://i1.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/box.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Packaging" alt="The unopened box" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          The unopened box
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/unboxing/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="559" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/unboxing.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;5&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425219574&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;35&quot;,&quot;iso&quot;:&quot;640&quot;,&quot;shutter_speed&quot;:&quot;0.033333333333333&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="Unboxing" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/unboxing-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/unboxing.jpg" src="https://i0.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/unboxing.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Unboxing" alt="The opened box and its content" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          The opened box and its content
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/2015-02-20-13-45-17/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="583" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/2015-02-20-13.45.17.jpg" data-orig-size="4128,2322" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;2.2&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;GT-I9505&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1424439917&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;4.2&quot;,&quot;iso&quot;:&quot;320&quot;,&quot;shutter_speed&quot;:&quot;0.066666666666667&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;6&quot;}" data-image-title="Size comparison" data-image-description="<p>M.2 SSD next to a SD card on a credit card for scale</p> " data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/2015-02-20-13.45.17-300x169.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/2015-02-20-13.45.17-1024x576.jpg" src="https://i1.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/2015-02-20-13.45.17.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Size comparison" alt="Size comparison" style="width: 316px; height: 316px;" /> </a>
      </div>
    </div>
  </div>
</div>

# Step 2: Opening the case

<div id='stb-container-7057' class='stb-container-css stb-alert-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/alert.png' /></aside>
  
  <div id='stb-box-7057' class='stb-alert_box stb-box' >
    Before opening the case, make sure you have disabled the internal battery in the BIOS/UEFI and removed the external battery!
  </div>
</div>

To open the case I had to loosen the six screws indicated in [the LaptopMag post](http://blog.laptopmag.com/install-m2-ssd-lenovo-t440s).  Opening the case proved to be much harder than expected (&#8220;if you feel resistance, make sure all screws are completely loose&#8221;). What I didn&#8217;t know is that the screws had tiny nuts on the inside of the case. These are meant to  prevent the screws from falling out of their holes and thus staying together with the bottom part of the case. This is actually a good thing meaning you can&#8217;t really lose the screws. However, should you (like me) still manage to entirely remove the screws, you can/should re-attach their bolts before continuing. After all, you don&#8217;t want to end up missing one of those tiny screws after upgrading your laptop.

<div class="tiled-gallery type-square tiled-gallery-unresized" data-original-width="960" data-carousel-extra='{&quot;blog_id&quot;:1,&quot;permalink&quot;:&quot;http:\/\/www.tiefenauer.info\/installing-a-m-2-ssd-in-a-t440s\/&quot;,&quot;likes_blog_id&quot;:61611150}' itemscope itemtype="http://schema.org/ImageGallery" >
  <div class="gallery-row" style="width: 960px; height: 320px;" data-original-width="960" data-original-height="320" >
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/screw/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="566" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/screw.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;5.6&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425219704&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;55&quot;,&quot;iso&quot;:&quot;400&quot;,&quot;shutter_speed&quot;:&quot;0.016666666666667&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="Screw" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/screw-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/screw.jpg" src="https://i0.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/screw.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Screw" alt="One of the screws to loosen..." style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          One of the screws to loosen&#8230;
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/inside/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="552" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/inside.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;4&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425221026&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;27&quot;,&quot;iso&quot;:&quot;640&quot;,&quot;shutter_speed&quot;:&quot;0.033333333333333&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="Inside" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/inside-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/inside.jpg" src="https://i0.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/inside.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Inside" alt="The inner parts of the T440s" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          The inner parts of the T440s
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/wwan_adapter/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="560" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;4.5&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425221039&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;27&quot;,&quot;iso&quot;:&quot;640&quot;,&quot;shutter_speed&quot;:&quot;0.033333333333333&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="The WWAN adapter" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter.jpg" src="https://i2.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="The WWAN adapter" alt="WWAN adapter next to the WLAN adapter" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          WWAN adapter next to the WLAN adapter
        </div>
      </div>
    </div>
  </div>
</div>

# Step 3: Removing the WWAN adapter and installing the disk

After prying open the case, I first had to remove two cables from the WWAN adapter. Luckily, those were not soldered to the device itself, so that I had no problem removing them using a pair of tweezers. I am not sure what the cables are for, but judging from their color (blue and red) I suspect for some sort of power source (or antenna?). So I covered the ends with duct tape for insulation, and stuck them to the black foil, since I didn&#8217;t want to have loose power chords dangling around on the inside of my beloved T440s. After loosening one final screw and pulling out the WWAN-adapter I had a free M.2 slot. Installing the SSD was a breeze after that, requiring only inserting the disk into the slot and tightening the screw (the SSD is powered by the M.2 slot). That kind of flexibility is one thing I particularily like about Lenovo T-series laptops.

<div class="tiled-gallery type-square tiled-gallery-unresized" data-original-width="960" data-carousel-extra='{&quot;blog_id&quot;:1,&quot;permalink&quot;:&quot;http:\/\/www.tiefenauer.info\/installing-a-m-2-ssd-in-a-t440s\/&quot;,&quot;likes_blog_id&quot;:61611150}' itemscope itemtype="http://schema.org/ImageGallery" >
  <div class="gallery-row" style="width: 960px; height: 320px;" data-original-width="960" data-original-height="320" >
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/installed_disk/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="553" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/installed_disk.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;4&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425221131&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;27&quot;,&quot;iso&quot;:&quot;800&quot;,&quot;shutter_speed&quot;:&quot;0.033333333333333&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="Installed disk" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/installed_disk-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/installed_disk.jpg" src="https://i2.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/installed_disk.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Installed disk" alt="The M.2 SSD in its slot" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          The M.2 SSD in its slot
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/insulation/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="554" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/insulation.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;4.5&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425221316&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;27&quot;,&quot;iso&quot;:&quot;640&quot;,&quot;shutter_speed&quot;:&quot;0.033333333333333&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="Insulation" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/insulation-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/insulation.jpg" src="https://i2.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/insulation.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Insulation" alt="Make sure you insulate the ends of the cables and stick them to the laptop so they don&#039;t hang around freely" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          Make sure you insulate the ends of the cables and stick them to the laptop so they don&#8217;t hang around freely
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/wwan_adapter_removed/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="561" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter_removed.jpg" data-orig-size="720,480" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;4.5&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1425222580&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;27&quot;,&quot;iso&quot;:&quot;320&quot;,&quot;shutter_speed&quot;:&quot;0.033333333333333&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="WWAN adapter" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter_removed-300x200.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter_removed.jpg" src="https://i0.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/wwan_adapter_removed.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="WWAN adapter" alt="The removed WWAN adapter" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          The removed WWAN adapter
        </div>
      </div>
    </div>
  </div>
</div>

# Step 4: Formatting

After screwing the cover back to the laptop I came to restarting the computer and see if things worked as expected. I pushed the power button and&#8230; nothing happened. The screen stayed black and there was no sign of the computer booting up. I double checked the battery, which I had inserted after screwing everything together. After an initial panic attack (short circuit?)  I decided to put the laptop back into the docking station and booting up from there. To my relief, that did the trick and Windows booted normally. After consulting the UEFI one last time, it became clear that the internal battery would be re-enabled automatically after connecting the charger to the laptop. Seems like the laptop can only boot with the internal battery enabled&#8230;

<div id='stb-container-5325' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-5325' class='stb-info_box stb-box' >
    Should your laptop remain dead after upgrading storage, plug in the power chord and try booting again by pressing the power button.
  </div>
</div>

Because the disk is brand new and not formatted for a particular file system, I had to do this myself by opening disk management (see <a href="http://pcsupport.about.com/od/tipstricks/f/open-disk-management.htm" target="_blank">this page </a>for instructions how to do so). There it way, the newly installed SSD. Before formatting I had to choose the partitioning style. I choose GPT and one click and two seconds later I was proud owner of a 512GB SSD T400s laptop.

<div id='stb-container-5141' class='stb-container-css stb-info-container stb-no-caption stb-image-big stb-ltr stb-side-none'>
  <aside class='stb-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside>
  
  <div id='stb-box-5141' class='stb-info_box stb-box' >
    GPT is MBR&#8217;s successor and has many advantages. You should choose GPT over MBR under any circumstances, unless you really know you still need MBR. See <a href="http://www.howtogeek.com/193669/whats-the-difference-between-gpt-and-mbr-when-partitioning-a-drive/" target="_blank">this post</a> for a more detailed explanations.
  </div>
</div>

<div id='gallery-5' class='gallery galleryid-538 gallery-columns-4 gallery-size-thumbnail'>
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/mbr_or_gpt/#main'><img width="150" height="150" src="http://www.tiefenauer.info/wp-content/uploads/2015/03/MBR_or_GPT-150x150.png" class="attachment-thumbnail size-thumbnail" alt="" aria-describedby="gallery-5-555" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-5-555'>
      Choose GPT in any case!
    </dd>
  </dl>
  
  <br style='clear: both' />
</div>

# Step 5: Measuring performance

The first thing you want to do after installing a super-fast SSD is of course measuring its real performance and comparing it the the specs printed onto the packaging. The disk showed up as a 223GB drive in windows, so it is 33GB smaller than advertised (in terms of usable disk space) and almost 15GB smaller than the built in SSD  the T440s came with. Reviewing the photos for this post the reason became obvious immediately: They used a 240GB storage chip (as written on the sticker on the back), and not a 256GB one!

<div id='stb-container-9282' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-9282' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>About gigabytes and gibibits</span>
    
    <div id="stb-tool-9282" class="stb-tool">
      <img id="stb-toolimg-9282" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-9282' class='stb-info-body_box stb_body stb-body-box' >
    Before you start posting comments about the issue: I know that the 256GB on the package are based on measuring using the decimal system. The &#8220;real&#8221; usable disk space is usually measured in binary, meaning the 256 gigabytes (10-based) equal to approximately 238 gibibytes (2-based). I think manufacturers should really start using the binary system to indicate the disk space of their drives, since the discrepancy between the value on the package and the value shown by the operating system only leads to confusion of a lot of buyers.
  </div>
</div>

I am a bit disappointed by the fact that the usable disk space is more than 6 percent smaller than indicated (and almost 13% smaller than printed on the package, taking that value for granted!).

In terms of speed, however, the disk pretty much lived up to the <a href="http://mydigitalssd.com/sata-m2-ngff-ssd.php" target="_blank">official measurement values </a>from the Homepage, performing sligthly better with bigger chunks and a bit slower on smaller chunks. Considering I had a few programs open while conducting the measurements, this drive should be blazing fast when reading and perform very well in most laptops. However, the writing speeds were somewhere around 190MB/s, never reaching the 430mB/s for any chunk size. This is also consistent with the official benchmark values from MyDigitalSSD.

<div class="tiled-gallery type-square tiled-gallery-unresized" data-original-width="960" data-carousel-extra='{&quot;blog_id&quot;:1,&quot;permalink&quot;:&quot;http:\/\/www.tiefenauer.info\/installing-a-m-2-ssd-in-a-t440s\/&quot;,&quot;likes_blog_id&quot;:61611150}' itemscope itemtype="http://schema.org/ImageGallery" >
  <div class="gallery-row" style="width: 960px; height: 320px;" data-original-width="960" data-original-height="320" >
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/performance/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="557" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/performance.png" data-orig-size="406,369" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="performance" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/performance-300x273.png" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/performance.png" src="https://i1.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/performance.png?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="performance" alt="Benchmark results from CrystalMark 3.0.3" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          Benchmark results from CrystalMark 3.0.3
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/performance_lenovo/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="574" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/performance_lenovo.png" data-orig-size="406,369" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Performance comparison" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/performance_lenovo-300x273.png" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/performance_lenovo.png" src="https://i2.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/performance_lenovo.png?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="Performance comparison" alt="The CrystalMark results of the built-in drive that came with the T440s. In my case it&#039;s a Samsung drive (MZ7TD256HAFV-000L9)" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          The CrystalMark results of the built-in drive that came with the T440s. In my case it&#8217;s a Samsung drive (MZ7TD256HAFV-000L9)
        </div>
      </div>
    </div>
    
    <div class="gallery-group" style="width: 320px; height: 320px;" data-original-width="320" data-original-height="320" >
      <div class="tiled-gallery-item" itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="http://www.tiefenauer.info/installing-a-m-2-ssd-in-a-t440s/mydigitalssd_benchmark/#main" border="0" itemprop="url"> 
        
        <meta itemprop="width" content="316" />
        
        <meta itemprop="height" content="316" />
        
        <img data-attachment-id="581" data-orig-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/mydigitalssd_benchmark.jpg" data-orig-size="330,300" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="MyDigitalSSD benchmark results" data-image-description="" data-medium-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/mydigitalssd_benchmark-300x273.jpg" data-large-file="http://www.tiefenauer.info/wp-content/uploads/2015/03/mydigitalssd_benchmark.jpg" src="https://i2.wp.com/www.tiefenauer.info/wp-content/uploads/2015/03/mydigitalssd_benchmark.jpg?w=316&#038;h=316&#038;crop=1" width="316" height="316" data-original-width="316" data-original-height="316" itemprop="http://schema.org/image" title="MyDigitalSSD benchmark results" alt="Official results for the 256GB Super Boot Drive" style="width: 316px; height: 316px;" /> </a> 
        
        <div class="tiled-gallery-caption" itemprop="caption description">
          Official results for the 256GB Super Boot Drive
        </div>
      </div>
    </div>
  </div>
</div>

# Verdict

The Super Boot Drive sure is blazing fast when reading and also quite fast when writing, but never even coming close to the advertised 430MB/s writing speed. I don&#8217;t know why MyDigitalSSD claim such high speeds when they can&#8217;t even prove them in their own benchmarks.

<div id='stb-container-1810' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-1810' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>Update</span>
    
    <div id="stb-tool-1810" class="stb-tool">
      <img id="stb-toolimg-1810" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-1810' class='stb-info-body_box stb_body stb-body-box' >
    I got a response from the manufacturer. The benchmark results are based on <a href="http://www.attotech.com/disk-benchmark/" target="_blank">ATTO</a>, not CrystalDiskMark. Considering the fact that the disk was even faster than advertised (see pictures above) using CrystalDiskMark as a benchmark tool, this disk performs as fast as promised.
  </div>
</div>

On the other hand, the built-in Samsung drive that came with the T440s already seems to be reasonably fast, showing generally more balanced writing values over all chunk sizes than the MyDigitalSSD drive, sometimes even surpassing them. However, when writing small chunks the MyDigitalSSD outperforms the built-in drive.

What strikes me the most is the fact that MyDigitalSSD sell a drive as a 256GB when they evidentially attached a 240GB chip on it. Together with the falsy 10-based disk space (which manufacturers should do away with anyway) this leads to a significantly lower usable storage space than expected.

<div id='stb-container-4734' class='stb-container-css stb-info-container stb-caption stb-collapsible stb-visible stb-image-big stb-ltr'>
  <div id='stb-caption-box-4734' class='stb-info-caption_box stb_caption stb-caption-box' >
    <aside class='stb-caption-icon'><img src='http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/info.png' /></aside><span>Update</span>
    
    <div id="stb-tool-4734" class="stb-tool">
      <img id="stb-toolimg-4734" src="http://www.tiefenauer.info/wp-content/plugins/wp-special-textboxes/themes/stb-metro/minus.png" title="Hide" />
    </div>
  </div>
  
  <div id='stb-body-box-4734' class='stb-info-body_box stb_body stb-body-box' >
    The decreased disk space is the result of a process called <em>overprovisioning</em>, which means a part of the disk is reserved to make up for broken storage cells. According to the manufacturer, this is common across all manufacturers nowadays. I&#8217;m still a bit disappointed thought, because I think when you buy a 256GB disk you should also get 256GB of usable disk space (as was the case with the built-in drive).
  </div>
</div>

All in all, the Super Boot Drive is still an interesting option for people who want to upgrade their notebook storage without adding too much to the weight (and without their wallet losing too much weight 😉 ).

# Sources

<div id="ffs-tabbed-1" class="ffs-tabbed-nav">
  <ul class="resp-tabs-list" data-closed="closed">
    <li>
      Instructions from LaptopMag
    </li>
    <li>
      MyDigitalSSD homepage
    </li>
    <li>
      Drive on Amazon.com
    </li>
    <li>
      Difference between MBR and GPT
    </li>
    <li>
      How to open disk management in windows
    </li>
  </ul>
  
  <div class="resp-tabs-container">
    <div class="fruitful_tab tab-instructions-from-laptopmag">
      <a href="http://blog.laptopmag.com/install-m2-ssd-lenovo-t440s" target="_blank">http://blog.laptopmag.com/install-m2-ssd-lenovo-t440s</a> 
    </div>
    
    <div class="fruitful_tab tab-mydigitalssd-homepage">
      <a href="http://mydigitalssd.com/http://mydigitalssd.com/" target="_blank">http://mydigitalssd.com/http://mydigitalssd.com/</a>
    </div>
    
    <div class="fruitful_tab tab-drive-on-amazon-com">
      <a href="http://www.amazon.com/MyDigitalSSD-256GB-Super-Boot-Drive/dp/B00NY4VIPA" target="_blank">http://www.amazon.com/MyDigitalSSD-256GB-Super-Boot-Drive/dp/B00NY4VIPA</a> 
    </div>
    
    <div class="fruitful_tab tab-difference-between-mbr-and-gpt">
      <a href="http://www.howtogeek.com/193669/whats-the-difference-between-gpt-and-mbr-when-partitioning-a-drive/" target="_blank">http://www.howtogeek.com/193669/whats-the-difference-between-gpt-and-mbr-when-partitioning-a-drive/</a> 
    </div>
    
    <div class="fruitful_tab tab-how-to-open-disk-management-in-windows">
      <a href="http://pcsupport.about.com/od/tipstricks/f/open-disk-management.htm" target="_blank">http://pcsupport.about.com/od/tipstricks/f/open-disk-management.htm</a> 
    </div>
  </div>
</div>

<div class="clearfix">
</div>