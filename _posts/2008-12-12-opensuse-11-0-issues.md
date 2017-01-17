---
excerpt: "<p>After about 4 days of using OpenSUSE 11.0, I'm not overly impressed with
  it in comparison to RedHat Enterprise 3/4/5, CentOS 5, Fedora 9 and Ubuntu 8.x (other
  distro's I've used). OpenSUSE has some annoying habits and default/unusual configurations&hellip;</p>\r\n"
categories:
- linux
- howto
- geek
layout: blog
title: OpenSuse 11.0 Issues
created: 1229094927
permalink: blog/12-12-2008/opensuse-110-windows-putty-ssh-no-home-key
---
<p>After about 4 days of using OpenSUSE 11.0, I'm not overly impressed with it in comparison to RedHat Enterprise 3/4/5, CentOS 5, Fedora 9 and Ubuntu 8.x (other distro's I've used). OpenSUSE has some annoying habits and default/unusual configurations&hellip;</p>
<!--break-->
<ol>
    <li>
    <p>Home Key when using PuTTy in Windows&hellip; By default, in <code>/etc/inputrc</code> on lines 136, the Home key is configured to do something entirely different to the normal &quot;beggining of line&quot; action which <strong>every other</strong> distro does. Good old Google to the rescue - all questions have been <a title="Fixing the Home key in SUSE over SSH" href="http://linux.derkeiler.com/Newsgroups/alt.os.linux.suse/2008-01/msg00584.html">asked before</a>. It seems this 'feature' has been present for a while! Simply remark out lines 135-136 so it looks like this.</p>
    <pre language="bash">
#
# Home and End
#
$if term=xterm
#
# Normal keypad and cursor of xterm
#
#&quot;\e[1~&quot;:       history-search-backward
#&quot;\e[4~&quot;:       set-mark
</pre></li>
    <li>
    <p>DNS Issues. The server is joined to a domain - <code>example.local</code>, for example. It took days for us to find out that OpenSUSE 11 - for some reason - doesn't resolve ANY <code>.local</code> domains over DNS unless you <strong>EXPLICITLY</strong> tell it to. So, <code>dig foobar.example.local</code> will resolve, but <code>dig foobar</code> will not resolve (will return <strong><code>SERVFAIL</code></strong>). This issue has many knock on effects.</p>
    <ul>
        <li>
        <p>It makes it VERY&nbsp;hard to join the box to a domain as it refuses to find the server once the domain has been suffixed</p>
        </li>
        <li>
        <p>As a a webserver, if any pages try to <em>curl</em> or simple loads a script from themselves (eg, Drupal's cron.php), then you <strong>have</strong> to define the website's name in <em>/etc/hosts</em> otherwise the server cannot &quot;see&quot; itself.</p>
        </li>
        <li>
        <p>SSH&nbsp;logins take about 10 seconds while the server tries to reverse lookup the machine name on the local network. Again - the &quot;sollution&quot; is to define your client name in <em>/etc/hosts</em>.</p>
        </li>
    </ul>
    </li>
    <li>
    <p>No <strong>yum</strong> or <strong>apt-get</strong>. SUSE uses <strong>Yast</strong>. Unless I'm doing something very wrong (which is likely) then Yast is so much more overcomplicated than it needs to be. I&nbsp;cant simply type &quot;<em>yum install httpd</em>&quot; or &quot;<em>apt-get install apache2</em>&quot;&hellip; oh no&hellip; I have to load <strong>Yast</strong> and then use the keyboard to scroll through all the awkward interfaces using a combination of arrow keys and tabs.</p>
    </li>
</ol>
<p>Oh the rage&hellip;</p>
