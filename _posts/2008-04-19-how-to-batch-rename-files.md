---
excerpt: "<p>This afternoon I needed to rename a bunch of files from one form to another
  in a command shell&hellip; Well technically I didn't need to do it in a shell -
  but, as sure as there is a hole in my ass, I wasn't gonna go through renaming them
  all manually!</p>\r\n<p>They needed to go from, for example, <code>add.png</code>
  to <code>add_32.png</code>. After a little research into commands like <code>printf</code>,
  <code>awk</code>, <code>bison</code> and so on - I suddenly realized that '<code>cut</code>'
  held the key!</p>\r\n"
categories:
- mac
- linux
- geek
- bash
layout: blog
title: How to batch rename files
created: 1208640664
permalink: blog/19-04-2008/how-batch-rename-files
---
<p>This afternoon I needed to rename a bunch of files from one form to another in a command shell&hellip; Well technically I didn't need to do it in a shell - but, as sure as there is a hole in my ass, I wasn't gonna go through renaming them all manually!</p>
<p>They needed to go from, for example, <code>add.png</code> to <code>add_32.png</code>. After a little research into commands like <code>printf</code>, <code>awk</code>, <code>bison</code> and so on - I suddenly realized that '<code>cut</code>' held the key!</p>
<!--break-->
<pre language="bash">
for i in *; do j=`echo $i | cut -d . -f 1`; j=$j"_32.png"; mv $i $j; done
</pre>
<p>[adsense:468x60:4496506397]</p>
<p>Basically, this says &quot;<em>for every file in the folder, cut the filename on all dots and take the first result into variable '<code>j</code>'. Then append '<code>_32.png</code>' onto the end of the variable. Finally move the original file to the new filename</em>&quot;.</p>
<p>I hope this saves someone else a bit of time!</p>
