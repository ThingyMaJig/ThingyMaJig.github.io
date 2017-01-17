---
excerpt: "<p>I've been working on it for a few days now, but its finally released.
  <strong>Social Statistics</strong> is being used on this site and can be found on
  any page on an enabled site in a block. It provides <em>pluggable statistics</em>
  for (currently) 3 major <em>Social Networking</em> websites; <em><strong>Del.icio.us</strong></em>,
  <em><strong>Digg</strong></em> and <strong><em>Ma.gnolia</em></strong>. It currently
  boasts <strong>caching of statistics</strong> for a configurable amount of time,
  <strong>AHAH retrieval of statistics</strong> which are not cached (thus not slowing
  down page loads) and an API to make the project extendible to anybody who cares
  to add a <em>Social Network</em> to the mixture!</p>\r\n<p>The core module consists,
  mostly, of a few menu callbacks and an API. This API allows the user to enable any
  number of enabled modules to add their contribution to the block. The 3 enabled
  sites all have an XML based API, but each does things slightly differently - hence
  my choice in using them as examples of the module as a whole.</p>\r\n<p>You can
  find this module over <a href=\"http://drupal.org/project/social_statistics\">in
  the Drupal Projects section</a>.</p>\r\n"
categories:
- software
- free
- drupal
- announcement
layout: blog
title: Social Statistics module released
created: 1178923582
permalink: blog/11-05-2007/social-statistics-module-released
---
<p>I've been working on it for a few days now, but its finally released. <strong>Social Statistics</strong> is being used on this site and can be found on any page on an enabled site in a block. It provides <em>pluggable statistics</em> for (currently) 3 major <em>Social Networking</em> websites; <em><strong>Del.icio.us</strong></em>, <em><strong>Digg</strong></em> and <strong><em>Ma.gnolia</em></strong>. It currently boasts <strong>caching of statistics</strong> for a configurable amount of time, <strong>AHAH retrieval of statistics</strong> which are not cached (thus not slowing down page loads) and an API to make the project extendible to anybody who cares to add a <em>Social Network</em> to the mixture!</p>
<p>The core module consists, mostly, of a few menu callbacks and an API. This API allows the user to enable any number of enabled modules to add their contribution to the block. The 3 enabled sites all have an XML based API, but each does things slightly differently - hence my choice in using them as examples of the module as a whole.</p>
<p>You can find this module over <a href="http://drupal.org/project/social_statistics">in the Drupal Projects section</a>.</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<h2>Del.icio.us</h2>
<p><em>Del.icio.us</em> is probably the most simple of the modules. You may notice that <a href="http://del.icio.us/url/7a9b3373e7b6118792f93c588310c48e">every bookmark</a> in <em>Del.icio.us</em> has a 32 character code on the end of it which looks uncannily like and MD5. Thats quite a coincidence because it IS an MD5 - of the target URL. You may also notice <a href="http://del.icio.us/rss/url/7a9b3373e7b6118792f93c588310c48e">it has an RSS feed too</a>. All this module needs to do is go out there and grab the RSS feed for the current URL and, assuming the server returned a &quot;200 OK&quot; status (rather than 503 or 404, etc) then you can go ahead and parse the XML. Easy!</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<h2>Ma.gnolia</h2>
<p>This is almost the same as <em>Del.icio.us</em>, but has a few key differences. Firstly, their API isn't as public as <em>Del.icio.us</em> - you need to sign up and activate a key for your account. This is the feature which caused me to add the 'settings' operation to the <em><strong>Social Statistics API</strong></em> which allows you to tag extra fields onto the settings page. The other difference is that you don't access by URL, you post data to them and they then return the XML. The <em>Ma.gnolia</em> API is far neater and more organised in my opinion, compared to <em>Del.icio.us</em> - however their servers are a LOT slower (at least from my location).</p>
<h2>Digg</h2>
<p><em>Digg </em>was possibly the hardest to integrate mainly due to a lack of coherence in their API. It feels like something which has evolved rather than grown in a planned and methodical way. For starters, there is a different URL to submit a new Digg compared to the URL which is required to Digg and existing item (this URL I have yet to decode, so the module currently just sends you to the Digg page for that item). For the first two, the title of the statistic links you to the post page. For Digg, you don't know if you're submitting or digging until you have got the statistic data from the server and, as this is done using <em><strong>AHAH</strong></em>, there is no way to know this at page load time unless the statistics have been previously loaded into cache. This is why the Digg item sometimes has its link on the value and sometimes on the title. I would appreciate thoughts on how to improve this.</p>
<h2>AHAH Data Retrieval</h2>
<p>The problem I faced during development was that if a particular service was taking its time responding with data, it held up the page load time until it had served up its reply. This isn't really ideal - even with caching, you still had to wait for the initial or updated value. I looked at <strong>jQuery</strong> and some drupal core commands, such as <a href="http://api.drupal.org/api/5/function/drupal_http_request" title="Drupal HTTP Request - gets data from a remote server">drupal_http_request</a>, and was pleasantly surprised at how <em>easy</em> it was. Things are certainly much more interesting with <strong>jQuery</strong>!</p>
<p>If a statistic is cached (using Drupal's internal caching mechanism) then that data is served up straight into the block, however if it is not available, then a template entry is added with an animated &quot;ajax loading&quot; style GIF which I generated using a fantastic and free website; <strong><a href="http://ajaxload.info/" title="AJAX Info - free AJAX Graphics">http://ajaxload.info/</a></strong>. The function also adds a single line of jQuery which calls a function included with the module which fires off a background <strong>HTTP post</strong> back to the website. This post induces another one of the <strong>Social Statistics API</strong> operations, the 'count' which litterally returns the value - nothing else at all. This value is then cross-faded with the animation using jQuery (ok, I <em>might</em> have got carried away there).</p>
<h2>Theming</h2>
<p>There are quite a few theme functions provided, so if you dont like the way its lays out its data by default, you should be able to quite easily override it.</p>
<h2>More modules?</h2>
<p>I would <strong>love</strong> to have this project gain a repository of extra social networks. I have personally looked into Stumble Upon, but cannot find a way to get it to return any statistic about the URL in question (favourites, likes, dislikes, etc). Does anyone know of a way?</p>
