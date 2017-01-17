---
excerpt: "<p>I recently needed to find out a list of modules which used <code>hook_cron</code>.
  I have SSH access to my server. Instead of writing a module (or using devel to execute
  some PHP) which returned the result of module_implements, I turned to <code>grep</code>.
  Simply <code>cd</code> into your modules folder (can be the Drupal install, but
  you end up recursing through unlikely folders) and run this:</p>\r\n<pre language=\"bash\">\r\ngrep
  -R \"^function.*_cron\" *module\r\n</pre>"
categories:
- programming
- linux
- geek
- drupal
- cool
layout: blog
title: Which modules use hook_cron?
created: 1179160554
permalink: blog/14-05-2007/what-modules-use-hook-cron
---
<p>I recently needed to find out a list of modules which used <code>hook_cron</code>. I have SSH access to my server. Instead of writing a module (or using devel to execute some PHP) which returned the result of module_implements, I turned to <code>grep</code>. Simply <code>cd</code> into your modules folder (can be the Drupal install, but you end up recursing through unlikely folders) and run this:</p>
<pre language="bash">
grep -R "^function.*_cron" *module
</pre>
<!--break-->
<p>That will recursively search for all files with any lines that start with <em><strong>function</strong></em>, have <em>anything</em> between that occurrence of function and <em><strong>_cron</strong></em>. You can replace <em><strong>_cron</strong></em> with any hook name you like. I hope this is of use to someone else too.</p>
<p>The Drupal face came from a derrivative of <a title="Free Drupal Wallpapers by Steven Wittens" href="http://acko.net/blog/drupal-wallpaper">Steven Wittens Wallpapers</a>. If you'd like me to take it down Steven, please let me know - I didn't think you'd mind as there doesn't seem to be any CC license notes on the page in question. Nice wallpapers by the way!</p>
