---
excerpt: "<p>I recently needed to remotely copy over SSH a folder from the remote
  machine to my local machine. Usually this is not a problem, however the path to
  this folder had a space in it. The folder itself is rather large and contains files
  which wouldn't really benefit from compression. It turns out the solution was quite
  simple.</p>\r\n"
categories:
- mac
- linux
- howto
- geek
layout: post
title: How to SCP a path with spaces
created: 1179138300
permalink: blog/14-05-2007/how-to-scp-a-path-with-spaces
---
<p>I recently needed to remotely copy over SSH a folder from the remote machine to my local machine. Usually this is not a problem, however the path to this folder had a space in it. The folder itself is rather large and contains files which wouldn't really benefit from compression. It turns out the solution was quite simple.</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<p>These instructions are assuming you're connecting from a unix-like system to a unix-like system (eg Linux or OSX).</p>
<pre language="bash">
scp -r myserver.com:"/path/with/a/Space\\ In\\ It" ./
</pre>
<p>This basically says &quot;<em><strong>recursively copy</strong> the folder at <strong>myserver.com</strong> (using the <strong>local username</strong>) to the <strong>current folder</strong> using <strong>scp</strong></em>&quot;. Now the spaces need to be double escaped as the first escape only signifies that they're spaces on the LOCAL machine - by the time they got to the remote machine, they wouldn't be escaped anymore. By double escaping them locally, by the time the path makes it to the remote machine they are just single escaped. I have to admit - I'm not 100% sure why you need the double quotes around the path itself.</p>
<p>Personally, I tend to run the <code>scp</code> command within a separate <a title="GNU Screen Command" href="http://en.wikipedia.org/wiki/GNU_Screen"><em>screen</em></a> so I can detach it and reattach it later. It also means that if my connection from my machine to the machine I'm SSH'd to (be it local or remote) drops or crashes, the process will continue to run and I can reattach the screen when I reconnect.</p>
