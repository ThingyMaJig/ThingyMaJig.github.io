---
excerpt: "<p>\r\n\t<a href=\"http://drupal.org/user/142976\" title=\"Drupal User,
  peashooter\">peashoter</a> has raised a good point in an issue report for GlobalRedirect.
  <a href=\"http://drupal.org/node/234604\" title=\"can PHP access the URL Fragment?\">What
  happens to a URL which has a fragment in it</a> - such as:</p>\r\n<p>\r\n\t<strong>http://www.example.com/node/100#comments</strong></p>\r\n<p>\r\n\tI
  have done a <em>google</em> and cant find any answer to this. It appears that the
  fragment is not passed to PHP. This makes it a LOT harder to fix!</p>\r\n"
categories:
- programming
- howto
- drupal
layout: blog
title: Accessing the Fragment from PHP - is it possible?
created: 1206173198
permalink: blog/22-03-2008/accessing-the-fragment-from-php-is-it-possible
---
<p>
	<a href="http://drupal.org/user/142976" title="Drupal User, peashooter">peashoter</a> has raised a good point in an issue report for GlobalRedirect. <a href="http://drupal.org/node/234604" title="can PHP access the URL Fragment?">What happens to a URL which has a fragment in it</a> - such as:</p>
<p>
	<strong>http://www.example.com/node/100#comments</strong></p>
<p>
	I have done a <em>google</em> and cant find any answer to this. It appears that the fragment is not passed to PHP. This makes it a LOT harder to fix!</p>
<!--break-->
<p>
	On a positive note, if a user was to user a <a href="http://www.getfirefox.com" title="Get a proper browser!"><em>proper browser</em></a> then they should have the fragment preserved for them.</p>
<p>
	A potential case could be if drupal.org decided to enable the path module and pathauto to improve site SEO. If there were embedded links to the comment form or comments on another node, then the redirection will break (if GlobalRedirect were also chosen). Obviously there are a LOT of <em>if&#39;s</em> in this sentence - but there certainly IS a case for a large site enabling path + pathauto and having all their links with fragments in them broken.</p>
<p>
	So - does anyone have any suggestions? If so - PLEASE report them to <a href="http://drupal.org/node/234604">this issue</a>.</p>
<p>
	Cheers :-)</p>
