---
excerpt: "<p>I am a bit of a &quot;<em>neat geek</em>&quot; when it comes to coding.
  Things <strong>should</strong> be indented neatly and <strong>should</strong> have
  well laid out comments! Why? Well&hellip; It's easy to do and in 6 months time when
  you look at your code you <strong>will</strong> appreciate it! It will also me even
  more appreciated by another developer in less than 6 months time ;-)</p>\r\n"
categories:
- vim
- programming
- linux
- drupal
layout: post
title: Neat commenting in Vim
created: 1231777845
permalink: blog/12-01-2009/neat-commenting-vim
---
<p>I am a bit of a &quot;<em>neat geek</em>&quot; when it comes to coding. Things <strong>should</strong> be indented neatly and <strong>should</strong> have well laid out comments! Why? Well&hellip; It's easy to do and in 6 months time when you look at your code you <strong>will</strong> appreciate it! It will also me even more appreciated by another developer in less than 6 months time ;-)</p>
<!--break-->
<p>I recently was looking through some old code and the 1-line comments were in an inconsistent form, for example:</p>
<ol>
    <li><code>//xxxx</code></li>
    <li><code>// xxxx</code></li>
    <li><code>//Xxxx</code></li>
    <li><code>// Xxx</code></li>
</ol>
<p>I personally prefer the 4<sup>th</sup> coding style (with a space and initial capital), so I started googling around for a solution using <a href="/tags/vim">Vim</a> and <em>Regular Expressions</em>. I found the following two search/replace phrases worked perfectly:</p>
<ul>
    <li>
    <pre class="codeblock">
:%s=\/\/\([^ ]\)=// \1=</pre>
    </li>
    <li>
    <pre class="codeblock">
:%s=\/\/ \([a-z]\)=// \u\1=</pre>
    </li>
</ul>
<div>[adsense:468x60:4496506397]</div>
<p>The first one does a search for anything containing a &quot;<em>slash-slash</em>&quot; followed by a non-space character. The non-space character is grouped so we can reference it in the replace. The replace phrase changes that match to a &quot;<em>slash-slash</em>&quot; followed by a space and finally the character that was matched in the group.</p>
<p>The second is VERY similar to the first, except we search for &quot;<em>slash-slash-space</em>&quot; followed by a group matching a lowercase <em>a to z</em> range. The replacement is &quot;<em>slash-slash-space</em>&quot; followed by the group match converted to upper case (<code>\u</code> is a <a href="/tags/vim">Vim</a> option for conversion to uppercase).</p>
