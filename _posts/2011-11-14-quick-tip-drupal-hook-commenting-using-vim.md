---
categories:
- vim
- drupal
- programming
layout: blog
title: 'Quick Tip: Drupal Hook Commenting Using Vim'
created: 1321293052
permalink: blog/14-11-2011/quick-tip-drupal-hook-commenting-using-vim
---
<p>According to the <a href="http://drupal.org/node/1354#hookimpl">Drupal Coding Standards for Documenting Hook Implementations</a>, its considered a good practice to quickly chuck a comment before any function which implements a Drupal hook (eg, <code>hook_menu</code>). This helps someone reading your code quickly see that the function is actually linked with a hook in Drupal and isn't just a function in your module to be called directly.</p>

<p>But&hellip; Well&hellip; The thing is&hellip; Does anyone else get bored of writing the following over and over again? I know do&hellip;</p>
<!--break-->
<pre language="php">
/**
 * Implements hook_menu().
 */
</pre>

<p>Wouldn't it be nice if you could just type in "menu" and Vim could just fill it our for you? Here follows a little Vim script for inserting a "hook implements" comment at the current cursor position.
<pre language="vim">
function! DrupalImplementsComment(hook)
  set paste

  exe "normal! i/**\<CR>"
  \          . " * Implements hook_" . a:hook . "()\<CR>"
  \          . " */\<Esc>"

  set nopaste
endfunction

map <C-C><C-C><C-C> :call DrupalImplementsComment(input("Enter Hook name:"))<CR>
</pre>

<p>Wherever your cursor is, press Ctrl+C 3 times, you then get prompted to enter the hook name. When you press enter, a comment gets inserted. Hopefully this will save someone some time - its already saving me time!</p>

<p>To install the script, I just have it in a file called <code>DrupalCommenting.vim</code> inside my <code>~/.vim/</code> folder. Then, inside my <code>~/.vimrc</code> file, I have a line which imports the source file, eg: <code>so ~/.vim/DrupalCommenting.vim</code>.</p>

<p>Any improvements very welcome!</p>
