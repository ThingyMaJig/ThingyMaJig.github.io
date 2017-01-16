---
excerpt: "<p>\r\n\tI just hit an interesting issue while trying to upgrade a Drupal
  5.18 site to Drupal 6.12. I&nbsp;went to the update.php page and noticed an error
  at the top implying the <code>url_alias</code>table was having issues due to Drupal
  6 expecting a language column which wasn&#39;t present in Drupal 5. <em>&quot;No
  problem&quot;</em> I thought, <em>&quot;That&#39;ll get fixed during the update!&quot;</em>.
  This was the beginning of a long learning curve through the new <code><a href=\"http://api.drupal.org/api/group/batch/6\">Batch
  API</a></code>&nbsp;system!</p>\r\n"
categories:
- programming
- geek
- drupal
layout: post
title: PHP's display_error, not always a good thing!
created: 1242740779
permalink: blog/19-05-2009/phps-displayerror-setting-isnt-always-good-thing
---
<p>
	I just hit an interesting issue while trying to upgrade a Drupal 5.18 site to Drupal 6.12. I&nbsp;went to the update.php page and noticed an error at the top implying the <code>url_alias</code>table was having issues due to Drupal 6 expecting a language column which wasn&#39;t present in Drupal 5. <em>&quot;No problem&quot;</em> I thought, <em>&quot;That&#39;ll get fixed during the update!&quot;</em>. This was the beginning of a long learning curve through the new <code><a href="http://api.drupal.org/api/group/batch/6">Batch API</a></code>&nbsp;system!</p>
<!--break-->
<div style="margin:0 5px 0 0; float:left; width:336px; height:280px;">
	[adsense:336x280:9994499560]</div>
<p>
	Whenever I ran the update, it sat there for a minute and eventually display a message to the effect &quot;There was unrecoverable error. See Below for more details&quot; and the details read &quot;An error occurred&quot;. This didn&#39;t give a lot of clues! So I started debugging and eventually found out the error occurred after <a href="http://api.drupal.org/api/function/system_update_6005/6">system_update_6005</a>.</p>
<p>
	Why 6005? Well, when the <a href="http://api.drupal.org/api/group/batch/6">Batch API</a> is started initially, it resets a time counter. It will keep going through it&#39;s list of operations (in this case, <code><a href="http://api.drupal.org/api/function/update_do_one/6">update_do_one</a></code>for each module/number needing doing) and keeping track of how long this particular round has been going. If the sum of the time for the operations is less than 1 second, then it doesn&#39;t bother ending, it does another op (and another, and another&hellip; until the sum of the time taken is more than 1 second). Once the 1 second is up, this &quot;round&quot; then it ends and returns a JSON&nbsp;object to the page callback. This page then uses the progress JavaScript system in Drupal to display the animated bar to let you know how it&#39;s getting on. The bar updates and then posts back to the site to, essentially, say &quot;<em>you may now continue from where you left off</em>&quot; and the next round starts. This keeps going until the operations array is empty.</p>
<p>
	Remember earlier, I said I had <code>display_errors</code>enabled (a common practice for a development environment)&hellip; Well when the JSON&nbsp;object got returned, there ws a non-JSON&nbsp;line tagged at the top which was meant to be there to tell me about the MySQL&nbsp;error caused by the broken <code>url_alias</code>table. The JavaScript JSON&nbsp;engine didn&#39;t like that so threw the error message. This is also why, if I&nbsp;restarted the updates, they worked fine.</p>
<p>
	So&hellip; Debugging&hellip; Not always a good thing!</p>
