---
excerpt: "<p>Today I needed to list all of the services which were enabled on boot-up
  for one of the servers I maintain. Obviously, my first port of call was to use the
  nifty tool <code>ChkConfig</code> like so&hellip;</p>\r\n"
categories:
- linux
- howto
- geek
layout: post
title: List enabled services in Linux
created: 1227289061
permalink: blog/21-11-2008/list-enabled-services-linux
---
<p>Today I needed to list all of the services which were enabled on boot-up for one of the servers I maintain. Obviously, my first port of call was to use the nifty tool <code>ChkConfig</code> like so&hellip;</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<pre language="bash">
/sbin/chkconfig --list
</pre>
<p>But that also listed all the services which were NOT set to start at boot time&hellip; Surely grep would be me saviour?! Well thanks to a comment on another site, I introduce this set of commands!</p>
<p>[adsense:468x60:4496506397]</p>
<pre language="bash">
chkconfig --list | grep "3:on" | awk "{print $1}" | sort
</pre>
<p>This makes the list a LOT more readable and even alphabetizes it for you!</p>
