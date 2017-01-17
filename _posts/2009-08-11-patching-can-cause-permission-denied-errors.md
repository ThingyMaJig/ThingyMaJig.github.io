---
excerpt: "<p>I just updated this server to PHP 5.3. As all my sites are Drupal 6 it
  seems I have a few issues ahead which mean I need to patch Drupal to stop PHP complaining
  about deprecated stuff&hellip;</p>\r\n<p>So I headed over to <a href=\"http://drupal.org/node/360605#comment-1852706\">the
  post on drupal.org which is discussing 5.3 compatibility in Drupal 6</a> (which
  I personally think SHOULD go in) to grab a patch. I applied the patch with no problems.
  I refreshed a page and got a white screen so I checked the logs only to see&hellip;</p>"
categories:
- linux
- howto
- geek
- drupal
layout: blog
title: Patching can cause permission denied errors
created: 1249991867
permalink: blog/11-08-2009/patching-can-cause-permission-denied-errors
---
<p>I just updated this server to PHP 5.3. As all my sites are Drupal 6 it seems I have a few issues ahead which mean I need to patch Drupal to stop PHP complaining about deprecated stuff&hellip;</p>
<p>So I headed over to <a href="http://drupal.org/node/360605#comment-1852706">the post on drupal.org which is discussing 5.3 compatibility in Drupal 6</a> (which I personally think SHOULD go in) to grab a patch. I applied the patch with no problems. I refreshed a page and got a white screen so I checked the logs only to see&hellip;</p>
<pre class="codeblock">
2009-08-11 12:30:10: (mod_fastcgi.c.2618) FastCGI-stderr: PHP Warning:  require_once(./includes/file.inc) [<a href="function.require-once">function.require-once</a>]: failed to open stream: Permission denied in /path/to/drupal_installation/drupal/includes/common.inc on line 2562</pre>
<p>Well that was odd. I checked the file and the folders and all permissions were fine. I then had to waste the next hour of my life googling for the problem. It turns out that if you run a RedHat based distro (such as CentOS 5.3) you get a lovely application called SE&nbsp;Linux. SE&nbsp;Linux is meant to be there to protect you. From my experience it seems to spend more time pissing you off.</p>
<p>A quick test to confirm that SE&nbsp;Linux was causing my permission errors was to run the following (as root) from the terminal:</p>
<pre class="codeblock">
echo 0 &gt; /selinux/enforce</pre>
<p>Best to make sure you switch it back on afterwards ;-) but first I need to find out why SE&nbsp;Linux is complaining about a file being patched.</p>
