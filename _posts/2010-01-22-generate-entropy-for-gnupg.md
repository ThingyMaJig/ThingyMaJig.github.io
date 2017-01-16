---
excerpt: "<p>Has anyone every tried to generate a GPG (or GnuPG) key? I have&hellip;
  and I received this error&hellip;</p>\r\n<div style=\"clear: both;\"><pre>\r\nNot
  enough random bytes available.  Please do some other work to give\r\nthe OS a chance
  to collect more entropy! (Need 284 more bytes)\r\n</pre></div>\r\n"
categories:
- security
- linux
- geek
layout: post
title: Generate Entropy for GnuPG
created: 1264164770
permalink: blog/22-01-2010/generate-entropy-gnupg
---
<p>Has anyone every tried to generate a GPG (or GnuPG) key? I have&hellip; and I received this error&hellip;</p>
<div style="clear: both;"><pre>
Not enough random bytes available.  Please do some other work to give
the OS a chance to collect more entropy! (Need 284 more bytes)
</pre></div>
<!--break-->
<p>I was remotely logged into the machine (over SSH) so couldn't physically move the mouse or press keys to generate random entropy. The solution turned out to be simply running the following command in a second SSH Shell.</p>
<pre language="bash">
ls -R /
</pre>
<p>As soon as I ran that, the gpg command in the other window instantly finished creating my 2048 bit key.</p>
