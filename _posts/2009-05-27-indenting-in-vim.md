---
excerpt: "<p>Ever had that situation where you've enabled <code>:set paste</code>
  and pasted in hundred of lines of code into <a title=\"Vim, the advanced command
  line editor\" href=\"/tags/vim\">vim</a> only to see it all fully left aligned?
  I just did&hellip; And bugger going over each line and manually indenting it! Want
  know how to indent a visual block of text?</p>\r\n"
categories:
- vim
- linux
- howto
layout: post
title: Indenting in Vim
created: 1243423361
permalink: blog/27-05-2009/indenting-vim
---
<p>Ever had that situation where you've enabled <code>:set paste</code> and pasted in hundred of lines of code into <a title="Vim, the advanced command line editor" href="/tags/vim">vim</a> only to see it all fully left aligned? I just did&hellip; And bugger going over each line and manually indenting it! Want know how to indent a visual block of text?</p>
<!--break-->
<div>[adsense:468x60:4496506397]</div>
<p>So, make a visual selection of what you'd like indented (by pressing v and moving the cursor to mark the selection). Press colon to enter command mode and type &quot;<code>le2</code>&quot;. The <code>le</code> command is shorthand for <a href="http://www.vim.org/htmldoc/change.html#:left"><em>left align</em></a>. The 2 value is an optional indent setting.</p>
<p>This is what I love about <a title="Vim, the advanced command line editor" href="/tags/vim">vim</a>; there is always a new trick to make your life easier!</p>
