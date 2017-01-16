---
excerpt: "<p>This morning I updated a site to the latest release of Drupal 5.16. Nothing
  special there at all. I've done that many times as has (hopefully) mabye other drupal
  devs&hellip; However, I'm a bit of a newbie when it comes to SVN. Didn't I mention
  this drupal site was in an SVN repository? ;-)</p>\r\n<p>So, I've <code>svn copy</code>'d
  the trunk to an &quot;<em><code>update_to_5.16</code></em>&quot; branch, checked
  out this branch and done a <code>cvs up -dP -r DRUPAL-5-16</code>. Everything is
  going according to plan so far. Next I run <code>svn status</code> to get a list
  of files which I need to mark as added or deleted (or to list anything else which
  has gone wrong). What happens next is I&nbsp;get a list of hundreds of CVS&nbsp;<em>Template</em>
  files which have been added to the CVS&nbsp;folders. For example&hellip;</p>\r\n"
categories:
- tip
- svn
- linux
- howto
- geek
- drupal
layout: post
title: I'm a lazy linux piper
created: 1236770433
permalink: blog/11-03-2009/lazy-linux-piping
---
<p>This morning I updated a site to the latest release of Drupal 5.16. Nothing special there at all. I've done that many times as has (hopefully) mabye other drupal devs&hellip; However, I'm a bit of a newbie when it comes to SVN. Didn't I mention this drupal site was in an SVN repository? ;-)</p>
<p>So, I've <code>svn copy</code>'d the trunk to an &quot;<em><code>update_to_5.16</code></em>&quot; branch, checked out this branch and done a <code>cvs up -dP -r DRUPAL-5-16</code>. Everything is going according to plan so far. Next I run <code>svn status</code> to get a list of files which I need to mark as added or deleted (or to list anything else which has gone wrong). What happens next is I&nbsp;get a list of hundreds of CVS&nbsp;<em>Template</em> files which have been added to the CVS&nbsp;folders. For example&hellip;</p>
<!--break-->
<pre>
?      profiles/default/CVS/Template
M      profiles/default/CVS/Entries
M      profiles/default/CVS/Tag
?      profiles/CVS/Template
M      profiles/CVS/Tag
?      themes/bluemarine/CVS/Template
M      themes/bluemarine/CVS/Entries
M      themes/bluemarine/CVS/Tag
M      themes/engines/phptemplate/phptemplate.engine
?      themes/engines/phptemplate/CVS/Template
M      themes/engines/phptemplate/CVS/Entries
M      themes/engines/phptemplate/CVS/Tag
?      themes/engines/CVS/Entries.Log
?      themes/engines/CVS/Template
M      themes/engines/CVS/Tag
?      themes/garland/images/CVS/Template
M      themes/garland/images/CVS/Entries
M      themes/garland/images/CVS/Tag
?      themes/garland/minnelli/CVS/Template
M      themes/garland/minnelli/CVS/Entries
M      themes/garland/minnelli/CVS/Tag
?      themes/garland/minnelli/color/CVS/Template
M      themes/garland/minnelli/color/CVS/Entries
M      themes/garland/minnelli/color/CVS/Tag
?      themes/garland/CVS/Template
&hellip;
&hellip;
</pre>
<p>So as you can see from this (shortened) list, several Entries &amp; Tag files have been modified (along with 1 core file). The files labelled with a ? are ones which are new in the <em>Working Copy</em> which are not in the SVN repository.</p>
<p>Now those who know me or read my blog may know I dont enjoy tedious jobs. I think the definition of tedious could be described as typing <code>svn add themes/garland/minnelli/CVS/Template</code> hundreds of times (for each ? file in list which was much longer that than). What do I do when I have to do tedious jobs? I find a bash script which will do it for me and then blog about it!</p>
<p>So, firstly, I tried piping the <code>svn st</code> results through grep to filter out the results which need adding. I also add a filter to only add Template entries to start with.</p>
<pre language="bash">
svn st | grep ^? | grep Template$</pre>
<p>The <code><em>svn st</em></code> is short-hand for <code>svn status</code>.</p>
<p>Next we need to strip out the question marks and spaces at the beginning of each line. Enter <code>gawk</code>. I'm not an expert at <code>gawk</code>, but this time it seemed to <em>Just Work<sup>TM</sup></em>.</p>
<pre language="bash">
svn st | grep ^? | grep Template$ | gawk '{ print $2 }'</pre>
<p>I then trid to just pipe that into <code>svn add</code>. Subversion did <strong>not</strong> appreciate this and complained about there not being enough arguments. &quot;Ok&quot;, I thought &mdash; I've seen this problem before when trying to work with the results of a list of files produced by the <code>find</code> command&hellip; What about the <code>xargs</code> command? <em><abbr title="English slang for 'Would you believe it'">Would you adam and eve it</abbr></em>? It worked!</p>
<pre language="bash">
$ svn st | grep ^? | grep Template$ | gawk '{ print $2 }' | xargs svn add
A         profiles/default/CVS/Template
A         profiles/CVS/Template
A         themes/bluemarine/CVS/Template
A         themes/engines/phptemplate/CVS/Template
A         themes/engines/CVS/Template
A         themes/garland/images/CVS/Template
A         themes/garland/minnelli/CVS/Template
A         themes/garland/minnelli/color/CVS/Template
A         themes/garland/CVS/Template
A         themes/garland/color/CVS/Template
A         themes/CVS/Template
A         themes/chameleon/CVS/Template
A         themes/chameleon/marvin/CVS/Template
A         themes/pushbutton/CVS/Template
A         scripts/CVS/Template
A         sites/default/CVS/Template
A         sites/all/CVS/Template
A         sites/CVS/Template
A         misc/farbtastic/CVS/Template
A         misc/CVS/Template
A         CVS/Template
A         includes/CVS/Template
A         modules/aggregator/CVS/Template
A         modules/blog/CVS/Template
A         modules/system/CVS/Template
A         modules/upload/CVS/Template
A         modules/filter/CVS/Template
A         modules/node/CVS/Template
A         modules/drupal/CVS/Template
A         modules/help/CVS/Template
A         modules/forum/CVS/Template
A         modules/book/CVS/Template
A         modules/block/CVS/Template
A         modules/statistics/CVS/Template
A         modules/contact/CVS/Template
A         modules/CVS/Template
A         modules/tracker/CVS/Template
A         modules/path/CVS/Template
A         modules/ping/CVS/Template
A         modules/locale/CVS/Template
A         modules/profile/CVS/Template
A         modules/watchdog/CVS/Template
A         modules/comment/CVS/Template
A         modules/menu/CVS/Template
A         modules/legacy/CVS/Template
A         modules/search/CVS/Template
A         modules/throttle/CVS/Template
A         modules/poll/CVS/Template
A         modules/blogapi/CVS/Template
A         modules/color/images/CVS/Template
A         modules/color/CVS/Template
A         modules/taxonomy/CVS/Template
A         modules/user/CVS/Template
</pre>
<p>Brilliant!&nbsp;One line of commands joined together with a pipe and I have saved many, <strong>many</strong> minutes of tedious and bording typing!</p>
