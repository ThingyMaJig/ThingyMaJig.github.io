---
excerpt: "<p>I while ago (almost a year!) I released a module called <a href=\"http://drupal.org/project/relevant_content\"
  title=\"Relevant Content project page on Drupal.org\"><em>Relevant Content</em></a>
  to the community. This module executes a relatively lightweight SQL query which
  pulls up other nodes and sorts them by how many terms they have in common with the
  current node you're looking at. This provides a rudimentary method of suggesting
  other content to visitors to the page. It also provides a way of teaching search
  engines about other potentially relevant content.</p>\r\n"
categories:
- seo
- programming
- drupal
- announcement
layout: blog
title: Relevant Content gets some love
created: 1222340902
permalink: blog/25-09-2008/relevant-content-gets-some-love
---
<p>I while ago (almost a year!) I released a module called <a href="http://drupal.org/project/relevant_content" title="Relevant Content project page on Drupal.org"><em>Relevant Content</em></a> to the community. This module executes a relatively lightweight SQL query which pulls up other nodes and sorts them by how many terms they have in common with the current node you're looking at. This provides a rudimentary method of suggesting other content to visitors to the page. It also provides a way of teaching search engines about other potentially relevant content.</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<p>About 3 weeks ago I decided that my project list needed some TLC so I went to work about updating a bunch of my work. <a href="http://drupal.org/project/globalredirect" title="Global Redirect project page on Drupal.org">GlobalRedirect</a> has recently received some love and the dev versions now at least APPEAR to work with multiple languages. My lightweight, SEO-friendly and mostly-image-free theme, <a href="http://drupal.org/project/abessive" title="Abessive theme project page on Drupal.org">Abessive</a>, has also received some love and has a Drupal 6 release plus a few fixes and updates to bring inline with coding standards.</p>
<p>The last couple of days have been devoted to <em>Relevant Content</em>. This module had a couple of bugs in the Drupal 5 dev release which were mainly born from its original specification for use on the subscribers area of <a href="http://www.pponline.co.uk/" title="Peak Performance">www.pponline.co.uk</a> where we wanted to suggest relevant videos, polls and articles to our subscribers-only area (firewalled unless you want to take up one of the subscriptions on the site).</p>
<p>The latest releases (Version 1.1 for Drupal 5 &amp; 6) of this which I committed today contains a much better admin interface which allows you to define as many relevant content blocks as you wish, each one allowing you to define which content types are used, which vocabularies are used and how many nodes you would like to list in the block itself. There is also an optional <em>header</em> field.</p>
<p>The module as a whole can be seen in use on this site up at the top right of every blog page. I configured it to display the 5 most relevant blog posts. The vocabulary filtering was a little pointless in my case as I only have 1 vocabulary on this site!</p>
<p>I think it works pretty well and the queries themselves really don't seem to add anything noticeable to the page load times.</p>
