---
excerpt: "<p>Firstly - <strong>YAFC</strong>? <em>&quot;What on earth is YAFC?&quot;</em>
  I hear you say. <a href=\"http://yafc.sourceforge.net/\" title=\"YAFC Homepage\"><strong>YAFC</strong></a>
  is a command line FTP tool which, unfortunately, only comes in source code which
  means you need to know how to compile it. Fortunately, compiling it is easy - it
  required very few dependencies and most of those I could install using <strong>yum</strong>
  on my linux box (Redhat Fedora).</p>\r\n"
categories:
- review
- linux
- howto
layout: post
title: YAFC as an FTP Client
created: 1170413118
permalink: blog/02-02-2007/yafc-as-an-ftp-client
---
<p>Firstly - <strong>YAFC</strong>? <em>&quot;What on earth is YAFC?&quot;</em> I hear you say. <a href="http://yafc.sourceforge.net/" title="YAFC Homepage"><strong>YAFC</strong></a> is a command line FTP tool which, unfortunately, only comes in source code which means you need to know how to compile it. Fortunately, compiling it is easy - it required very few dependencies and most of those I could install using <strong>yum</strong> on my linux box (Redhat Fedora).</p>
<!--break-->
<p>The main reason I chose to use <strong>YAFC</strong> over something like the built in FTP client was due to its ability to recursively FTP contents. As part of my day job, I had to transfer an entire website from a shared host (with XCalibre) to our company dedicated server (hosted by <strong><a href="http://www.rackspace.co.uk" title="Rackspace">Rackspace</a></strong>). Unfortunately, the shared server didn't allow shell access so there was no way I could make a <em>compressed tarball</em> of the site which would have made my life a lot easier. On top of this, the site was many levels deep with folders within folders within folders! This would have made FTP without recursion a nightmare. Transferring it in-house with a GUI client like <a href="http://filezilla.sourceforge.net/" title="Filezilla FTP Client">FileZilla</a> and then back out again would have taken hours due to the site's size&hellip; This is where <strong>YAFC</strong> stepped in!</p>
<h2>YAFC - the shell friendly ftp client!</h2>
<div style="float: left; margin: 0px 10px 0px 0px;">[adsense:120x600:8582050831]</div>
<p>As the site was huge and the process was going to take a while, my first step was to use the <em>screen</em> command to open up a new 'virtual window'. Once the process was started I could detach this window (and even disconnect from the server altogether) and the process would continue to run in a detached screen which I could then re-attch at a later time by executing <code>screen -r</code> (or, if there were multiple detached screen's, I could list them by <code>screen -list</code> and then reattach using the ID from the list after the '-r' argument, eg <code>screen -r 8715</code>). <strong><code>Screen</code></strong> is one of the most useful linux commands I have found!</p>
<p>At this new screen, I connected to the server by issuing the command in this form (details have been changed for privacy reasons):</p>
<pre language="bash">yafc ftp://joebloggs@myserver.com</pre>
<p>YAFC then connects to the server and authenticates (if necessary). I then executed the command <code>get -r *</code> which tells YAFC to get all files and folders recursively off the remote server. You can replace <em>get</em> with <em>put</em> if you want to upload rather than download.</p>
<p>Once this was going - I pressed Ctrl and A together, then the d key on its own - this is the keyboard combination to detach a screen. I then clossed the <a href="http://www.chiark.greenend.org.uk/~sgtatham/putty/" title="Putty SSH is a client for windows">Putty</a> window and got on with some other work for an hour or so. I logged back in later on and retrieved the screen using the above retrieval code (<code>screen -r</code>) and the entire site had transferred across flawlessly.</p>
<p>Today I have also found out (from the <a href="http://sourceforge.net/mailarchive/forum.php?thread_id=1837272&amp;forum_id=3385" title="YAFC Mailing List">YAFC mailing list archive</a>) that you can pass a text file with command in it to YAFC to execute. This is not an intentional feature, according to the author of this program, however it seems to work!</p>
<p>I used YAFC's bookmarking feature to store the login details to my backup server and now I can (in theory) use cron to automatically run YAFC to transfer my locally backed up files onto the remote server!</p>
<p>YAFC is one hell of a good (and lightweight) FTP Client and I'm glad I installed it.</p>
