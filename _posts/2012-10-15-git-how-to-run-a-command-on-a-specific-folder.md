---
categories:
- git
- howto
- tips
layout: post
title: 'Git: How to run a command on a specific folder'
created: 1350311400
permalink: blog/15-10-2012/git-how-to-run-a-command-on-a-specific-folder
---
<p>I recently needed to be able to run a regular git task on a folder and I didn't want to have to <a href="http://en.wikipedia.org/wiki/Cd_(command)" title="Change Directory">CD</a> into that folder first. Annoyingly, there didn't seem to be an optional "path" parameter to <code>git remote update</code>, until I looked at the help file for Git.</p>
<!--berak-->
<p>It's quite simple! All you need to do, to run a git command on an arbitrary path, is this:</p>
<pre language="bash">
$ git --git-dir=/path/to/the/repository remote update
</pre>
<p>This makes assigning, say, a cron job to regularly update repository which is being used by a tool such as <a href="http://gitlist.org/" title="GitList - a great and free PHP-based git repository browser">GitList</a>, very easy indeed!</p>
