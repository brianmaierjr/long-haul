---
title: Bye bye, Wordpress. Hello Jekyll!
layout: post
---
I have hosted my personal blog using [Wordpress](https://wordpress.org/) on my beloved [Synology 109+ NAS](https://www.synology.com/de-de/support/download/DS109+#utilities) for a long time. The site has been running 24/7 on this hardware for many years now. But after adding content over the years, adding more and more plugins and upgrading PHP a few times I begann noticing performance deteriorate more and more. I never put it to test, but it seemed to me like the pages took longer and longer to load. In the end, page speed was sluggish at best. All the plugins and DB accesses (and PHP's hunger for resources) took their toll on the performance. It looked like my NAS was not such a good fit for a PHP/MySQL-backed Wordpress blog anymore...

<figure>
	<img src="{{ '/assets/img/posts/synology_109_nas.jpg' | prepend: site.baseurl }}" alt=""> 
	<figcaption>My devoted workhorse which has been hosting my blog until now...</figcaption>
</figure>

To make things worse, Synology has stopped shipping major software updates for my NAS. It hasn't received any update (apart from security patches) for a long time and still runs DiskStation 4.2 at the time, which includes an outdated PHP version. 

# Exit Wordpress

Apart from the long page loadsall I didn't deem this to be much of a problem for me. Especially considering I use this blog as my personal braindump which has only got small attention (although I did receive some comments or E-Mails from all around the world). Until recently, when warnings started to pile up in the Wordpress Admin-Dashboard, urging me to update to the newest PHP version. I wasn't even able to install or upgrade certain plugins anymore since they require a higher version of PHP. Upgrading the PHP version would be possible in theory, but this would mean fiddling with the internals of the DiskStation software and potentially running into compatibility issues. Not my idea of fun. So I had to decide between two paths: Staying with the current state (with the danger of the site becoming inoperable due to deprecated software) or going for the radical path and migrating everything to a new host. I went for the latter.

Since I didn't find any solutions for free Wordpress Hosting that met my requirements I looked around for something simpler, less resource hungry, without a zillion plugins. Something lightweight and sleek. At the same time it should support some key features that I often use:

- Syntax highlighting for various languages
- support for LaTeX
- support for advanced text formatting
- customizable design (without having to handcraft everything)
- open and extendable (to some point)
- Possibility to write online or offline

To make the search harder, it all should be free (as hosting on my own NAS is). And yeah, the page speed should also be higher. Dear Santa Clause...

# Enter Jekyll

<img src="{{ '/assets/img/posts/jekyll_logo.png' }}" alt=""> 

![Jekyll Logo](/assets/img/posts/jekyll_logo.png){:class="img-responsive"}


And then came [Jekyll](https://jekyllrb.com/). Jekyll is a static site generator and the underlying technology used by [GitHub Pages]](https://pages.github.com/). It does not need a database and you can write your content using [Markdown](https://en.wikipedia.org/wiki/Markdown). Jekyll uses the [Liquid Templating Language](http://shopify.github.io/liquid/) and [Front Matter](https://jekyllrb.com/docs/frontmatter/) that you can use to add some logic to your site. Your files are then compiled by GH Pages and served as plain old HTML pages. And since all the files reside in a normal GitHub repository, I don't have to worry about things like backup or versioning anymore. I can even apply the same workflow for blogging like I apply for coding (or as Tom Preston-Warner expressed it: [Blogging Like a Hacker](http://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html)). The few dynamic features I used, like comments, can easily be replaced by third-party services like [Disqus](disqus.com). Having never used Jekyll before, I found [this tutorial](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/) insightful. I don't have any long-term experience yet. Time will show how it all turns out, but what I have seen so far looks promising.

# Migrating from WP to GH Pages
Migration is never an easy endeavour, especially considering all the assets (text, images, code blocks, CSS,...). So I tried to automate as much as possible. Jekyll is really trying to help out here by providing a [wide range of available importers](http://import.jekyllrb.com/). Alas, the provided Wordpress-Importer was only able to generate HTML files, not Markdown. And it only imports posts and pages, no assets!

Luckily I found a [WP plugin](https://github.com/benbalter/wordpress-to-jekyll-exporter) which did a fantastic job of converting all my posts and pages to Markdown files (including all the images in them). Unfortunately, the images are linked with their absolute paths (i.e. an URL pointing to the old location of the image). The pages also do not always look as expected when displayed in the new blog, but this is not neccessarily the plugin's fault. Some content like automatic table of contents (TOC) on pages is generated on the fly by a plugin and can not be migrated easily. So there still is a lot of work do be done by hand. But at least I was able to move moste of the content in one go without major hiccups.

Next step was the site's new design. I was looking for something sleek and minimal. Luckily, Jekyll is themeable and there are a [lot of readily available themes](http://jekyllthemes.org/) out there. I went for the [Long-Haul](https://github.com/brianmaierjr/long-haul) theme by Brian Maier Jr., which seems to be a goot compromise between focus on the content while still being visually appealing. I had to touch up on the CSS, the Layouts and the Gems a bit to fit the appearance my needs, but I was able to keep the theme in its original design without too much tweaking.

Since the new Jekyll Blog is basically just a bunch of Markdown files blogging can be done locally by creating/updating the Markdown files and/or fiddling with the configuration files. The changes can be tested locally and then be pushed to GitHub. Testing the pages locally requires you to install [Ruby](https://www.ruby-lang.org/de/) and a few gems. But since Windows [is not officially supported by Jekyll](https://jekyllrb.com/docs/windows/) and I sometimes only want to make a few quick changes (typos or the like) I looked for an alternative solutions which lets me edit the content online without having to install anything. Of course I can always edit the files directly on GitHub, but I was looking for something more practical, maybe even something WYSIWYG. I found two alternatives:

* [Prose.io](http://prose.io/), a free which is explicitly targeted at Jekyll sites and lets you edit your content with a simple online editor.
* [CloudCannon](https://cloudcannon.com/) which is a somewhat more sophisticated solution targeted for professional CMS providers. 

I am currently using CloudCannon, which is free for basic use and a bit more powerful than Prose.io. It even features nice things like shortcuts while editing (e.g. `CTRL + D ` to delete a line). Let's see if I stick with it.

The aftermath of the migration is not over. There is still a lot to do, especially in making sure all the links work, the images all show up and the content is properly aligned. But so far I'm quite happy with my decision to move to GH Pages. I'm still trying to migrate all the comments to Disqus, but that might take a bit longer than expected...

<!--
---
**Update**
Migration is over and I hope everything is in its right place now. The Simplicity of Jekyll/GitHub makes blogging is a breeze, so I don't miss my old Wordpress-Setup at all. I guess I should rename this post's title to _"Bye bye, sluggish performance, security issues, database administration, data backup, plugin incompabilities, ... Hello Markdown, integrated version control, statelessness, ..."_, but I guess that would be a bit too long... ;)
-->