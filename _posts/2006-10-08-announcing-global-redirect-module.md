---
excerpt: "<p>Well its nearly 1am - but I've just submitted by very first Drupal module
  to the community</p>\r\n<p><strong><a title=\"Global Redirect helps to stop duplicate
  content\" href=\"http://drupal.org/project/globalredirect\">http://drupal.org/project/globalredirect</a></strong></p>\r\n<!--
  break -->\r\n<p>Basically, if you have an alias for a node then it will redirect
  you to the alias if you try to access the node directly&hellip; The best example
  is the site it was designed for. At <a href=\"http://www.sportbusiness.com\">Sportbusiness.com</a>
  you could access a news story by:</p>"
categories:
- programming
- drupal
- announcement
layout: blog
title: 'Announcing: Global Redirect Module'
created: 1160265860
permalink: blog/08-10-2006/my-first-drupal-module
---
<p>Well its nearly 1am - but I've just submitted by very first Drupal module to the community</p>
<p><strong><a title="Global Redirect helps to stop duplicate content" href="http://drupal.org/project/globalredirect">http://drupal.org/project/globalredirect</a></strong></p>
<!--break-->
<p>Basically, if you have an alias for a node then it will redirect you to the alias if you try to access the node directly&hellip; The best example is the site it was designed for. At <a href="http://www.sportbusiness.com">Sportbusiness.com</a> you could access a news story by:</p>
<p><a href="http://www.sportbusiness.com/node/160374">http://www.sportbusiness.com/node/160374</a></p>
<p>However if you try that on <a href="http://www.sportbusiness.com">sportbusiness.com</a>, this module picks up that <em>node/160374</em> actually has an alias attached to it and you will automatically be whisked away to that aliased URL, in this case:</p>
<p><a href="http://www.sportbusiness.com/news/160374/london-2012-appoints-head-of-new-media">http://www.sportbusiness.com/news/160374/london-2012-appoints-head-of&hellip;</a></p>
<p>The reason I wanted to do this was because search engines such as Google <strong>DO NOT like <em>duplicate pages</em></strong> (ie pages with different URL's but the same content). This could land you in the sandbox! However with this module, if google manages to find a link to <em>node/123456</em> then wont see the same content as its aliased sister page, instead it will get permanently redirected (a 301 redirect)!</p>
