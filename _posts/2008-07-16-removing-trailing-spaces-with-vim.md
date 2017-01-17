---
excerpt: "<p>After recently reading about how great VIM is for the three hundredth
  and fifty second time (I kept count), I decided to take a look.</p>\r\n<p>It really
  is quite cool! I've also decided to try to log any cool tips I learn about it. Here
  is the first which I found after running the coder module on one of my modules (Page
  Title 2) and it threw hundreds of errors about too many trailing spaces on empty
  lines.</p>\r\n"
categories:
- vim
- linux
- drupal
layout: blog
title: Removing trailing spaces with vim
created: 1216220960
permalink: blog/16-07-2008/removing-trailing-spaces-with-vim
---
<p>After recently reading about how great VIM is for the three hundredth and fifty second time (I kept count), I decided to take a look.</p>
<p>It really is quite cool! I've also decided to try to log any cool tips I learn about it. Here is the first which I found after running the coder module on one of my modules (Page Title 2) and it threw hundreds of errors about too many trailing spaces on empty lines.</p>
<!--break-->
<h2>How to clear trailing spaces using VIM</h2>
<p>[adsense:468x60:4496506397]</p>
<p>After a bit of googling, it turned out to be REALLY easy!</p>
<pre class="vim">
:%s=\s\+$==
</pre>
<p>And thats it!</p>
<ul>
    <li>The <code>%</code> tells it to be global - not just the current line.</li>
    <li><code>S</code> is a shortcut for <em><code>substitute</code></em>.</li>
    <li>The <code>\s</code> (whitespace) and <code>\+</code> (at least once) are regular expression terms (the + needs to be escaped, it seems&hellip;).</li>
    <li>The <code>$</code> (dollar) represents the end of a line.</li>
    <li>The <code>=</code> are being used as delimiters, the <code>==</code> at the end implies that the pattern is replaced with nothing.</li>
</ul>
