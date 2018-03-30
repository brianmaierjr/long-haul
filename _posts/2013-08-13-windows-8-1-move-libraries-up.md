---
id: 85
title: 'Windows 8.1: Move Libraries up'
date: 2013-08-13T13:24:25+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=85
permalink: /windows-8-1-move-libraries-up/
cleanretina_sidebarlayout:
  - default
frutiful_posts_template:
  - "2"
categories:
  - Troubleshooting
tags:
  - "8.1"
  - explorer
  - library
  - windows
---
In Windows 8.1 Explorer, the &#8220;Libraries&#8221; node has moved below &#8220;This PC&#8221;. Nobody knows why, but here&#8217;s how to move them up again:

  1. Open Registry: Windows + R: regedit
  2. Edit Key <span style="font-family: Consolas, Monaco, monospace; font-size: 12px; line-height: 18px;">HKEY_CLASSES_ROOT\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}</span>
  3. Change value SortOrderIndex from 0x44 (54) to 0x38 (54)
  4. Done 🙂

&nbsp;