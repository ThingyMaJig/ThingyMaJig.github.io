---
excerpt: "<p>I've recently been receiving some spam from some Russian IP's. As each
  spam attempt was from a different IP, blocking individual ones was a little futile
  and time consuming. I did a quick Google and ended up at <a href=\"http://drupal.org/user/972\"
  title=\"David Kent Norman's Drupal Profile\">Deekayen</a>'s <a href=\"http://deekayen.net/\"
  title=\"David Kent Norman's Online Blog - Block Comments from Russia\">website</a>
  as it seems he has had similar issues. <a title=\"Block comment spam from Russia\"
  href=\"http://deekayen.net/block-comment-spam-russia\">His solution</a> was an Apache
  level &quot;Deny&quot;&hellip; My solution uses <strong><em>iptables</em></strong>.</p>\r\n"
categories:
- websites
- security
- programming
- linux
- howto
- drupal
layout: blog
title: From Russia without Love
created: 1178620664
permalink: blog/08-05-2007/spamming-russians
---
<p>I've recently been receiving some spam from some Russian IP's. As each spam attempt was from a different IP, blocking individual ones was a little futile and time consuming. I did a quick Google and ended up at <a href="http://drupal.org/user/972" title="David Kent Norman's Drupal Profile">Deekayen</a>'s <a href="http://deekayen.net/" title="David Kent Norman's Online Blog - Block Comments from Russia">website</a> as it seems he has had similar issues. <a title="Block comment spam from Russia" href="http://deekayen.net/block-comment-spam-russia">His solution</a> was an Apache level &quot;Deny&quot;&hellip; My solution uses <strong><em>iptables</em></strong>.</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<p>See, if someone is coming to my site with mal-intent, ideally I dont want them near the server - much less the site! Even with <em>Apach Deny</em> rules, each spam attempt will be costing me bandwidth + a server hit. Additionally, if I were to do a site Drupal upgrade then its quite likely my <em>.htaccess</em> would get overwritten thus opening me up to spam again.</p>
<p>My solution requires root access to your server and that the server be running a version of Linux (I'm pretty sure they all ship with iptable's now). Initially, I simply did the following - assuming 123.123.123.123 is the offending IP:</p>
<pre language="bash">
iptables -I INPUT -s 123.123.123.123 -j DROP
</pre>
<p>The manual page for iptables defines <strong>DROP </strong>as:</p>
<blockquote>
<p><strong>DROP </strong>means to drop the packet on the floor</p>
</blockquote>
<p>The problem with this is that for every offending IP, you would need to add a rule in. What if you KNEW that every ip in the 123.123.123.0 - 123.123.123.255 range was going to offend. Well, there are a number of ways to do this. One uses a <strong><em>subnet mask</em></strong> and the other (untested) uses the <em>iptables</em> <strong><em>ip-range</em></strong> facility.</p>
<h2>Subnet Sollution</h2>
<p>This method is EXACTLY the same as the previous example however you slightly change the IP address&hellip;</p>
<pre language="bash">
iptables -I INPUT -s 123.123.123.0/24 -j DROP
</pre>
<p>The <em><strong>/24</strong></em> on the end tells iptables that the <em><strong>source</strong></em> address should me a 24 bit mask of 123.123.123.0. For more information on subnetting an IP - please read <a href="http://en.wikipedia.org/wiki/Subnetwork" title="Subnetwork Article">this Wikipedia artcle</a> on the subject. I dont know a lot about it&hellip;</p>
<h2>IP-Tables IP-Range Solution</h2>
<p>I didn't personally use this method - mainly because it was less effort to block the entire range rather than a specifc smaller range, however this solution provides finer control over what actually gets blocked. For example, you might not want to block 123.123.123.0 - 123.123.123.255 - you might only want to block 123.123.123.15 - 123.123.123.23 inclusively. As I said, I haven't personally tried this method, however it is a suggested alternative in a forum post over at ServerBeach.com about <a href="http://forums.serverbeach.com/showthread.php?t=5075#post29691">Blocking an IP Range</a>. This is example given in that forum by <em><a href="http://forums.serverbeach.com/member.php?u=2087">aryani</a></em>.</p>
<pre language="bash">
iptables -I INPUT -m iprange --src-range 123.123.123.15-123.123.123.23 -j DROP
</pre>
<p>The manual page describes it as follows&hellip;</p>
<blockquote>
<h3>iprange</h3>
<p>This matches on a given arbitrary range of IPv4 addresses</p>
<dl> <dt><strong><em>[!]--src-range </em></strong><em>ip-ip</em></dt> <dd>Match source IP in the specified range.</dd> <dt><em><strong>[!]--dst-range </strong>ip-ip</em></dt> <dd>Match destination IP in the specified range.</dd> </dl></blockquote>
<p>[adsense:468x60:4496506397]</p>
<p>I cannot find any mention of the &quot;-m iprange&quot; part in the manual though. I wonder if that's OS-specific.</p>
<h2>Where do I find these IP address things?</h2>
<p>Well, you have a number of options. I have the Spam module installed on this site so anything that is considered spam will go there first to be moderated. The Spam module logs the IP address of anything it considers spam however Drupal doesn't (unfortunately) log the IP address of commenter's by default. Maybe there is a module which will do this?</p>
<p>If you have access to the server logs, you could search through them for attempted connections to your site's comment script. With linux - this is VERY easy, for example:</p>
<pre language="bash">
grep 'comment/reply' /path/to/logs/httpd/my_log
</pre>
<p>That will search for anything with 'comment/reply' in it. I'm sure a linux and/or regular expression guru could work up something &quot;better&quot;, but thats a basic example. If there are too many results, you can always <a href="http://www.linfo.org/pipe.html">pipe </a>the results to a reader like <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?less">less</a> or <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?more">more</a>. Most logs will also contain the date/time that this access attempt happened plus a note of if it was a <em>GET</em> or <em>POST</em> request.</p>
<p>One other option is that could lookup common IP's from a blacklisting website.</p>
<h2>What website could I use for this? Could I help?</h2>
<p>Why yes - of course you could help!</p>
<p>Enter <a title="Project Honey Pot" href="http://www.projecthoneypot.org/">Project Honey Pot</a> which is a really cool community driven anti-spam site. You can register for free and you gain access to a list of IP addresses which have been logged spamming in some way. If you feel generous, you could host a &quot;Honey Pot&quot; on your website which can help them find new or existing <a href="http://en.wikipedia.org/wiki/E-mail_address_harvesting" title="Email Address Harvesting">harvesters</a>. I've set one up on this site - it can be seen <a href="/witness.php" title="Honey Pot">here</a>.</p>
<p>If you're feeling particularly generous, you can also offer a subdomain (or maybe full domain) for spamming. Basically, you add an MX record to a subdomain of your own domain to point at one of <em>Project Honey Pot</em>'s MX server's. This is only likely only be possible through a decent Registrar, 123reg doesn't seem to support it. Any email that gets sent to this subdomain (eg, <em>somebody@subdomain.thingy-ma-jig.co.uk</em>) will get sent to Project Honey Pot and they can analyse it for spam. If it is spam - they make a note of the source IP. I don't KNOW, but I assume these email addresses get used on the <strong>Honey Pot</strong> pages.</p>
<p>There are <u>LOADS</u> of services out there to help out with spam. Most simply offer a service to block spam on your website, for example <a href="http://akismet.com/">Akismet</a>. Personally I dont want these people on my site. If all they're going to do is waste my time tidying up after them and waste my server resources (such as CPU cycles and bandwidth) then they can simply not have access (this reminds me of a parental approach on toys - &quot;<em>if you cant play with it sensibly then you cant play with it at all</em>&quot;). I'd much rather a situation where as soon as a known spammer tries to get to my site, they get turned down at the door for EVERYTHING. The knock on advantage of turning away spammers is that it reduces my illegitimate hits and therefore my Google Adsense CTR (<em>Click Through Rate</em>) might go up therefore increasing the value of a click on my site.</p>
<p>I'd be interested to hear what methods others are using to protect themselves - Drupal or otherwise!</p>
