---
excerpt: "<p>Today I needed to quickly find out a list of node's which did not contain
  a certain token (one we use on <a href=\"http://www.pponline.co.uk/\">PPOnline</a>
  to insert adverts into articles). There were meant to be 2 of these tokens per article
  but we had noticed some only had one. Some didn't have any at all!</p>\r\n<p>Now,
  this might already exist as a neat function somewhere, but I couldn't find it. So
  I wrote this little query to <em>find the number of occurrences of a substring</em>
  in a larger block of text.</p>\r\n<p>I did look into using the SUBSTRING() and SUBSTRING_INDEX()
  commands, however I couldn't see a way of efficiently using them to find any number
  of occurrences. So I settled on the following&hellip;</p>\r\n"
categories:
- tip
- mysql
- geek
- drupal
layout: post
title: 'MySQL: Count occurrences of string'
created: 1266417343
permalink: blog/17-02-2010/mysql-count-occurrences-string
---
<p>Today I needed to quickly find out a list of node's which did not contain a certain token (one we use on <a href="http://www.pponline.co.uk/">PPOnline</a> to insert adverts into articles). There were meant to be 2 of these tokens per article but we had noticed some only had one. Some didn't have any at all!</p>
<p>Now, this might already exist as a neat function somewhere, but I couldn't find it. So I wrote this little query to <em>find the number of occurrences of a substring</em> in a larger block of text.</p>
<p>I did look into using the SUBSTRING() and SUBSTRING_INDEX() commands, however I couldn't see a way of efficiently using them to find any number of occurrences. So I settled on the following&hellip;</p>
<!--break-->
<div>[adsense:468x60:4496506397]</div>
<pre language="mysql">
SET @findme="MySQL";
SELECT
  n.nid, n.title,
  CAST((LENGTH(nr.body) - LENGTH(REPLACE(nr.body, @findme, ""))) / LENGTH(@findme) AS UNSIGNED) AS findme_count
FROM node n
INNER JOIN node_revisions nr ON nr.vid = n.vid
WHERE n.type = "blog"
ORDER BY findme_count DESC;
</pre>
<div>[adsense:468x60:4496506397]</div>
<p>The above example will list all node's of type <em>blog</em>. It will then compare the length of the body before and after removing all instances of the string you're looking for. The result should be <code>n * LENGTH(find_me)</code> where <code>n</code> is the number of occurrences. This is why we divide by the length of the <code>find_me</code> string.</p>
<p>This is a pretty fast query too. On our live database, it searched over 1,400 nodes in just over 31 milliseconds.</p>
<p>I hope this saves someone some time in the future!</p>
