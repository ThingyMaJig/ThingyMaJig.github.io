---
excerpt: "<p>This blog is now no longer powered by <a title=\"Apache HTTPD Server\"
  href=\"http://httpd.apache.org/\"><em>Apache</em></a> (the feature filled but slightly
  bloated beast), instead I have decided to give <a title=\"Lighttpd / Lighty Website\"
  href=\"http://www.lighttpd.net/\"><em><strong>Lighttpd</strong></em></a> (pronounced
  <em>Lighty</em>) a whirl.</p>\r\n<p>What convinced me? Ages ago I read an article
  by Dries Buytaert comparing webserver configurations. It was shocked to see that
  Lighttpd appeared to be able to serve almost twice as many pages per second as Apache.
  There is also the advantage that a static file will only cost you substantially
  less memory to serve in <strong><em>Lighty </em></strong>than it will in <em>Apache</em>
  due to Apache bundling ALL the mods into every process.</p>\r\n<p>So what is <em><strong>Lighttpd</strong></em>?
  The inventors describe it perfectly&hellip;</p>\r\n"
categories:
- linux
- lighttpd
- drupal
layout: post
title: Powered by Lighttpd
created: 1208356013
permalink: blog/16-04-2008/powered-lighttpd
---
<p>This blog is now no longer powered by <a title="Apache HTTPD Server" href="http://httpd.apache.org/"><em>Apache</em></a> (the feature filled but slightly bloated beast), instead I have decided to give <a title="Lighttpd / Lighty Website" href="http://www.lighttpd.net/"><em><strong>Lighttpd</strong></em></a> (pronounced <em>Lighty</em>) a whirl.</p>
<p>What convinced me? Ages ago I read an article by Dries Buytaert comparing webserver configurations. It was shocked to see that Lighttpd appeared to be able to serve almost twice as many pages per second as Apache. There is also the advantage that a static file will only cost you substantially less memory to serve in <strong><em>Lighty </em></strong>than it will in <em>Apache</em> due to Apache bundling ALL the mods into every process.</p>
<p>So what is <em><strong>Lighttpd</strong></em>? The inventors describe it perfectly&hellip;</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<blockquote cite="http://www.lighttpd.net/">
<p>Security, speed, compliance, and flexibility -- all of these describe lighttpd (<em>pron.</em> <strong>Lighty</strong>) which is rapidly redefining efficiency of a webserver; as it is designed and optimized for high performance environments. With a small memory footprint compared to other web-servers, effective management of the cpu-load, and advanced feature set (FastCGI, SCGI, Auth, Output-Compression, URL-Rewriting and many more) lighttpd is the perfect solution for every server that is suffering load problems. And best of all it's Open Source licensed under the <a href="http://www.lighttpd.net/download/COPYING">revised BSD license</a>.</p>
</blockquote>
<p>The effect so far is <strong style="text-decoration:underline">amazing</strong>! The server's memory footprint is WAY down. <em>Apache</em> used to use around 7-8Mb per process. The single <em><strong>Lighty</strong></em> process is currently using 1.3Mb and each PHP-FastCGI child thats spawned is between 1.5Mb and 2.4Mb. Currently the total is a mere 15Mb whereas <em>Apache</em>, currently would have been eating anywhere between 70Mb and 90Mb!</p>
<p>I will be posting more articles over the coming days about how I got it up and running on here. I would also appreciate any comments from readers about their experiences with it in case they can help me or any other readers!</p>
