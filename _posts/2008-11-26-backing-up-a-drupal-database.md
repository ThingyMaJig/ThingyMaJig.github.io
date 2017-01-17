---
excerpt: "<p>I was just dumping a database using <code>mysqldump</code> and I noticed
  that tables such as <em><code>cache</code></em> (and its cousins <em><code>cache_page</code></em>,
  <em><code>cache_menu</code></em>, etc), <em><code>sessions</code></em> and <em><code>watchdog</code></em>
  can be pretty big and are also not often essential for backing up. I mean, when
  you restore your web site do you really care about restoring people's logged in
  sessions from when the backup took place? I can understand maybe keeping watchdog;
  but then again should you lose your site you would probably lose it several hours
  after the backup so would miss out on any relevant watchdog notices.</p>\r\n<p>Anywho&hellip;
  I did a <code>mysqdump</code> for a large database for a website I maintain and
  the dump came out at 400Mb. I then spent a few minutes cobling together a small
  script which would do a <code>mysqldump</code> but had some pre-programmed <em>Regular
  Expressions</em> to match specific groups of tables which it would only dump the
  structure for (ie, no data). After running this script, the SQL dump was only 220Mb.
  Much better! It also runs considerable quicker too and will cause less table locking.</p>\r\n<p>So
  - the script?</p>\r\n"
categories:
- tip
- linux
- howto
- geek
- drupal
- code
- bash
layout: blog
title: Backing up a Drupal Database
created: 1227702466
permalink: blog/26-11-2008/backing-drupal-database
---
<p>I was just dumping a database using <code>mysqldump</code> and I noticed that tables such as <em><code>cache</code></em> (and its cousins <em><code>cache_page</code></em>, <em><code>cache_menu</code></em>, etc), <em><code>sessions</code></em> and <em><code>watchdog</code></em> can be pretty big and are also not often essential for backing up. I mean, when you restore your web site do you really care about restoring people's logged in sessions from when the backup took place? I can understand maybe keeping watchdog; but then again should you lose your site you would probably lose it several hours after the backup so would miss out on any relevant watchdog notices.</p>
<p>Anywho&hellip; I did a <code>mysqdump</code> for a large database for a website I maintain and the dump came out at 400Mb. I then spent a few minutes cobling together a small script which would do a <code>mysqldump</code> but had some pre-programmed <em>Regular Expressions</em> to match specific groups of tables which it would only dump the structure for (ie, no data). After running this script, the SQL dump was only 220Mb. Much better! It also runs considerable quicker too and will cause less table locking.</p>
<p>So - the script?</p>
<!--break-->
<pre language="bash">
#!/bin/bash

# Define DB Login
USER="username"
PASS="password"

# Get the database from the commandline
DB=$1

# Define the 'structure only' tables
STRUCTURE_ONLY="/^(prefix1_|prefix2_)?(watchdog|sessions|cache(_.+)?)$/"

# Get the tables from the database
TABLES=`mysql -u$USER -p$PASS -B -N -e 'show tables;' $DB`

# Create the SQL file
DBFILE="${DB}.sql"
 > $DBFILE

# Status message
echo "Starting dump of ${DB}"

# Loop over the tables
for t in $TABLES; do
  # Test if the table matches the 'structur only' regex
  RESULT=`echo "$t" | gawk "$STRUCTURE_ONLY"`

  # if a match...
  if [ $RESULT ]
  then
    # ... dump structure only onto the end of the SQL file
    mysqldump --opt --no-data --user=$USER --password=$PASS $DB $t >> $DBFILE
  else
    # dump full table onto the end of the SQL file
    mysqldump --opt --user=$USER --password=$PASS $DB $t >> $DBFILE
  fi
done

# Finish Message
echo "Done"
</pre>
<div style="margin: 0pt 0pt 0pt 5px; float: right; height: 336px; width: 280px;">[adsense:336x280:9994499560]</div>
<p>There are a few lines in here you might want to configure&hellip; For example, the <code>USER</code> &amp; <code>PASS</code> variables will need to be the ones for your database. This script also assumes you're running on <em>localhost</em>. The variable <code>STRUCTURE_ONLY</code> hold the Regular Expression to match the 'no data' tables. You might want to change this to match your database structure more accurately - for example you might want to change or remove the prefix option. In my case I have 1 database hosting 3 sites, 2 of which have a prefix but share several tables with no prefix (user, session, sequences, etc). This is how it would look for a database with no prefixes.</p>
<div class="clear-block"><!-- --></div>
<pre language="bash">
STRUCTURE_ONLY="/^(watchdog|sessions|cache(_.+)?)$/"
</pre>
<p>To run the script, copy the code into a file (eg, '<em>drupaldump</em>') and save it. Make it executable by running something like this:</p>
<pre language="bash">
$ chmod +x drupaldump
</pre>
<p>The finally run the script as follows&amp;hellip;</p>
<pre language="bash">
$ ./drupaldump [database]
</pre>
<p>&hellip; where [database] is the name of the database you'd like to dump.</p>
<p>Please leave a comment if you can think of any improvements! There are a few I can think of but don't need (ie, its not my itch!) such as option to pass username and password in from the command line, changing the host for the database&hellip; There is plenty of space for improvement.</p>
