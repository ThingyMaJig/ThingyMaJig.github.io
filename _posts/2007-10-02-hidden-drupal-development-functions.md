---
excerpt: "<p>I was browsing around the <a title=\"Devel Module\" href=\"http://drupal.org/project/devel\">Devel
  Module</a> the other day and I noticed a few functions that are not mentioned in
  any documentation that I've seen but make life even easier, as if <a title=\"Devel
  Module\" href=\"http://drupal.org/project/devel\">Devel</a> doesn't make it easy
  enough! Almost everyone that's used <a title=\"Devel Module\" href=\"http://drupal.org/project/devel\">Devel</a>
  will be familiar with <code><strong>dprint</strong>_r</code> (A debug version of
  the popular <a title=\"print_r Documentation Page at php.net\" href=\"http://php.net/manual/en/function.print-r.php\"><code>print_r</code></a>
  function in PHP). Well who has used these ones?</p>\r\n<ul>\r\n    <li><strong><code>dpr</code></strong>
  &ndash; Shortcut for <code>dprint_r</code>.</li>\r\n    <li><strong><code>dvr</code></strong>
  &ndash; Similar to <code>dpr</code>, but uses <a title=\"var_dump Documentation
  at php.net\" href=\"http://php.net/manual/en/function.var-dump.php\"><code>var_dump</code></a>
  instead of <a title=\"print_r Documentation Page at php.net\" href=\"http://php.net/manual/en/function.print-r.php\"><code>print_r</code></a>.</li>\r\n
  \   <li><strong><code>dpm</code></strong> &ndash; Similar to <code>dpr</code> but
  <a title=\"print_r Documentation Page at php.net\" href=\"http://php.net/manual/en/function.print-r.php\"><code>print_r</code></a>'s
  a variable as a message using <a href=\"http://api.drupal.org/api/function/drupal_set_message/5\"
  title=\"Drupal Set Message at Drupal API Documentation\"><code>drupal_set_message</code></a>.</li>\r\n
  \   <li><strong><code>dvm</code></strong> &ndash; Similar to <code>dpm</code> but
  uses <a title=\"var_dump Documentation at php.net\" href=\"http://php.net/manual/en/function.var-dump.php\"><code>var_dump</code></a>
  instead of <a title=\"print_r Documentation Page at php.net\" href=\"http://php.net/manual/en/function.print-r.php\"><code>print_r</code></a>.</li>\r\n</ul>\r\n"
categories:
- programming
- drupal
layout: post
title: Hidden Drupal development functions
created: 1191319667
permalink: blog/02-10-2007/hugely-useful-hugely-undocumented
---
<p>I was browsing around the <a title="Devel Module" href="http://drupal.org/project/devel">Devel Module</a> the other day and I noticed a few functions that are not mentioned in any documentation that I've seen but make life even easier, as if <a title="Devel Module" href="http://drupal.org/project/devel">Devel</a> doesn't make it easy enough! Almost everyone that's used <a title="Devel Module" href="http://drupal.org/project/devel">Devel</a> will be familiar with <code><strong>dprint</strong>_r</code> (A debug version of the popular <a title="print_r Documentation Page at php.net" href="http://php.net/manual/en/function.print-r.php"><code>print_r</code></a> function in PHP). Well who has used these ones?</p>
<ul>
    <li><strong><code>dpr</code></strong> &ndash; Shortcut for <code>dprint_r</code>.</li>
    <li><strong><code>dvr</code></strong> &ndash; Similar to <code>dpr</code>, but uses <a title="var_dump Documentation at php.net" href="http://php.net/manual/en/function.var-dump.php"><code>var_dump</code></a> instead of <a title="print_r Documentation Page at php.net" href="http://php.net/manual/en/function.print-r.php"><code>print_r</code></a>.</li>
    <li><strong><code>dpm</code></strong> &ndash; Similar to <code>dpr</code> but <a title="print_r Documentation Page at php.net" href="http://php.net/manual/en/function.print-r.php"><code>print_r</code></a>'s a variable as a message using <a href="http://api.drupal.org/api/function/drupal_set_message/5" title="Drupal Set Message at Drupal API Documentation"><code>drupal_set_message</code></a>.</li>
    <li><strong><code>dvm</code></strong> &ndash; Similar to <code>dpm</code> but uses <a title="var_dump Documentation at php.net" href="http://php.net/manual/en/function.var-dump.php"><code>var_dump</code></a> instead of <a title="print_r Documentation Page at php.net" href="http://php.net/manual/en/function.print-r.php"><code>print_r</code></a>.</li>
</ul>
<!--break-->
<div>[adsense:468x60:4496506397]</div>
<p>The <strong><code>dpr</code></strong> simply &quot;<em>saves carpal tunnel syndrome</em>&quot; (as the comment for the function in <em><a title="Devel Module in Drupal CVS Repositry (HEAD Branch)" href="http://cvs.drupal.org/viewvc.py/drupal/contributions/modules/devel/devel.module?view=markup">devel.module</a></em> says) and the <strong><code>dvr</code></strong> function is funky useful as it not only dumps the data but also the data <strong>TYPE</strong> too (eg, is this variable a integer zero or boolean false?). The <strong><code>dpm</code></strong> and <strong><code>dvm</code></strong> functions are useful as the message only gets printed out on a visible page. This makes form output debuging easier.</p>
<p>Who here has debug outputted the <code>$form_values</code> on a <em>form_submit</em> and spent a few minutes wondering why nothing came up (due to the redirect after submit) and then ended up adding <a title="exit Documentation at php.net" href="http://php.net/manual/en/function.exit.php"><code>exit</code></a> calls to the code to see the output or enabling the <em>form redirection interruption</em> from the <a title="Devel Module" href="http://drupal.org/project/devel">Devel Module</a>? Well if you use <strong><code>dpm</code></strong> or <strong><code>dvm</code></strong> then you will get the form output in a message on the next visible page without any workflow interruption! Cool, eh!</p>
<p>These are REALLY useful commands! Thanks to Moshe for adding the <a title="var_dump Documentation at php.net" href="http://php.net/manual/en/function.var-dump.php"><code>var_dump</code></a> variants and I can only assume it was Moshe's idea to have the shortcut <strong><code>dpr</code></strong> and <strong><code>dpm</code></strong> functions to start with!</p>
