---
excerpt: "<p>\r\n\tSometimes, when you&#39;re running coder on a module, you&#39;ll
  get a lot of errors complaining about <em><strong>Windows line endings</strong></em>.
  This is because you should set your editor to use <em><strong>Unix Line endings</strong></em>
  to be consistent with all developers. See the <a href=\"http://drupal.org/coding-standards#indenting\">Drupal
  Coding Standards</a> for more details.</p>\r\n<p>\r\n\tBelow is a handy bash script
  which will help you batch convert many files from DOS to Unix line endings.</p>\r\n"
categories:
- tips
- linux
- howto
- geek
- code
- drupal
layout: blog
title: Fixing Dos Line Endings
created: 1290687928
permalink: blog/25-11-2010/fixing-dos-line-endings
---
<p>Sometimes, when you're running coder on a module, you'll get a lot of errors complaining about <em><strong>Windows line endings</strong></em>. This is because you should set your editor to use <em><strong>Unix Line endings</strong></em> to be consistent with all developers. See the <a href="http://drupal.org/coding-standards#indenting">Drupal Coding Standards</a> for more details.</p><p>Below is a handy bash script which will help you batch convert many files from DOS to Unix line endings.</p><p><!--break--></p>
<pre class="bash">grep -lIUr "^M" . | xargs sed -i 's/^M//'
</pre>
<p>First up, we use Grep to find <code>^M</code>(which you can produce using Ctrl+V and then Ctrl+M). This is a special code for Carriage Return (Windows uses CRLF, Unix uses just LF).</p><dl><dt><code>-l</code></dt><dd>This tells grep to halt searching once its found the first instance - we only need 1 result per file.</dd><dt><code>-I</code></dt><dd>This tells grep to treat binary files as if there was no matching data</dd><dt><code>-U</code></dt><dd>This tells grep to treat the file as a binary file. Grep usually tries to guess the file type. If it guesses text, it will remove the CR characters from line endings to help keep Regex consistent across operating systems.</dd><dt><code>-r</code></dt><dd>This tells grep to be recursive</dd></dl><p>Next up, we pipe that result set into the <code>sed</code>command.</p><dl><dt><code>-i</code></dt><dd>This tells sed that we should edit all files in-place. If you like, you can change this to <code>-ibak</code>which would create a backup using the supplied suffix.</dd><dt><code>'s/^M//'</code></dt><dd>This is a regular expressions find-and-replace. This tells sed to find all ^M characters (which are CR (Carriage Return) characters) and replace them with nothing (ie remove them).</dd></dl><p>This seemed to work really well for me - please post below if you have any alternative/better ways of doing this!</p><p><strong>Note</strong>: I did try to use <code>dos2unix</code> however this did not remove a trailing <code>^M</code>for some reason.</p>
