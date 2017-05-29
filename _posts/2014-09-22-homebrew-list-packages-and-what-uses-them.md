---
categories:
- os-x
- homebrew
layout: blog
title: 'Homebrew: List packages and what uses them'
created: 1411417609
permalink: blog/22-09-2014/homebrew-list-packages-and-what-uses-them
---
<p>For anyone that uses <a href="http://brew.sh">Homebrew</a> a lot, its very easy to amasse many casks (installed packages) and never quite know which ones are still needed. I did some googling and found a really interesting blog post by <a href="http://twitter.com/zanshin">Mark H. Nichols</a> about <a href="http://zanshin.net/2014/02/03/how-to-list-brew-dependencies/">listing all brew dependencies</a>.</p>
<!--break-->
<p>I then decided to invert that logic; to list all my casks, with each one showing what uses it. Anything that has nothing using it is either an oprhaned cask or is something "standalone" which is not installed as a dependency on something else.</p><p>NOTE: The script from Mark's website uses zsh; I do not have that, I use plain old Bash. It is still possible to get colours though!</p>
<pre language="bash">
brew list -1 | while read cask; do echo -ne "\x1B[1;34m $cask \x1B[0m"; brew uses $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done
</pre>
<p>And some example output:</p>
<pre> apple-gcc42
 atk  gtk+  pygtk
 autoconf  automake  php54-apc  php54-mcrypt  php54-memcache  php54-tidy  tsocks
 automake
 axel
 bison27
 boot2docker
 cairo  gtk+  harfbuzz  pango  py2cairo
 cmake  percona-server55
...
...
</pre>
<p>And a screenshot:<br><img alt="Screenshot" src="/sites/thingy-ma-jig.co.uk/files/images/homebrew-list-orphaned-dependencies.png"></p>
