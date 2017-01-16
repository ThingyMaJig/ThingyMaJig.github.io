---
excerpt: "<p>Have you ever wanted to generate a random string in MySQL, say for assigning
  a random password to a list of users? Well here is a useful tip!</p>\r\n"
categories:
- security
- programming
- mysql
- howto
- geek
layout: post
title: Generate random string in MySQL
created: 1215679876
permalink: blog/10-07-2008/generate-random-string-mysql
---
<p>Have you ever wanted to generate a random string in MySQL, say for assigning a random password to a list of users? Well here is a useful tip!</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<pre language="mysql">
SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 6) AS password
</pre>
<p>This creates a 6 character (easy to change, as you can see) string where the characters are from the MD5 command (and therefore in the range a-z and 0-9).</p>
<p>[adsense:468x60:4496506397]</p>
