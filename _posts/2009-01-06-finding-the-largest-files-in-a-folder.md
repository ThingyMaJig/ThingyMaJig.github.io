---
excerpt: "<p>I just needed to find the largest files in a folder (in an attempt to
  find out why it was so bloody huge!) and have ended up with the following handy
  combination of commands&hellip;</p>\r\n<pre language=\"bash\">\r\nfind /path/to/folder
  -size +1M -print0 | xargs -0 du -h | sort -nr</pre>\r\n"
categories:
- linux
- howto
- geek
- bash
layout: blog
title: Finding the largest files in a folder
created: 1231248769
permalink: blog/06-01-2009/finding-largest-files-folder
---
<p>I just needed to find the largest files in a folder (in an attempt to find out why it was so bloody huge!) and have ended up with the following handy combination of commands&hellip;</p>
<pre language="bash">
find /path/to/folder -size +1M -print0 | xargs -0 du -h | sort -nr</pre>
<!--break-->
<div>[adsense:468x60:4496506397]</div>
<p>This simply lists all the files in the path specified where the size is more then 1Mb (you can use k (kilobyte), M&nbsp;(megabyte) and G&nbsp;(gigabyte) too) and prints the list out using null bytes as row terminators. The reason for null bytes is so whitespace characters don't break the next section, <code>xargs</code>. The <code>xargs</code> function allows you to run a command using the piped in value as an argument to the command, in this case we want to know the human readable size of the file. Finally we do a numeric (-n) reverse (-r) sort.</p>
