---
title: Bye bye, Wordpress. Hello Jekyll!
layout: post
---
I have hosted my personal blog on my beloved [Synology 109+ NAS](https://www.synology.com/de-de/support/download/DS109+#utilities) for a long time. The device is quite old and I has been running 24/7 for many years now. Unfortunately, due to its mature age, the performance is not the best anymore, especially considering the blog ran on Wordpress using PHP and a MySQL-DB. All the various plugins (and PHP's hunger for CPU and memory) took their toll on the performance - resulting in poor access times on the blog.

<figure>
	<img src="{{ '/assets/img/posts/synology_109_nas.jpg' | prepend: site.baseurl }}" alt=""> 
	<figcaption>My devoted workhorse which has been hosting my blog until now...</figcaption>
</figure>

Additionally Synology has stopped developping software updates for my NAS. It hasn't received any major update for a long time and still runs DiskStation 4.2, which includes an outdated PHP version. 

# Exit Wordpress

All this hasn't been much of a problem for me, since this blog has only got small attention (although I did receive some comments or E-Mails from all around the world). Until recently, when warnings started to pile up in the Wordpress Admin-Dashboard, pushing me to update to the newest PHP version. I wasn't even able to install or upgrade certain plugins anymore since they require a higher version of PHP. Since I don't want to update it manually via CLI and run into compatibility problems with Synology's OS or MySQL I decided for a radical step and migrate everything to a new host. 

Since I didn't find any solutions for free Wordpress Hosting that met my requirements I looked around for something simpler, less resource hungry, without a zillion plugins. Something lightweight and sleek. At the same time it should support some key features that I often use:

- Syntax highlighting for various languages
- support for LaTeX
- support for advanced text formatting
- customizable design (without having to handcraft everything)
- open and extendable (to some point)
- Possibility to write online or offline

And to make the search harder, it all should be free (as hosting on my own NAS is). And yeah, the page speed should also be higher. Dear Santa Clause...

# Enter Jekyll

And so I decided to host my blog on GitHub Pages which uses Jekyll. [Jekyll](https://jekyllrb.com/) is a static site generator without need for a database. Your blog can easily be written in Markdown which are then compiled into static HTML pages. And since all the files reside in a normal GitHub repository, I don't have to worry about things like backup or versioning anymore. I can even apply the same workflow for blogging like I apply for coding (or as Tom Preston-Warner expressed it: [Blogging Like a Hacker](http://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html)). The few dynamic features I used, like comments, can easily be replaced by third-party services like [Disqus](disqus.com). Having never used Jekyll before, I found [this tutorial](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/) insightful. I don't have any long-term experience yet. Time will show how it all turns out, but what I have seen so far looks promising.

# Migrating from WP to GH Pages
Migration is never an easy task, especially considering all the assets (text, images, code blocks, CSS,...). So I tried to automate as much as possible. Jekyll is really trying to ease the pain of migrating by providing a [wide range of available importers](http://import.jekyllrb.com/). Unfortunately, the provided Wordpress-Importer was only able to generate HTML files. And it only imports posts and pages, no assets!

Luckily I found a [WP plugin](https://github.com/benbalter/wordpress-to-jekyll-exporter) which did a fantastic job of converting all my posts and pages to Markdown files (including all the images in them). Unfortunately, the images are linked with their absolute paths (i.e. an URL pointing to the old location of the image) and the pages do not always look as expected when displayed in the new blog (which is not neccessarily the plugin's fault). So there still is a lot of work do be done by hand. But at least I was able to move moste of the content in one go without major hiccups.

Next step was to choose the design. I was looking for something sleek and minimal. Luckily, Jekyll is themeable and there are a [lot of readily available themes](http://jekyllthemes.org/) out there. I went for the [Long-Haul](https://github.com/brianmaierjr/long-haul) theme by Brian Maier Jr., which deemed to be a goot compromise between focus on the content while still being visually appealing.

Since the new Jekyll Blog is basically just a bunch of Markdown files, which are then compiled by Jekyll to static files, blogging can be done locally by creating/updating the Markdown files and/or fiddling with the configuration files. The changes can be tested locally and then be pushed to GitHub. Testing the pages locally requires you to install [Ruby](https://www.ruby-lang.org/de/) and a few gems. 

Since Windows [is not officially supported by Jekyll](https://jekyllrb.com/docs/windows/) and I sometimes only want to make a few quick changes (typos or the like) I looked for an alternative solutions which lets me edit the content online without having to install anything. Of course I can always edit the files directly on GitHub, but I was looking for something more practical, maybe even something WYSIWYG. I found two alternatives:

* [Prose.io](http://prose.io/), a free which is explicitly targeted at Jekyll sites and lets you edit your content with a simple online editor.
* [CloudCannon](https://cloudcannon.com/) which is a somewhat more sophisticated solution targeted for professional CMS providers. I am currently using CloudCannon, let's see if I stick with it.

The aftermath of the migration is not over. There is still a lot to do, especially in making sure all the links work, the images show up and the content is properly aligned. But so far I'm happy with my decision. I'm still trying to migrate all my comments to Disqus, but that seems to be a longer endeavor...

<!--
---
**Update**
Migration is over and I hope everything is in its right place now. The Simplicity of Jekyll/GitHub makes blogging is a breeze, so I don't miss my old Wordpress-Setup at all. I guess I should rename this post's title to _"Bye bye, sluggish performance, security issues, database administration, data backup, plugin incompabilities, ... Hello Markdown, integrated version control, statelessness, ..."_, but I guess that would be a bit too long... ;)
-->