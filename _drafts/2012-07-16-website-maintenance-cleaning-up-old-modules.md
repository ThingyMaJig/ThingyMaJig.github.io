---
categories: []
layout: blog
title: Website maintenance - cleaning up old modules
created: 1342456271
permalink: blog/16-07-2012/website-maintenance-cleaning-up-old-modules
---
Drush is a wonderful tool for quickly checking things. Today I was idly wondering how many modules we had moved or removed from a site. So I wrote a mini Drush script. It's like taking a tour through time, seeing some of the old modules that had been used and were no longer present (but still had stuff left in the database!)
<!--break-->
<pre language="bash">
[nxthompson@localhost site.dev]$ drush ev '$res = db_query("SELECT * FROM {system}"); while ($row = db_fetch_object($res)) { if (!file_exists($row->filename)) { echo "MISSING: {$row->filename}  |  {$row->status}  |  {$row->schema_version}\n"; }; }'
</pre>
