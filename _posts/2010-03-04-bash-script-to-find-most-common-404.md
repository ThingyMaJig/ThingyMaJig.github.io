---
excerpt: <p>Following <a href="http://drupal.org/user/78090">Kevin Hankens</a> post
  on <a title="Why you shouldn't ignore Drupal 404 errors" href="http://kevinhankens.com/content/danger-q-1-or-why-you-shouldnt-ignore-drupal-404-errors">why
  you shouldn't ignore Drupal 404 errors</a>, I decided to go through yesterdays error_log
  on our live apache server (the one which hosts <a href="http://www.pponline.co.uk">www.pponline.co.uk</a>,
  <a href="http://www.sportbusiness.com">www.sportbusiness.com</a> and <a href="http://www.mychild.co.uk">www.mychild.co.uk</a>
  alongside around 40 other dupral sites).</p>
categories:
- programming
- linux
- howto
- geek
- drupal
- apache
layout: post
title: Bash script to find most common 404
created: 1267696033
permalink: blog/04-03-2010/bash-script-find-most-common-404
---
<p>Following <a href="http://drupal.org/user/78090">Kevin Hankens</a> post on <a title="Why you shouldn't ignore Drupal 404 errors" href="http://kevinhankens.com/content/danger-q-1-or-why-you-shouldnt-ignore-drupal-404-errors">why you shouldn't ignore Drupal 404 errors</a>, I decided to go through yesterdays error_log on our live apache server (the one which hosts <a href="http://www.pponline.co.uk">www.pponline.co.uk</a>, <a href="http://www.sportbusiness.com">www.sportbusiness.com</a> and <a href="http://www.mychild.co.uk">www.mychild.co.uk</a> alongside around 40 other dupral sites).</p>
<p>It turns out there were almost 5,000 404 (page not found) errors. How to find the most &quot;popular&quot; ones though? This called for a Bash script&hellip;</p>
<!-- break -->
<div style="clear:both"><pre language="bash">
gawk '{ print $13 }' error_log.1  | grep ^/var | sort | uniq -c | sort -n
</pre></div>
<p>This uses <code>gawk</code> to parse yesterdays error log (hence the .1) and return column 13, assuming space is the default delimiter. <strong>Note: It turns out single quotes and double quotes mean different things to gawk!</strong>. Next I want to filter out lines beginning with &quot;/var&quot;; the gawk also returned values from memory &amp; PHP errors. Next, sort them and do a unique liens count. Finally, sort this result with the most common entries at the end.</p>
<p>The result? SportBusiness REALLY needs a favicon in the default place - that along accounted for 20% of the 404's!</p>
<h3>UPDATE</h3>
<pre language="bash">
gunzip -c /var/log/httpd/error_log.3.gz | gawk '{ print $13 }' | grep ^/var | sort | uniq -c | sort -n
</pre>
<p>This is a slight alternative, if you use compressed log files is the following (it saves decompressing the file first).</p>
