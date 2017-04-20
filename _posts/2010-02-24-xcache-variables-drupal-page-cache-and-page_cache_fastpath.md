---
excerpt: "<p>I run XCache on the server that powers this site. XCache is cool. Out
  of the box, it allows caching of PHP compile code in memory, after all once a file
  is compile you shouldn't keep needing to compile it on every page load, should you?</p>"
categories:
- tips
- programming
- performance
- howto
- drupal
layout: blog
title: XCache Variables, Drupal Page Cache and page_cache_fastpath()
created: 1267026549
permalink: blog/24-02-2010/xcache-variables-drupal-page-cache-and-pagecachefastpath
---
<p>I run XCache on the server that powers this site. XCache is cool. Out of the box, it allows caching of PHP compile code in memory, after all once a file is compile you shouldn't keep needing to compile it on every page load, should you?</p>
<!--break-->
<p>There is another feature XCache has which not many people know about or use; Variable Caching. When you configure your XCache (the ini file is usually found in /etc/php.d/xcache.ini), you should see some options in there for allocating memory for variables as well as code (see var_size). This is essentially a persistent place to put stuff which can be called back out on the next page load.</p><p>Another handy thing which I'd never seen before&nbsp;(and I've been using Drupal for around 4 years), is the page_cache_fastpath()&nbsp;function. This is not implemented by default, but if you take a look in <a href="http://api.drupal.org/api/function/_drupal_bootstrap/6">_drupal_bootstrap</a>, there is a stage called DRUPAL_BOOTSTRAP_EARLY_PAGE_CACHE. I'd never noticed this before.</p><p>In both Drupal 5 and Drupal 6, this stage will check if the <code><span class="php-string">page_cache_fastpath</span></code> variable is set to TRUE and, if so, will call a the page_cache_fastpath() function. This function can then echo out a page and return TRUE which causes Drupal to exit there and then. This all happens BEFORE&nbsp;Drupal connects to the database.</p><p>So I set myself a little challenge… and then Googled for it to find that it's <a href="http://www.php-professionals.com/2008/12/09/drupal-performance-tuning-2-and-a-patch-to-the-memcache-module/">pretty much been done before, although it seemed to require Memcache</a>. I also found that CacheRouter could do this too but thought it was a little excessive for me needs, plus I still wanted a challenge!</p><p>It turns out to be pretty easy.</p><ol><li>Copy includes/cache.inc into your sites folder.</li><li>In your settings.php add the following:
<pre language="php">$conf = array(
  'cache_inc' =&gt; './sites/example.com/cache.inc',
);
</pre>
</li><li>Your site should now be using your "custom" cache.inc file. Now you need to tweak it.</li><li>I decided to define a prefix in the header - this is because there is only one XCache Variables place to put "stuff". The prefix can be used to fix content to a specific site. Add the following at the top of the file:
<pre language="php">define('XCACHE_PREFIX', 'mysite_');
</pre>
</li><li>Next, you want it to insert this code at the end of <code>cache_set</code>:
<pre language="php">    if ($table == 'cache_page') {
    cache_get($cid, $table);
  }
</pre>
<p>This will, for cache_page entries only, insert the data and headers into XCache as an array.</p></li><li>The only thing we need to add to cache_get is some code to re-insert data into XCache if we clear XCache but not the cache_page table (Eg, restarting Apache or Lighttpd). Add the following code just before the <code language="php">return $cache</code> part:
<pre language="php">  if ($table == 'cache_page') {
    // If we're here and on cache_page, looks like the xcache wasn't present... lets chuck it in there for next time.
    $xcache_expire = $cache-&gt;expire &gt; 0 ? $cache-&gt;expire - time() : NULL;
    $ret = xcache_set(XCACHE_PREFIX . $table . ':'. $cid, array('data' =&gt; $cache-&gt;data, 'headers' =&gt; $cache-&gt;headers), $cache-&gt;expire);
  }
</pre>
</li><li>Almost there now... We need to control cache_clear_all. For this to work, you need to make sure you're running the very latest 1.3.0 version of XCache. There is a known bug where some releases don't contain the <code>xcache_unset_by_prefix</code> function (for some odd reason). Under the <code>cache_clear_all(NULL, 'cache_page');</code> line near the beginning of <code>cache_clear_all</code>, add the following:
<pre language="php">xcache_unset_by_prefix(XCACHE_PREFIX .'cache_page');
</pre>
</li></ol>
