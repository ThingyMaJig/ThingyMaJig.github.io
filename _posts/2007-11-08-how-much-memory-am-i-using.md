---
excerpt: "<p>Following on from my previous post about <a href=\"/blog/25-10-2007/the-price-of-sucess-too-many-users\"
  title=\"How to check the number of Apache Processes running in Linux\">how to check
  how many apache processes are running</a> - I recently wanted to find out exactly
  how much memory my applications where using&hellip; So I did a little research and
  found a few new and useful commands!</p>\r\n"
categories:
- programming
- linux
- howto
- geek
- cool
layout: post
title: How much memory am I using?
created: 1194530230
permalink: blog/08-11-2007/how-much-memory-am-i-using
---
<p>Following on from my previous post about <a href="/blog/25-10-2007/the-price-of-sucess-too-many-users" title="How to check the number of Apache Processes running in Linux">how to check how many apache processes are running</a> - I recently wanted to find out exactly how much memory my applications where using&hellip; So I did a little research and found a few new and useful commands!</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<pre language="bash">
ps haxo 'size' | (tr '\n' +; echo 0) | bc
</pre>
<p>You will recognise the <code>ps</code> command from the previous post, the extra '<em>h</em>' option tells it to hide the header (You cant do 'SZ + 5 + 6'!) and the new <code>tr</code> command <q>translate or delete characters</q> (from the <em>manual pages</em>). So this strips out all new lines and puts a '+' after each number. The reason we need to <code>echo 0</code> onto the end is because if we didn't we would end up with <code>1+2+3+</code>. The <code>bc</code> command is a <em>basic calculator</em> and will just add up whatever numbers it gets!</p>
<p>[adsense:468x60:4496506397]</p>
<p>So, <code>ps</code> produces a column of numbers, <code>tr</code> concatenates each newline-separated number with a '+' symbol. A zero is added to the end of the string and finally the entire string of numbers are parsed using the <code>bc</code> command.</p>
<p>The result is a single number which represents the number of <strong>kilobytes</strong> currently in use by your applications.</p>
