---
excerpt: "<p>This morning I am faced with a task that will involve repeatedly dropping
  and reimporting a lot of data. MySQL has <strong><code>DROP TABLE</code></strong>
  and <strong><code>DROP DATABASE</code></strong> but there is no command to drop
  all tables or truncate the database.</p>\r\n"
categories:
- programming
- mysql
- linux
- geek
- free
- cool
layout: post
title: Drop all tables in a MySQL database
created: 1160474229
permalink: blog/10-10-2006/mysql-drop-all-tables
---
<p>This morning I am faced with a task that will involve repeatedly dropping and reimporting a lot of data. MySQL has <strong><code>DROP TABLE</code></strong> and <strong><code>DROP DATABASE</code></strong> but there is no command to drop all tables or truncate the database.</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<p>After finding a reference on the MySQL Lists (<a href="http://lists.mysql.com/mysql/193430">http://lists.mysql.com/mysql/193430</a>) I started playing with the idea. I didn't want to have to dump into one file and then run that query. Also - the problem with the above concept is that it drops the table and then recreates it - not what i wanted!</p>
<p>I then looked into using the pipe and <code>grep</code> features in Linux. Now I was getting somewhere! A few tweaks later and this is what I got:</p>
<pre language="bash">
mysqldump -u[USERNAME] -p[PASSWORD] --add-drop-table --no-data [DATABASE] | grep ^DROP | mysql -u[USERNAME] -p[PASSWORD] [DATABASE]
</pre>
<p>In the above, <em>[USERNAME]</em>, <em>[PASSWORD]</em> &amp; <em>[DATABASE]</em> are all the details for your database. You might not need the username and password fields - depends on your setup!</p>
