---
excerpt: "<p>\r\n\tEver wondered if your <em><strong>Christmas Tree</strong></em>
  is really any good? Well last weekend I decided to make a website for this purpose.
  It&#39;s just a bit of fun really! You login using your Facebook credentials (using
  Facebook Connect) and can create <em>Chrismas Tree</em> posts by linking to Flickr
  or Facebook photo&#39;s. You can then vote on your favourite tree&#39;s in an &quot;A
  vs B&quot; type match. If you like the sound of this and fancy something a bit festive,
  please give it a go and let me know if you have any thoughts! Head over to <a href=\"http://ratemytree.co.uk/\">Rate
  My Christmas Tree</a> :-)</p>\r\n"
categories:
- drupal
- websites
- yads
- cool
- announcement
layout: blog
title: 'New Drupal Site: Rate My Christmas Tree'
created: 1291933465
permalink: blog/09-12-2010/new-drupal-site-rate-my-christmas-tree
---
<p>
	Ever wondered if your <em><strong>Christmas Tree</strong></em> is really any good? Well last weekend I decided to make a website for this purpose. It&#39;s just a bit of fun really! You login using your Facebook credentials (using Facebook Connect) and can create <em>Chrismas Tree</em> posts by linking to Flickr or Facebook photo&#39;s. You can then vote on your favourite tree&#39;s in an &quot;A vs B&quot; type match. If you like the sound of this and fancy something a bit festive, please give it a go and let me know if you have any thoughts! Head over to <a href="http://ratemytree.co.uk/">Rate My Christmas Tree</a> :-)</p>
<!--break-->
<p>
	I&#39;ve published one of the modules this site produced:&nbsp;<a href="http://drupal.org/project/media_facebook">Media: Facebook</a>. This module allows you to embed a Facebook photo into an EmField by simply copying and pasting the page URL from Facebook. The module then usesthe Facebook API to lookup all available sizes. It is a beta and still needs work, but certainly covers the basics.</p>
<p>
	I&#39;ve also written a custom module for comparing and voting between two nodes. I looked into the <a href="http://drupal.org/project/votingapi">Voting API</a> (which is AWESOME), btu it only allows you to store a score aginst a single node. I need a system which defined a &quot;left&quot; and &quot;right&quot; node and a &quot;winner&quot;. I also looked into the <a href="http://drupal.org/project/smackdown">Smackdown</a> module, which looks great too - however that seems to force you to create a &quot;competition&quot; node for every competition. That could get out of handy very quickly (assuming the site gains any kind of traction). So I wrote a module called Compare (which I&#39;ve not released yet). It will allow you to create &quot;profiles&quot; of votes. Each profile has it&#39;s own role-level access control and stores the User ID, Left, Right, Winner and Timestamp of each vote. The vote URL also uses Drupal&#39;s private key system to generate secure URL which is limited to only work for a certain period of time. The hash used to secure the URL also stops people changing the left, right or winning Node ID to anything other than that intended. I want to do more work on it before I release it though.</p>
