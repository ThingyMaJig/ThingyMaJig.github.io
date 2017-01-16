---
excerpt: "<p>I use a cron script on this server which fires up Drush to run Cron (rather
  than the standard wget method). There is nothing <em>wrong</em> with using wget,
  however it does tie up an apache or lighttpd process while cron is running. It also
  means it's harder to control process priority. Drush, on the other hand, runs in
  CLI mode, so controlling process priority is easier (using nice). But then I started
  seeing odd errors&hellip;</p>"
categories:
- drupal
- performance
- tips
layout: post
title: Drush Cron & XCache can cause var_size errors
created: 1271237409
permalink: blog/14-04-2010/drush-cron-xcache-can-cause-varsize-errors
---
<p>I use a cron script on this server which fires up Drush to run Cron (rather than the standard wget method). There is nothing <em>wrong</em> with using wget, however it does tie up an apache or lighttpd process while cron is running. It also means it's harder to control process priority. Drush, on the other hand, runs in CLI mode, so controlling process priority is easier (using nice). But then I started seeing odd errors&hellip;</p>
<!-- break -->
<p>I also use an XCache tweak on this site (Blog post about that is in the pipeline). The tweak is done in a custom cache.inc file which allows me to store cached pages in the XCache variables and then, using the page_cache_fastpath function, I can pull the pages out and serve them without even connecting to the database. It is a HUGE performance improvement.</p>
<p>However, it turns out that XCache doesn't run in CLI mode and I was getting the following error in my cron logs:</p>
<pre>
xcache.var_size is either 0 or too small to enable var data caching
</pre>
<p>So for anyone else that is seeing this error in their logs, remember... XCache doesn't run in CLI mode and is therefore unavailable. This means any custom code you have which depends on the XCache variables will not work!</p>
