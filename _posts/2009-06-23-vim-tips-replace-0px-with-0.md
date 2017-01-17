---
excerpt: "<p>I like little wins. I was just looking through the CSS&nbsp;file for
  this site and noticed that - for some reason - I'd used <code>0px</code> instead
  of <code>0</code> a LOT&nbsp;of times. Most values need numbers (10em, 10px, 10%
  and 10pt are all very difference sizes) however 0 is one of the few valeus which
  is the same in all cases (0px, 0pt, 0% and 0 are all zero!). This adds up to wasted
  data and bandwidth; admitedly not a lot, but still <em>Every Little Helps</em>!</p>\r\n<p>So
  I fired up Vim. Initially, I just did:</p>\r\n"
categories:
- vim
- tips
- programming
- drupal
layout: blog
title: 'Vim Tips: Replace 0px with 0'
created: 1245756981
permalink: blog/23-06-2009/vim-tips-replace-0px-0
---
<p>I like little wins. I was just looking through the CSS&nbsp;file for this site and noticed that - for some reason - I'd used <code>0px</code> instead of <code>0</code> a LOT&nbsp;of times. Most values need numbers (10em, 10px, 10% and 10pt are all very difference sizes) however 0 is one of the few valeus which is the same in all cases (0px, 0pt, 0% and 0 are all zero!). This adds up to wasted data and bandwidth; admitedly not a lot, but still <em>Every Little Helps</em>!</p>
<p>So I fired up Vim. Initially, I just did:</p>
<!--break-->
<pre language="regex">
%s=0px=0=g
</pre>
<p>This told Vim to do a global (<code>%</code>) search (<code>s</code>) using the <code>=</code> as a delimiter and find all instanced of <code>0px</code> and replace with <code>0</code>. The <code>g</code> tells Vim not to stop once its found the first instance on the line. And it worked. In fact, it worked too well&hellip; Suddenly, all instances of <code>10px</code> turned into <code>10</code>. Bugger!</p>
<p>The solution ended up being a simple regular expression (God Save Regular Expressions):</p>
<pre language="regex">
%s=\([^0-9]\)0px=\10=g
</pre>
<p>I admit, it looks complicated, but essentially it's the same as the first search, however we've told it to match 0px preceded by a non numeric character (that's the <code>[^0-9]</code>, the <code>^</code> means <em>not</em> and the <code>0-9</code> is a range). The reason it's in brackets is that we need to be able to reference that later on. In the replace we use <code>\1</code> to tell Vim to look at the first group in the regex pattern (the bracketed non-numeric character). The unfortunately side effect of the non-numeric pattern preceding the <code>0px</code> is that it also matched spaces and colons. The replace code which references this allows the matches non-numeric character to be placed back in front of the zero.</p>
