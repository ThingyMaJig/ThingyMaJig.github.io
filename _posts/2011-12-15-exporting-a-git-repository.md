---
categories:
- drupal
- git
- webdev
layout: post
title: Exporting a Git Repository
created: 1323965647
permalink: blog/15-12-2011/exporting-a-git-repository
---
<p>Have you ever needed or wanted to pull a remote Git Repository on Drupal.org down as a zip or tarball? You know, the way Github does? Most project releases have fairly recently built tarballs which is awesome - but Sandboxes do not (so it seems - please correct me if I'm wrong!).</p>
<p>The following snippet lets you "archive" a remote repository, pull it down as a tarball, and extract it in-place:</p>
<pre language="bash">
git archive --format=tar --prefix=PROJECT/ --remote=USERNAME@git.drupal.org:sandbox/USERNAME/123456789.git BRANCH | tar -xf -
</pre>
<!--break-->
<p>Some important notes:</p>
<ul>
  <li>The prefix is very important - without it, tar extracts to the current folder.</li>
  <li>The trailing slash on the prefix is equally important - without it all files have PROJECT at the beginning!</li>
  <li>The number (next to .git) references the sandbox Node ID.</li>
</ul>
<p>I have tried using the "zip" format, however the <code>unzip</code> bash command doesn't accept <code>stdin</code> as a source. It looks like <code>funzip</code> might hold some promise thought&hellip;</p>
<p><strong>EDIT:</strong> - looks like you can only do this if your user has access to the repository.</p>
