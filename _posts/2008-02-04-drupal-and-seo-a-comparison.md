---
excerpt: "<p>I've recently been noticing a trend in how other websites are handling
  <em>Clean URLs</em> and it isn't good! Most websites don't appear to have the same
  luxury we have with Drupal (a concrete URL Alias system provided by the Path module).
  Although the <em>URL Aliases</em> can sometimes be a bit of a burden on larger sites,
  as the table can easily enter the tens or evey hundreds of thousands of entries,
  it provides (if used correctly) a very effective 1:1 relationship.</p>\r\n"
categories:
- seo
- review
- geek
- drupal
layout: blog
title: 'Drupal and SEO: A comparison'
created: 1202167237
permalink: blog/04-02-2008/drupal-and-seo
---
<p>I've recently been noticing a trend in how other websites are handling <em>Clean URLs</em> and it isn't good! Most websites don't appear to have the same luxury we have with Drupal (a concrete URL Alias system provided by the Path module). Although the <em>URL Aliases</em> can sometimes be a bit of a burden on larger sites, as the table can easily enter the tens or evey hundreds of thousands of entries, it provides (if used correctly) a very effective 1:1 relationship.</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<h2>The Old Way</h2>
<p>Most sites implement a cheat clean URL system where the path contains the ID or a 'source path' (in Drupal Lingo) very early on in the path. The rest of the path tends to simply be keyword stuffed. This is achieved using URL Rewrites which, put simply, will ignore everything after a certain pattern has been matched. There are many examples of this technique... Here are a few (with slight variants):</p>
<ul>
    <li>
    <p><a title="Best Pub in the UK" rel="nofollow" href="http://www.beerintheevening.com/pubs/s/13/1316/Wenlock_Arms/Hoxton">http://www.beerintheevening.com/pubs/s/13/1316/Wenlock_Arms/Hoxton</a></p>
    </li>
    <li>
    <p><a title="Drupal Book" rel="nofollow" href="http://cgi.ebay.co.uk/Drupal-by-David-Mercer-2006_W0QQitemZ110210852486QQihZ001QQcategoryZ2228QQrdZ1QQssPageNameZWD1VQQtrksidZp1638.m118.l1247QQcmdZViewItem">http://cgi.ebay.co.uk/Drupal-by-David-Mercer-2006_W0QQi.....l1247QQcmdZViewItem</a></p>
    </li>
    <li>
    <p><a title="SEO SEO News" rel="nofollow" href="http://www.seoseonews.com/articles/5582/1/-Great-Blogging-Resources--How-to-Find-Information-and-Ideas/-Great-Blogging-Resources--How-to-Find-Information-and-Ideas.html">http://www.seoseonews.com/articles/5582/1/-Gre........d-Information-and-Ideas.html</a></p>
    </li>
</ul>
<p>The above links share the same thing - the unique ID is towards the beginning of the URL and everything after a specific point is either ignored completely or is considered unnecessary.</p>
<div style="float: right; width: 336px; height: 280px;">[adsense:336x280:9994499560]</div>
<p>The <em>BeerInTheEvening</em> site only requires the 'pub/s/13/1316' part - everything else is simply ignored.</p>
<p>Ebay do it slightly differently, they appear to have everything in one long path with no slashes - but they use 'QQ' to separate arguments and Z to separate key/value pairs - how sneaky! Therefore the pattern Ebay expects is (at minimum) '{some_title}QQitemZ{some_id}'. Some testing shows that the {some_title} appears unchangeable - however the rest of the URL is very changeable. Maybe the title is part of the ID?</p>
<p>The article at seoseonews.com is very similar to BeerInTheEvening. It appears to basically tag the keywords onto the end of the URL in the hope that Google will index that instead of the &quot;true&quot; URL which actually doesn't need anthing on the end at all!</p>
<h2>The New Way</h2>
<p>Recently I've noticed that some sites are trying to be slightly more cunning... Amazon for example...</p>
<p><a title="Drupal Book on Amazon" rel="nofollow" href="http://www.amazon.co.uk/Adobe-Flash-Pro-CS3-Mac/dp/B000O17CGU/ref=sr_1_3">http://www.amazon.co.uk/Adobe-Flash-Pro-CS3-Mac/dp/B000O17CGU/ref=sr_1_3</a></p>
<p>I was looking for Adobe Flash CS3 for the Mac and I looked at the URL and decided to have a play with it to find out what was necessary to get the page to load. First thing that came off was what looked like the referring source - that was an easy one. I then started to work backwards from there and found that not many arguments could be removed at all! It was at that point I wondered if they'd been sneaky... Did they need the first part of the URL? Answer: <strong>No</strong>!</p>
<p><a href="http://www.amazon.co.uk/dp/B000O17CGU">http://www.amazon.co.uk/dp/B000O17CGU</a></p>
<p>Since finding this out I have found a number of other sites which are actually doing exactly the same thing (eg, DeviantArt.com). Instead of keyword stuffing the end of the path - they are pre-stuffing the URL and putting the ID on the end.</p>
<p>Why do this? Well the keywords important to the page appear at the beginning of the URL rather than the end. As Tesco say; <em>Every Little Helps</em>! &copy;</p>
<h2>Why is this bad?</h2>
<p>Well one thing you learn in SEO-101 is that Google &amp; Co. do NOT like it when sites represent the same content on multiple URL's, commonly known as <a title="Duplicate Content" rel="nofollow" href="http://www.google.com/support/webmasters/bin/answer.py?answer=66359">Duplicate Content</a>. Google has a tendancy when it finds these sites to take a &quot;<em>hammer to kill a fly</em>&quot; approach and blacklist the site without warning or explanation.</p>
<h2>The Drupal Way</h2>
<p>The way drupal handles the URL's is pretty neat - especially the clean ones. You simply define what path you'd like to map to the source path and drupal handles it all internally. If the alias path doesn't match anything in the database then you don't get a matching source path.</p>
<p>Of course, as soon as you enable the path module and create your first alias you have created Duplicate Content. Why? Well you can still access the node on its source path (eg, http://example.com/node/12) <u>and</u> on its nice new alias (eg, http://example.com/my-nice-alias.html). Currently Drupal does not handle this internally which is why I have developed the <strong><em>GlobalRedirect</em></strong> module. This module simply checks that the currently accessed path has no alias associated. If it does then it will do a permanent redirect (301) to the proper path.</p>
<p>What if you dont want to have to keep filling out the alias field every time? What if you dont want to hand site structure control over to the masses on your nice new &amp; funky Web 2.0 site? Enter <em><strong>PathAuto</strong></em> (along with <em><strong>Tokens</strong></em>). When these two pair up - Drupal will automatically generate paths for you based on whatever template you configure for your node type (or taxonomy term... or user...)!</p>
<p>&quot;What about other SEO stuff like Page Titles and Meta Data? &quot; I hear you cry! All taken care of by another module I maintain (along with John Albin) is called <em><strong>PageTitle</strong></em>. Version 1.x only allows basic control of the page title template, however <em><strong>PageTitle 2</strong></em> is currently in beta testing and has some VERY funky features! This new release is another <em><strong>Token</strong></em>-powered module which works in a similar way to <em><strong>PathAuto</strong></em>. You provide a token template on a per node-type basis along with (optionally) specifying a separate page title for the node (ie, you get a <em>NODE TITLE</em> (for links, H1's, etc) and a <em>HEAD TITLE</em> for the Search Engines). The module takes care of the rest.</p>
<p>MetaTags? Easy - checkout the fantastic <em><strong>NodeWords</strong></em> module. Unfortunately this isn't token powered (yet - hint hint!) so you cant setup token template descriptions, however it will automatically&nbsp; take the node teaser as the description and take the node's taxonomy as keywords for you! You can also setup some site-wide defaults too.</p>
<h2>Summary</h2>
<p>All in all - I think Drupal is pretty damn SEO friendly - especially compared to some other CMS's (and ESPECIALLY when you look at how easy it is to turn your website into and SEO dream!). What else does the community use for SEO for Drupal?</p>
<h2>References</h2>
<p>I've mentioned a few modules above - here are their links:</p>
<ul>
    <li><a title="Global Redirect SEO Module" href="http://drupal.org/project/globalredirect">GlobalRedirect</a></li>
    <li><a title="Page Title SEO Module" href="http://drupal.org/project/page_title">PageTitle</a></li>
    <li><a title="Path Auto SEO Module" href="http://drupal.org/project/pathauto">PathAuto</a></li>
    <li><a title="Tokens Module - dependancy for the above SEO Modules" href="http://drupal.org/project/token">Tokens</a></li>
    <li><a title="Nodewords SEO Module" href="http://drupal.org/project/nodewords">Nodewords</a></li>
</ul>
<p>&nbsp;</p>
