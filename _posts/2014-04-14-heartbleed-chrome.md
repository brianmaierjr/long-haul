---
id: 395
title: Heartbleed + Chrome
date: 2014-04-14T07:17:18+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=395
permalink: /heartbleed-chrome/
frutiful_posts_template:
  - "2"
categories:
  - Uncategorized
tags:
  - certificate
  - chrome
  - heartbleed
  - OpenSSL
---
# The Solution

Heartbleed has made quite some headlines recently. If you&#8217;re using Chrome as your preferred browser (like me) you should check your settings for the following entry:

<p style="text-align: center;">
  <img alt="" src="http://www.tiefenauer.info/wp-content/uploads/2014/04/433.png" /><br /> <img style="line-height: 1.5;" alt="" src="http://www.tiefenauer.info/wp-content/uploads/2014/04/712.png" /><br /> <img style="line-height: 1.5;" alt="" src="http://www.tiefenauer.info/wp-content/uploads/2014/04/790.png" /><br /> <img style="line-height: 1.5;" alt="" src="http://www.tiefenauer.info/wp-content/uploads/2014/04/201.png" /><br /> <img alt="" src="http://www.tiefenauer.info/wp-content/uploads/2014/04/606.png" />
</p>

# The Problem

Chrome (by default) does not check with the Certificate Authority (CA) if a certificate has been revoked, but uses an own process called CRLSets instead. In short: Google will push a compiled list of revoked certificates to Chrome, so that the browser does not have to contact the CA to check validity. This may be good for performance, but comes with a risk because the list may or may not be complete.

# Background

A lot of website providers that used OpenSSL for encryption have now revoked their certificates (which are used for encryption) and issued new ones, because there might be a chance that their private keys have leaked out. Attackers  having the private key are able to decrypt any past and future traffic and impersonate the service at will, without anyone noticing.

Source: [http://heartbleed.com/](http://heartbleed.com/ "Heartbleed Bug")