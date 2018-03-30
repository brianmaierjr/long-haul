---
id: 114
title: Updating WordPress on a Synology NAS
date: 2014-02-16T11:49:45+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=114
permalink: /updating-wordpress-on-a-synology-nas/
frutiful_posts_template:
  - "2"
categories:
  - Troubleshooting
tags:
  - synology
  - wordpress
---
If you are running WordPress on your own Synology NAS (such as this website is) you may encounter problems when trying to update a plugin, theme or WP itself.If your update process hangs during the &#8220;unpacking&#8221;-step, this may likely have to do with file ownership.

As in my case, I entered my FTP-Credentials correctly and the update process could download the update for a specific plugin. However, the process somehow stopped and never finished (no error, no page update, just somehow stuck in &#8220;unpacking update&#8230;&#8221;).

<a href="http://www.tiefenauer.info/wp-content/uploads/2014/02/wp1.png" rel="lightbox[114]"><img class="alignnone size-medium wp-image-116" src="http://www.tiefenauer.info/wp-content/uploads/2014/02/wp1-300x56.png" alt="wordpress update hangs" width="300" height="56" srcset="http://www.tiefenauer.info/wp-content/uploads/2014/02/wp1-300x56.png 300w, http://www.tiefenauer.info/wp-content/uploads/2014/02/wp1.png 578w" sizes="(max-width: 300px) 100vw, 300px" /></a>

This is how I fixed it:

  * ssh as **root** into your NAS
  * change file-ownership of your WordPress-instance to &#8216;nobody&#8217;:
  
    \[code language=&#8221;bash&#8221;]chown -R nobody:nobody /volume1/web/wordpress[/code\] (or whatever your WP-directory is)

After that, updating anything worked like a charm:

<a href="http://www.tiefenauer.info/wp-content/uploads/2014/02/wp2.png" rel="lightbox[114]"><img src="http://www.tiefenauer.info/wp-content/uploads/2014/02/wp2-300x170.png" alt="wordpress update success" width="300" height="170" /></a>

The problem is with the file/folder owner. By default the web server software uses &#8216;nobody&#8217; as the file/folder owner, when you install wordpress using a network share(like I did) the system assumes resets the name of the file owner to that of the login you used to access the share preventing the web server software making any changes, that&#8217;s the reason why the automatic update feature doesn&#8217;t work, even if you input the correct FTP login information in wordpress.