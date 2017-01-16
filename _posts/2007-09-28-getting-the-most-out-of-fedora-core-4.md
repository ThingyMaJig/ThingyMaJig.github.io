---
excerpt: <p>I recently looked into which versions of software I was running and was
  a little concerned to see how <em>backward</em> <strong>Fedora Core 4</strong> was
  in some areas. I did <a href="http://www.google.co.uk/search?q=fc4+php-5.2" title="PHP
  5.2 for Fedora Core 4">a little Googling around</a> and found a website (<a title="Redhat
  Updates Repository" href="http://rpms.famillecollet.com/">http://remi.collet.free.fr/</a>)
  which is predominately written in French (but has a few English translations) which
  provides a new repository for <strong>Fedora Core 4</strong>'s <em>Yum Installer
  Package</em> which provides far more recent RPM's for the likes of <strong>PHP</strong>
  and <strong>MySQL</strong>... So I installed it!</p>
categories:
- websites
- software
- linux
- howto
- geek
- drupal
layout: post
title: Getting the most out of Fedora Core 4
created: 1190993270
permalink: blog/28-09-2007/getting-the-most-out-of-fedora-core-4
---
<p>I recently looked into which versions of software I was running and was a little concerned to see how <em>backward</em> <strong>Fedora Core 4</strong> was in some areas. I did <a href="http://www.google.co.uk/search?q=fc4+php-5.2" title="PHP 5.2 for Fedora Core 4">a little Googling around</a> and found a website (<a title="Redhat Updates Repository" href="http://rpms.famillecollet.com/">http://remi.collet.free.fr/</a>) which is predominately written in French (but has a few English translations) which provides a new repository for <strong>Fedora Core 4</strong>'s <em>Yum Installer Package</em> which provides far more recent RPM's for the likes of <strong>PHP</strong> and <strong>MySQL</strong>... So I installed it!</p>
<!--break-->
<p>The install is <strong>VERY</strong> easy... You simply visit the site and download the appropriate RPM using a program like <em>wget</em> and then you install it using the <em>RPM</em> program. Next you go to <em><strong>/etc/yum.repos.d/</strong></em> and download the repo file into that folder (again using a program like <strong>wget</strong> or <strong>curl</strong>). Finally, you tell <strong>Yum</strong> to install a <em>package</em> or just <em>update</em> your system and leave it going, for example:</p>
<pre language="bash">
sudo yum --enablerepo=remi update php
</pre>
<p>You need to tell it to enable the repository as by default it is disabled. I assume this is so you can control <strong>which</strong> packages get updated and <strong>when</strong> they get updated (you might not always want your server to be upgraded to the latest version of PHP at 4am automatically, I know I'd prefer to be present when this kind of update happens!)</p>
<p>As of now, this site is being powered by <strong>PHP 5.2.4</strong> (rather than <em>5.0.4</em> - at time of writing) and<strong> MySQL 5.0.45</strong> rather than <em>4.1.20</em> (at time of writing).</p>
