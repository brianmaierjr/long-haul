---
layout: default
title: About & Contact
---

<div class="post">
	<h1 class="pageTitle">About the BELAB </h1>
	<img src="{{ '/assets/img/Cute Weddell Seal.jpg' | prepend: site.baseurl }}" alt="">
	<p class="intro"> 설명 1  </p>
	<p> 설명 2 </p>
	<h2>Research</h2>
	<ul>
		<li>설명 1</li>
  		<li>설명 2</li>
  		<li>설명 3</li>
  		<li>...</li>
  	
  	</ul>
</div>


<div id="contact">
  <h1 class="pageTitle">Contact</h1>
  <div class="contactContent">
    <p class="intro">This is an example Contact page. If you want to make changes then do so in the <code>contact.html</code> file.</p>
    <p>The form is provided by <a href="http://formspree.io/">Formspree.</a> Follow the directions on their site to set up the form for use.</p>
    <p>If you have questions about the theme feel free to <a href="mailto:brimaidesigns@gmail.com">email me</a> or create an issue on <a href="https://github.com/brianmaierjr/long-haul">GitHub</a>. Enjoy!</p>
  </div>
  <form action="http://formspree.io/your@mail.com" method="POST">
    <label for="name">Name</label>
    <input type="text" id="name" name="name" class="full-width"><br>
    <label for="email">Email Address</label>
    <input type="email" id="email" name="_replyto" class="full-width"><br>
    <label for="message">Message</label>
    <textarea name="message" id="message" cols="30" rows="10" class="full-width"></textarea><br>
    <input type="submit" value="Send" class="button">
  </form>
</div>
