---
excerpt: "<p>I recently stumbled across a handy <a href=\"http://www.vim.org/scripts/script.php?script_id=1675\">tutorial
  on configuring a Drupal dictionary in Vim for autocomplete</a>. I&nbsp;also remembered
  helping a friend out with a similar problem, <a href=\"http://janaksingh.com/blog/using-nano-syntax-highlight-drupal-module-development-47\">Drupal
  syntax highlighting for Nano</a>. I&nbsp;then combined the two and have a simple
  to follow tutorial for generating your own drupal 6 dictionary for vim autocomplete!</p>\r\n"
categories:
- vim
- programming
- drupal
layout: post
title: Drupal Autocomplete in Vim
created: 1250600632
permalink: blog/18-08-2009/drupal-autocomplete-vim
---
<p>I recently stumbled across a handy <a href="http://www.vim.org/scripts/script.php?script_id=1675">tutorial on configuring a Drupal dictionary in Vim for autocomplete</a>. I&nbsp;also remembered helping a friend out with a similar problem, <a href="http://janaksingh.com/blog/using-nano-syntax-highlight-drupal-module-development-47">Drupal syntax highlighting for Nano</a>. I&nbsp;then combined the two and have a simple to follow tutorial for generating your own drupal 6 dictionary for vim autocomplete!</p>
<!--break-->
<div>[adsense:468x60:4496506397]</div>
<p><strong>Step 1</strong>&hellip; Create a dictionaries folder if you don't already have one&hellip;</p>
<pre language="bash">
mkdir -p ~/.vim/dictionaries/
</pre>
<p><strong>Step 2</strong>&hellip; Generate your dictionary&hellip; Run the following from your Drupal install&hellip;</p>
<pre language="bash">
grep "^function" modules/ includes/ -hR | gawk '{ sub(/\(.+/, "(", $2); print $2 }' | sort -u > ~/.vim/dictionaries/drupal6.dict
</pre>
<p>This will search the modules and includes folders recursively for all lines starting with &quot;function&quot;. Then, via some <code>gawk</code> and <code>tr</code> magic, we end up with a list of functions that will be dumped into our dictionary file!</p>
<p><strong>Step 3</strong>&hellip; Configure Vim to add the new dictionary file on load up&hellip;</p>
<pre language="bash">
vim ~/.vimrc
</pre>
<p>then add&hellip;</p>
<pre language="bash">
set dict +=~/.vim/dictionaries/drupal6.dict
</pre>
<p><strong>Step 4</strong>&hellip; There is no step 4. You're done!</p>
<p>When editing your code (in INSERT&nbsp;mode), press Ctrl+X and then Ctrl+K to invoke the auto-complete menu.</p>
<p>Brilliant :-)</p>
