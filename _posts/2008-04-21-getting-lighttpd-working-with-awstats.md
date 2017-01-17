---
excerpt: "<p>Following my previous post about <a title=\"Powered by Lighttpd\" href=\"http://www.thingy-ma-jig.co.uk/blog/16-04-2008/powered-lighttpd\">configuring
  Lighttpd on this VPS Webserver to replace Apache</a> I bring you a guide to configuring
  AWStats under <a title=\"All things Lighttpd\" href=\"http://www.thingy-ma-jig.co.uk/tags/lighttpd\">Lighttpd</a>.
  This process is differs to Apache as control of directories and aliasing is handled
  differently. There can also be complications if you have previously enabled the
  Drupal LUA Magnet script on your site for clean URL handling!</p>\r\n"
categories:
- linux
- lighttpd
- howto
- geek
- drupal
- bash
layout: blog
title: Getting Lighttpd working with AWStats
created: 1208787527
permalink: blog/21-04-2008/getting-lighttpd-working-with-awstats
---
<p>Following my previous post about <a title="Powered by Lighttpd" href="http://www.thingy-ma-jig.co.uk/blog/16-04-2008/powered-lighttpd">configuring Lighttpd on this VPS Webserver to replace Apache</a> I bring you a guide to configuring AWStats under <a title="All things Lighttpd" href="http://www.thingy-ma-jig.co.uk/tags/lighttpd">Lighttpd</a>. This process is differs to Apache as control of directories and aliasing is handled differently. There can also be complications if you have previously enabled the Drupal LUA Magnet script on your site for clean URL handling!</p>
<!--break-->
<p>Firstly, lets define a few things&hellip;</p>
<ul>
    <li>AWStats <em><code>wwwroot</code></em> is <code>/usr/share/awstats/wwwroot</code> (the folder which contains the <code>cgi-bin</code> and <code>icon</code> folders</li>
    <li>AWStats configuration files are in <code>/etc/awstats</code>.</li>
    <li>I have downloaded, and placed in my cgi-bin folder, <a href="http://www.telartis.nl/xcms/awstats">awstatstotals.php</a>.</li>
</ul>
<p>[adsense:468x60:4496506397]</p>
<p>Ok, firstly I want to add the following to my Lighttpd configuration&hellip;</p>
<pre>
#RULES FOR AWSTATS
alias.url += (
  "/js/awstats_misc_tracker.js" => "/usr/share/awstats/wwwroot/js/awstats_misc_tracker.js"
)

$HTTP["url"] =~ "^/awstats" {
  alias.url += (
    "/awstats/"      => "/usr/share/awstats/wwwroot/cgi-bin/",
    "/awstatsicons/" => "/usr/share/awstats/wwwroot/icon/",
  )

  global {
    server.modules += ( "mod_cgi", "mod_auth" )
  }


  $HTTP["remoteip"] !~ "123.123.123.123" {
    # Configure Authentication
    auth.debug = 2
    auth.backend = "plain"
    auth.backend.plain.userfile = "/path/to/passwords/file"

    # We've already restricted the folder
    auth.require = ( "" => (
        "method" => "basic",
        "realm" => "Stats Area",
        "require" => "valid-user",
      )
    )
  }

  index-file.names = ( "awstatstotals.php" )

  cgi.assign = (
    ".pl" => "/usr/bin/perl",
    ".cgi" => "/usr/bin/perl"
  )
  magnet.attract-physical-path-to = ()
}
</pre>
<div style="margin: 0px 0px 8px 8px; float: right;">[adsense:160x600:6965419571]</div>
<p>Lets have a run through this&hellip;</p>
<ul>
    <li>
    <p>The first <code>url.alias</code> simply tells Lighttpd to globally create an alias of that javascript file for all sites. This allows those sites to have AWStats track a little more information about the visitor. This also saves us copying it into a folder for every website.</p>
    </li>
    <li>
    <p>Next up we have a line which tells <a title="Lighttpd articles" href="/tags/lighttpd">Lighttpd</a> to ONLY apply the following settings for pages served within &quot;<code>/awstats</code>&quot;. The initial '<code>^</code>' is regular expression for <em>begins with</em>.</p>
    </li>
    <li>
    <p>Next up we define 2 new alises. These aliases ONLY apply for requests from within the path &quot;<code>/awstats</code>&quot;. The first points the &quot;<code>/awstats</code>&quot; path to the <em>AWStats</em> cgi-bin folder. The other aliases the icons folder. This is necesary as we have made the <code>cgi-bin</code> folder the &quot;root&quot;. We could get away with just one alias if we made the <code>wwwroot</code> folder the root instead&hellip; but we haven't :-)</p>
    </li>
    <li>
    <p>Next up we enable some modules. The <code>mod_cgi</code> module is useful if you wanna run things like Perl scripts. The other module, <code>mod_auth</code>, is useful if you wanna protect your folder with a password. I don't know this for certain, but I'd hazard a guess that these modules only get loaded for this particular path. I'm not sure though, cant find any documentation implying or proving either way.</p>
    </li>
    <li>
    <p>Next up we do some permissions. In this case I would mostly be accessing the stats from the IP <code>123.123.123.123</code> (<em>yes, this IS an <strong>example</strong>!</em>), so I want to tell Lighttpd to ONLY run the <em>access deny check</em> if the remote IP isn't this example. I've done it as a RegEx right now so it will be easy for me add other IPs to exclude authorization from in the future. Within this we enable and configure the <a href="http://trac.lighttpd.net/trac/wiki/Docs%3AConfigurationOptions#Optionsformod_auth-authenticationmodule" title="Lighttpd Mod Auth Settings">Lighttpd Mod Auth Settings</a>.</p>
    </li>
    <li>
    <p>Next up we tell Lighttpd to use the <code>awstatstotals.php</code> script as the index file. This provides me with a nice monthly, server-level overview of stats. Its quite handy!</p>
    </li>
    <li>
    <p>Almost there&hellip; We now tell <a title="Lighttpd articles" href="/tags/lighttpd">Lighttpd</a> some <code>CGI</code> settings (for <code>mod_cgi</code>). Here, we teach it what applications to associate with given file extensions.</p>
    </li>
    <li>
    <p>The final <em><code>Magnet</code></em> line is one I have to put in as I'm running a Drupal site. In the one of the following posts I will explain how I got Drupal running on <a title="Lighttpd articles" href="/tags/lighttpd">Lighttpd</a> - but for now suffice to say that you need to tell <a title="Lighttpd articles" href="/tags/lighttpd">Lighttpd</a> to use a funky LUA script to get the Clean URL's working. I believe this is to do with telling it to serve non-existant URL's via Drupal's &quot;q&quot; argument.</p>
    </li>
</ul>
<p>Thats about it guys! Once I got it working, it was pretty simple.</p>
<p>Oh - one final hint&hellip; Make sure you enable <code>mod_alias</code> BEFORE you go onto the <a title="Lighttpd articles" href="/tags/lighttpd">Lighttpd</a> IRC chat and ask why your aliases aren't working. This tip was brought to you by &quot;<em>the guy who feels really stupid for asking a question which doesn't really need asking</em>&quot;.</p>
