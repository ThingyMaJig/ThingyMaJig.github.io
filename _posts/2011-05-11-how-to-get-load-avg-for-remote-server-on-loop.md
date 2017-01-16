---
categories:
- bash
- linux
- howto
layout: post
title: How to get Load AVG for remote server on loop
created: 1305125506
permalink: blog/11-05-2011/how-to-get-load-avg-for-remote-server-on-loop
---
<p>This handy script will allow you to get the current Load Average (<code>loadavg</code>) for a remote server over SSH. It will stream the result set back to you, which you can then pipe into a file if you need to.</p>
<p>This would be handy for monitoring the load of a server while stress testing, for example.</p>
<div><!--break--></div>
<pre language="bash">
ssh example.com 'while true; do L=$(awk '\''{ print $1 }'\''  /proc/loadavg); D=$(date +%H:%M:%S); echo -e "$D\t$L"; sleep 1; done'
</pre>
<p>One point of note is the escaping single quote technique. This is based on the suggestion on <a href="http://muffinresearch.co.uk/archives/2007/01/30/bash-single-quotes-inside-of-single-quoted-strings/">Muffin Research on how to escape single quotes within single quotes</a>.</p>
<p>As the result is tab-separated, it would be very easy to get the data into a spreadsheet and generate a graph of it.</p>
