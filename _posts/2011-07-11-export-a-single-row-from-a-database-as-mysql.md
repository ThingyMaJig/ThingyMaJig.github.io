---
categories:
- mysql
- tip
- programming
layout: blog
title: Export a single row from a database as MySQL
created: 1310394074
permalink: blog/11-07-2011/export-a-single-row-from-a-database-as-mysql
---
<p><a href="http://nathan.rambeck.org/">Nathan Rambeck</a> has a great simple snippet of <a href="http://nathan.rambeck.org/blog/27-export-single-row-mysql-table">how to export a single row from a table</a> however it didn't QUITE do what I needed it to. I needed to export a variable from <code>{variable}</code> as I was working on an update script which pulled data from a variable and into a database schema. I got fed up of re-populating the variable data each time.</p>
<!--break-->
<p>Here is my version of Nathan's suggestion:</p>
<pre language="bash>
mysqldump -uUSER -pPASSWORD --compact --no-create-info --where="COLUMN_NAME='FILTER_VALUE'" DB_NAME TABLE_NAME
</pre>
<p>Values in capitals are <em>variables</em> which you should alter with your own values, for example:</p>
<pre language="bash">
mysqldump -udrupal -pdrupal --compact --no-create-info --where="name='theme_settings'" drupal_d6 variable
</pre>
<p>This produced a line like this:</p>
<pre language="mysql">
INSERT INTO `variable` VALUES ('theme_settings','a:1:{s:21:\"toggle_node_info_page\";b:0;}');
</pre>
<p>The <code>--compact</code> produces a less verbose output (it doesn't drop or lock the table and skips comments). The <code>--no-create-info</code> stops the dump including SQL to recreate the table.</p>
