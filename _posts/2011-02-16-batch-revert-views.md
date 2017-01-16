---
categories:
- drupal
- code
- tips
layout: post
title: Batch Revert Views
created: 1297856010
permalink: blog/16-02-2011/batch-revert-views
---
<p>Isn't it a pain when you have dozens of Views setup and they are all marked as "overridden" because you just pulled in an updated feature file from somewhere. Features doesn't always notice when the Views on your site aren't up to date.</p><p>The following snippet (<strong>which you should use with caution</strong>) will batch "delete" (or Revert, once the view is in code) all Views which are marked as Overridden. This took a few seconds to run on our development machine.</p><p><!--break--></p><div style="clear: right;">
<pre language="php">$views = views_get_all_views();

foreach ($views as $view) {
  if ($view-&gt;disabled) continue;

  if ($view-&gt;type == t('Overridden')) {
    $view-&gt;delete();
    views_object_cache_clear('view', $view-&gt;name);
  }
}
</pre>
</div><p>I ran this from the Devel PHP page (http://www.example.com/devel/php). It essentially does the same as the view module does when you individually revert views, but this does it without confirming on <strong>ALL VIEWS MARKED AS <em>Overridden</em></strong>. I cannot stress enough - use at your own risk, and backup your database first!</p>
