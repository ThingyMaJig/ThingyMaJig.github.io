---
excerpt: "<p>I just finished upgrading a server to <em>Ubuntu 8.04</em> which came
  with <strong>Vim 7.1</strong> rather than <strong>6.3</strong> on the older server.
  It seems 7.1 does things slightly differently to 6.3.</p>\r\n<p>In 6.3 I could create
  <strong><code>~/.vim/filetype.vim</code></strong> and in there define a line as
  follows:</p>\r\n<pre language=\"vim\">\r\nau BufRead,BufNewFile *.module,*.install,*.theme
  setf php\r\n</pre>\r\n<p>However in 7.1, it looks like a line similar to this has
  to go into <strong><code>~/.vimrc</code></strong> instead&hellip;</p>"
categories:
- vim
- programming
- linux
- geek
- drupal
layout: blog
title: Vim and Drupal Modules
created: 1219070882
permalink: blog/18-08-08/vim-and-drupal-highlighting-php
---
<p>I just finished upgrading a server to <em>Ubuntu 8.04</em> which came with <strong>Vim 7.1</strong> rather than <strong>6.3</strong> on the older server. It seems 7.1 does things slightly differently to 6.3.</p>
<p>In 6.3 I could create <strong><code>~/.vim/filetype.vim</code></strong> and in there define a line as follows:</p>
<pre language="vim">
au BufRead,BufNewFile *.module,*.install,*.theme setf php
</pre>
<p>However in 7.1, it looks like a line similar to this has to go into <strong><code>~/.vimrc</code></strong> instead&hellip;</p>
<pre language="vim">
au BufReadPost *.module,*.install,*.theme set syntax=php
</pre>
<p>This tip took me about half an hour to find&hellip; Hopefully it'll help someone else programming <em><strong>Drupal </strong></em>with <em><strong>Vim </strong></em>figure out how to get modules, themes and install files to associate with the <em>PHP&nbsp;filetype</em> (specifically for <strong>highlighting</strong>).</p>
