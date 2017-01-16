---
excerpt: "<p>Back in November last year, I wrote a script which handled <a href=\"/blog/26-11-2008/backing-drupal-database\">backing
  up a drupal database</a>. There were quite a few comments and I've taken some on
  board and developed the script on a little further to be more &quot;generic&quot;.</p>\r\n<p>One
  of the main complaints/suggestions about my previous snippet was the hard coded
  nature of it. The follow script offers far more configuration through the command
  line itself.</p>\r\n"
categories:
- tip
- linux
- howto
- geek
- drupal
- code
- bash
layout: post
title: 'Backing up a Drupal Database: Redux'
created: 1240840555
permalink: blog/27-04-2009/backing-drupal-database-redux
---
<p>Back in November last year, I wrote a script which handled <a href="/blog/26-11-2008/backing-drupal-database">backing up a drupal database</a>. There were quite a few comments and I've taken some on board and developed the script on a little further to be more &quot;generic&quot;.</p>
<p>One of the main complaints/suggestions about my previous snippet was the hard coded nature of it. The follow script offers far more configuration through the command line itself.</p>
<!--break-->
<pre language="bash">
#!/bin/bash

# Define the options for this command
OPTION_SPEC="help,database:,file:,user:,password:,exclude:,exclude-drupal-tables,prefix:"
PARSED_OPTIONS=$(getopt -n "$0" -a -o h --long $OPTION_SPEC -- "$@")
OPTIONS_RET=$?
eval set -- "$PARSED_OPTIONS"

# Define an array of tables to be exluded
DBEXCLUDE=( )

# Define an array of table prefixes
DBPREFIX=( )



# Define a usage help function
usage() {
  cat <<HELP
Usage: `basename $0` --database=DATABASE_NAME [OPTIONS]

Options:
  --database=DATABASE_NAME
  -d DATABASE_NAME            Database to dump

  --file=FILENAME
  -f FILENAME                 Filename you to dump the database to, defaults to DATABASE.sql

  --user=USERNAME
  -u USERNAME                 Username for accessing the database, defaults to the user running the script

  --password=PASSWORD
  -p PASSWORD                 Password for accessing the database, defaults to blank

  --exclude=TABLE_NAME
  -e TABLE_NAME               Name of a table to exclude from the full dump (will do structure only).
                              Multiple excludes can be passed

  --exclude-drupal-tables     Enables a preset of tables which hold temporary/cached data which do not need dumping

  --prefix=PREFIX
  -pr PREFIX                  Optional table prefix.
                              Eg, you might want to exclude a table called "cache" and
                              this table might appear several times with different prefixes
Example:
  drupaldump -d my_database -u joe_bloggs --password=myPassw0rd --file=dump.sql -e cache -e stats -e logs --prefix=foo -pr bar
HELP
}



# Some kind of test on the options... 
if [ $OPTIONS_RET -ne 0 ] || [ $# -le 0 ]; then
  usage;
  exit 1;
fi


# Loop over all the options and pull out settings for the database, user, password, etc
while [ $# -ge 1 ]; do
  case $1 in
    --help | -h )                     usage; exit 1;;
    --database | -d )                 shift; DB="$1";;
    --file | -f )                     shift; DBFILE="$1";;
    --user | -u )                     shift; DBUSER="$1";;
    --password | -p )                 shift; DBPASS="$1";;
    --exclude | -e )                  shift; DBEXCLUDE[${#DBEXCLUDE[*]}]="$1";;
    --exclude-drupal-tables | -edt )  DBEXCLUDE=( "${DBEXCLUDE[@]}" accesslog watchdog sessions cache\(_.+\)? search_\(.+\) devel_\(.+\) );;
    --prefix | -pf )                  shift; DBPREFIX[${#DBPREFIX[*]}]="$1";;
    -- ) shift;;
    * ) echo "ERROR: unknown flag $1"; usage; exit 1;;
  esac

  shift
done


# Get the database from the commandline
if [ ! -n "$DB" ]
then
  # Print an error & usage suggestion
  echo "`basename $0`: Missing database"
  usage; exit 1
fi


# If the database isn't already set, then set it...
if [ ! -n "$DBFILE" ]
then
  # Define the start time - this is used as a filename stub
  START_TIME=$(date +%Y%m%d%H%M);

  # Define a default DB File
  DBFILE="${START_TIME}-${DB}.sql"
fi

# Create an empty file in that place
 > $DBFILE



# Define the username, if it's not already set
if [ ! -n "$DBUSER" ]
then
  DBUSER=""
else
  DBUSER="--user=${DBUSER}"
fi


# Define the password, if it's not already set
if [ ! -n "$DBPASS" ]
then
  DBPASS=""
else
  DBPASS="--password=${DBPASS}"
fi


# Define the default 'structure only' tables
DBEXCLUDE_TABLES=""
ELEMENT_COUNT=${#DBEXCLUDE[@]}
if [ "$ELEMENT_COUNT" -gt 0 ]
then
  INDEX=0

  while [ "$INDEX" -lt "$ELEMENT_COUNT" ]
  do
    DBEXCLUDE_TABLES="${DBEXCLUDE_TABLES}|${DBEXCLUDE[$INDEX]}"
    let "INDEX = $INDEX + 1"
  done

  DBEXCLUDE_TABLES="(${DBEXCLUDE_TABLES:1})"
fi

# Define the structure only optional table prefixes
DBPREFIX_TABLES=""
ELEMENT_COUNT=${#DBPREFIX[@]}
if [ "$ELEMENT_COUNT" -gt 0 ]
then
  INDEX=0

  while [ "$INDEX" -lt "$ELEMENT_COUNT" ]
  do
    DBPREFIX_TABLES="${DBPREFIX_TABLES}|${DBPREFIX[$INDEX]}"
    let "INDEX = $INDEX + 1"
  done

  DBPREFIX_TABLES="(${DBPREFIX_TABLES:1})?"
fi

# Define the structure only regex
STRUCTURE_ONLY="/^${DBPREFIX_TABLES}${DBEXCLUDE_TABLES}$/"

# Get the tables from the database
TABLES=`mysql ${DBUSER} ${DBPASS} --batch --skip-column-names -e 'show tables;' ${DB}`

if [[ $? > 0 ]]
then
  echo "Exiting for some kind of error... $?"
  exit 1
fi


# Status message
echo "  Starting dump of ${DB}"


# Loop over the tables
for T in $TABLES; do
  # Test if the table matches the 'structure only' regex
  RESULT=`echo "$T" | gawk "$STRUCTURE_ONLY"`

  # if a match...
  if [ $RESULT ]
  then
    echo "    STRUCTURE : ${T}"
    NODATA="--no-data"
  else
    echo "    FULL      : ${T}"
    NODATA=""
  fi

  # Dump the table onto the end of the DBFILE with the data or no data option
  mysqldump ${DBUSER} ${DBPASS} --opt --skip-comments ${NODATA} ${DB} ${T} >> $DBFILE
done


# Finish Message
echo "  Done"
exit 0
</pre>
<p>Essentially this is the same script as in my previous post, however I've added functionality to provide a custom username, password, database, file, exclude (structure only) and optional-table-prefix...</p>
<p>Comments &amp; suggestions welcome :)</p>
<p>Oh - one final thing&hellip; You can find the file for download in my Drupal Sandbox&hellip;</p>
<p><a href="http://cvs.drupal.org/viewvc.py/drupal/contributions/sandbox/nicholasThompson/drupaldump/">http://cvs.drupal.org/viewvc.py/drupal/contributions/sandbox/nicholasThompson/drupaldump/</a></p>
