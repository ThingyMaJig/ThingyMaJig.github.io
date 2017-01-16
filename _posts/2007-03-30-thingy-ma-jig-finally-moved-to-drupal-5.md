---
excerpt: "<p>It's taken me long enough to get around to, but finally Thingy Ma Jig
  has been upgraded to the latest and greatest in all things Drupal.</p>\r\n<p>All
  in all, I'd say it was a fairly (and surprisingly) painless experience. There were
  a few minor glitches along the way though&hellip;</p>\r\n"
categories:
- yads
- websites
- drupal
- announcement
layout: post
title: Thingy Ma Jig finally moved to Drupal 5
created: 1175271764
permalink: blog/30-03-2007/thingy-ma-jig-finally-moved-to-drupal-5
---
<p>It's taken me long enough to get around to, but finally Thingy Ma Jig has been upgraded to the latest and greatest in all things Drupal.</p>
<p>All in all, I'd say it was a fairly (and surprisingly) painless experience. There were a few minor glitches along the way though&hellip;</p>
<!--break-->
<h2>The process overview&hellip;</h2>
<p>To start with, I did the <em>recommended</em> procedure of disabling all modules and putting the site into offline mode. Summary; <em><strong>Easy</strong></em>!</p>
<p>I downloaded Drupal 5.1 into a seperate folder and changed my <strong>VHost</strong> file to point at the new folder. I also downloaded (into a separate folder) a copy of all the modules I needed that were branched for Drupal 5. I then <strong>symlinked</strong> these modules into the <code>drupal-5.1/modules</code> folder. This is a tip I picked up from <strong><em>Robert Douglass</em></strong>; it makes minor upgrades of Drupal core much easier as you can just download the new version, extract it and re-symlink your modules into it.</p>
<p>I restarted Apache and set my browser to www.thingy-ma-jig.co.uk to see what the damage was&hellip; Which, in this case, was a white screen of death. <strong>Bugger!</strong></p>
<p>I investigated a little to find out that the problem was being caused by my <strong><code>settings.php</code></strong> file in the sites folder which I'd brought across. Eventually I gave up with it and moved the theme out of the site folder and into the Drupal themes folder and, finally, deleting the site specific folder. This forced Drupal into using the default site which it seems much more happy with. I'd be interested if anyone has any ideas why that didn't work!</p>
<p>I refreshed the page and found that Drupal now wanted me to reconnect to the database. <strong>Perfect!</strong></p>
<p>After doing this, I ran the upgrade script which did a few database tweaks to bring the database up to Drupal 5 level. Next, I re-enabled the modules I needed (this took a few passes as I ended up forgetting a few the first time and second time!). Just after doing this Drupal told me that I needed to run the update script as my modules had been updated. This all went fine. Summary: <strong>Not too bad - fairly easy</strong>.</p>
<p>Finally I just <em>mopped up around the edges</em> and fixed a few minor errors - such as a call in the template.php to the old Drupal 4.7 <a href="http://api.drupal.org/api/4.7/function/module_exist" title="module_exist function in Drupal 4.7 API">module_exist</a> which has now been replaces with <a href="http://api.drupal.org/api/5/function/module_exists" title="module_exist function in Drupal 5 API">module_exists</a>. The one final issue which took a little while to fix was with the <a href="http://drupal.org/project/devel" title="Drupal Devel Module"><strong>Devel Module</strong></a> for <strong>Drupal 5</strong>. This is a <a href="http://drupal.org/node/126419" title="Issue 126419: Anonymous user's get error">documented issue</a> which claims to be fixed in the latest release. I fixed it (in the end) by wrapping a php function (<em><strong><code>function_exists</code></strong></em>) around the entire contents of <em><strong><code>devel_init()</code></strong></em>.</p>
<h2>The conclusion&hellip;</h2>
<p>I am very surprised - in a good way - at how easy it was to upgrade to Drupal 5! There ended up being far less than 1 hour down time and the site itself is (as far as I'm aware) functioning better than ever!</p>
<p>Thanks to everyone at the Drupal team for making this a fantastic release. I promise to upgrade to Drupal 6 as soon as it's released!</p>
