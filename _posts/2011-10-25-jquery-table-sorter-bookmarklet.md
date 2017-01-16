---
categories:
- javascript
- programming
- webdev
- jquery
layout: post
title: JQuery Table Sorter Bookmarklet
created: 1319536144
permalink: blog/25-10-2011/jquery-table-sorter-bookmarklet
---
<p><a href="https://twitter.com/lovepeacenukes">Christian Bach</a> has made an awesome JQuery plugin to turn any HTML <a href="http://tablesorter.com/docs/">Table into a real-time sortable table</a> using <a href="http://jquery.com/">Jquery</a>. I recently needed to turn this into a <a href="http://en.wikipedia.org/wiki/Bookmarklet">Bookmarklet</a> so that I could embed it onto a page to sort a large table (I did not have access to the server-side code for this table).</p>
<!--break-->
<p>If you drag the following link into the bookmarks toolbar of your browser, you can turn <strong>any table</strong> on <strong>any website</strong> into a sortable table!</p>
<br />
<h3 style="text-align:center"><a onclick="window.alert('You shouldn't click this. Instead, please drag it into your bookmarks toolbar.');return false;" href="javascript:(function(){var%20head=document.getElementsByTagName('head')[0],script=document.createElement('script');script.type='text/javascript';script.src='http://www.thingy-ma-jig.co.uk/sites/thingy-ma-jig.co.uk/files/blog-attachments/tablesorter-bookmarklet-1.0.js?'+Date.now();head.appendChild(script);})();%20void%200">Table Sorter Bookmarklet</a></h3>
<br />
