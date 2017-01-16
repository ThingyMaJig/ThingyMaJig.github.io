---
excerpt: "<p>Last night I was trying to configure SVN on a server. The setup was that
  the SVN&nbsp;Repo was on &quot;<code>srv2</code>&quot; and the frontend and code
  I wanted to import was on &quot;<code>srv1</code>&quot;.</p>\r\n<p>I created an
  <em>NFS share</em> on <code>srv2</code> and mounted it on <code>srv1</code> in <code>/mnt/svnroot</code>.
  The mount worked perfectly and I could touch and remove files from srv1.</p>\r\n<p>So
  I tried to create a &quot;<em>sites</em>&quot; folder where I wanted to import a
  site I wanted to version control. This is where I started to have problems&hellip;
  The sollution was to add &quot;nolock,bg&quot; to the mount options on the client.
  Read on for more details!</p>\r\n"
categories:
- svn
- programming
- linux
- howto
- geek
layout: post
title: SVN + NFS = svn nfs cant get exclusive lock
created: 1227610935
permalink: blog/25-11-2008/svn-nfs-svn-nfs-cant-get-exclusive-lock
---
<p>Last night I was trying to configure SVN on a server. The setup was that the SVN&nbsp;Repo was on &quot;<code>srv2</code>&quot; and the frontend and code I wanted to import was on &quot;<code>srv1</code>&quot;.</p>
<p>I created an <em>NFS share</em> on <code>srv2</code> and mounted it on <code>srv1</code> in <code>/mnt/svnroot</code>. The mount worked perfectly and I could touch and remove files from srv1.</p>
<p>So I tried to create a &quot;<em>sites</em>&quot; folder where I wanted to import a site I wanted to version control. This is where I started to have problems&hellip; The sollution was to add &quot;nolock,bg&quot; to the mount options on the client. Read on for more details!</p>
<!--break-->
<h2>NFS Configuration</h2>
<div style="margin: 0pt 0pt 0pt 5px; float: right; height: 600px; width: 160px;">[adsense:160x600:6965419571]</div>
<p>Before I continue, a little detail about the setup&hellip; The servers mentioned here are &quot;psuedo&quot; (ie not real). For the sake of the example &quot;<code>srv1</code>&quot; is <code>192.168.1.2</code> and &quot;<code>srv2</code>&quot; is <code>192.168.1.1</code>. The SVN&nbsp;Server (srv2) has the following...</p>
<pre language="bash">
[user@srv2 ~]$ cat /etc/exports
/svnroot 192.168.1.2(rw)
</pre>
<pre language="bash">
[user@srv2 ~]$ cat /etc/hosts.deny
portmap: ALL
#ADDED BY NICK
lockd:ALL
mountd:ALL
rquotad:ALL
statd:ALL
</pre>
<pre language="bash">
[user@srv2 ~]$ cat /etc/hosts.allow
portmap: srv1
#ADDED BY NICK
lockd:   srv1
rquotad: srv1
mountd:  srv1
statd:   srv1
</pre>
<p>The above shows that the folder <code>/svnroot</code> is being exported as an <strong>NFS&nbsp;share</strong> and that access to the services <code>portmap</code>, <code>lockd</code>, <code>mountd</code>, <code>rquotad</code> &amp; <code>statd</code> are denied to all, however the allow file grants access to these services for <em><code>srv1</code></em> only.</p>
<p style="clear: right;">One srv1, we have the following settings&hellip;</p>
<pre language="bash">
[user@srv1 ~]$ cat /etc/fstab
# srv2 - svn stuff
srv2:/svnroot  /mnt/svnroot  nfs  rw,hard,intr,nolock,bg  0 0
</pre>
<p>What does this do? Well it mounts the export <code>/svnroot</code> on <code>srv2</code> to the local folder <code>/mnt/svnroot</code> using <em>nfs</em> with the options <em><code>rw,hard,intr,nolock,bg</code></em>. In all honesty - I dont know what the last 2 numbers are for!</p>
<p>Using this line in the <code>fstab</code> file I can now type (as root I believe)&hellip;</p>
<pre language="bash">
[user@srv1 ~]$ mount /mnt/svnroot</pre>
<p>If this works then you can browse <code>/mnt/svnroot</code> as if it was on your local system. Now to use SVN!</p>
<div style="margin: 0px auto; width: 336px; height: 280px;">[adsense:336x280:9994499560]</div>
<h2>Configuring SVN</h2>
<p>I checked out <a title="WebSVN at Tigris" href="http://websvn.tigris.org/"><em>websvn</em></a> from <a title="Tigris website" href="http://www.tigris.org/">Tigris</a> using the following command&hellip;</p>
<pre language="bash">
[user@srv1 ~]$ svn checkout http://websvn.tigris.org/svn/websvn/trunk websvn --username guest
</pre>
<p>Once in here, I went into the includes folder and copied <em>distconfig.php</em> to <em>config.php</em>. In <em>config.php</em> I made a few changes to suit my system - the main ones were adding a repository:</p>
<pre language="php">
$config->addRepository('REPO', 'file:///mnt/svnroot/');
</pre>
<p>and teaching <em>websvn</em> that files ending in .module are actually PHP files:</p>
<pre language="php">
$extEnscript['.module'] = 'php';
</pre>
<p>After that it was a <em>simple</em> matter of adding a VHost to bind a domain to my <em>websvn</em> install.</p>
<h2>Using SVN</h2>
<p>The problems really kicked in after all the above steps when I actually tried to <strong>USE</strong> SVN. When I&nbsp;tried to SVN to import a project by running this (on <code>srv1</code>)&hellip;</p>
<pre language="bash">
svn mkdir file:///mnt/svnroot/sites -m "Creating sites folder"
</pre>
<p>&hellip; I was presented with an interesting error claiming&hellip;</p>
<blockquote><pre>
svn nfs cant get exclusive lock
</pre></blockquote>
<p>After doing a little research I found an interesting post on <a title="Woss.Name blog" href="http://woss.name"><em>woss.name</em></a> by <a title="How to fix SVN over NFS Shares" href="http://woss.name/2005/08/25/subversion-and-nfs-file-locking/#comment-336"><em>Byung-chul Lee</em></a> about how he (or she?) fixed the same issue. The suggestion of adding &quot;<code>bg,nolock</code>&quot; to the mount options on the client fixed the locking issues! I don't know what the side effects will be though.</p>
