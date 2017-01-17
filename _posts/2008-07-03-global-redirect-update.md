---
excerpt: "<p>One of my most popular Drupal modules - <a href=\"http://drupal.org/project/globalredirect\">Global
  Redirect</a> - has just had an update from 1.2 to <a href=\"http://drupal.org/node/278199\">1.3</a>.
  This update includes several fixes for the following:</p>\r\n"
categories:
- seo
- programming
- geek
- drupal
layout: blog
title: Global Redirect Update
created: 1215102657
permalink: blog/03-07-2008/global-redirect-update
---
<p>One of my most popular Drupal modules - <a href="http://drupal.org/project/globalredirect">Global Redirect</a> - has just had an update from 1.2 to <a href="http://drupal.org/node/278199">1.3</a>. This update includes several fixes for the following:</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<ul>
    <li><strong>Protection on aliases for inaccessible URL's.</strong> For example, if you alias <code>/admin</code> to something like <code>/admin-frontpage</code> then, in 1.2, an anonymous person could type in /admin and would be redirected BEFORE they got shown the access denied. This is fixed in 1.3 which now provides you with a level of protection on private pages - especially handy for sites with protected nodes.</li>
    <li><strong>Compatibility with modules that have their own bootstrapping scripts is improved.</strong> Global Redirect now only works if the referring script name is &quot;/index.php&quot;. This helps with modules such as the <a href="http://drupal.org/project/ad">Ad module</a>.</li>
    <li><strong>Compatibility with </strong><a href="http://drupal.org/project/live"><strong>Live</strong></a><strong> should be improved</strong> by Global Redirect no longer touching page requests which contain any <code>$_POST</code> information.</li>
    <li><strong>The feature for redirecting non-clean to clean has finally made it from dev to official release.</strong> This is an especially handy feature if you've just moved your site from non-clean to clean URL's as all indexed pages in Google &amp; Co will automatically redirect.</li>
</ul>
<p>For those who have never heard of Global Redirect, it is a small and handy module which will help to protect your website from duplicate content which can arise from enabling the Path module. Once Path is enabled an a URL Alias is created for a node (or view, panel or anything else), Drupal still allows you to access the page on the old &quot;Source&quot; URL (eg, <code>node/123</code>). This means that the old page Google &amp; Co knew about still exists in its index but you ALSO now have a new page with a different name... Two unqiue page URL's... Identical page content... Google &amp; Co tend not to like this and you could potentially end up is quite hot water (or even blacklisted altogether) if you are caught with <em>Duplicate Content</em> like this.</p>
