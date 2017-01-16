---
excerpt: "<p>Recently at work we had been having issues with spiking server load.
  One of the potential suspects was the <strong>Apache configuration</strong> as it
  was allowing 256 <strong>MaxClients</strong>. Combine that with <em>Drupal</em>
  eating RAM for breakfast (say a minimum of 12Mb per page) and you have a recipe
  for disaster - too many visitors cause a RAM shortage, lots of swapping and eventually
  a server meltdown. After speaking the <a title=\"Rackspace Fanatical Support\" href=\"http://www.rackspace.co.uk/support/\"><em>Rackspace
  Technical Support Team</em></a>, one of the guys there (<a title=\"Daniels Blog\"
  href=\"http://danb-uk.net/\">Daniel</a>) wrote a VERY useful script for us to run
  on the server to monitor <strong>Apache usage</strong>.</p>\r\n"
categories:
- programming
- linux
- geek
- drupal
- cool
- apache
layout: post
title: The price of sucess - too many users!
created: 1193323594
permalink: blog/25-10-2007/the-price-of-sucess-too-many-users
---
<p>Recently at work we had been having issues with spiking server load. One of the potential suspects was the <strong>Apache configuration</strong> as it was allowing 256 <strong>MaxClients</strong>. Combine that with <em>Drupal</em> eating RAM for breakfast (say a minimum of 12Mb per page) and you have a recipe for disaster - too many visitors cause a RAM shortage, lots of swapping and eventually a server meltdown. After speaking the <a title="Rackspace Fanatical Support" href="http://www.rackspace.co.uk/support/"><em>Rackspace Technical Support Team</em></a>, one of the guys there (<a title="Daniels Blog" href="http://danb-uk.net/">Daniel</a>) wrote a VERY useful script for us to run on the server to monitor <strong>Apache usage</strong>.</p>
<!--break-->
<p>The basic principle is to regularly use the <strong><code>ps</code></strong> command to get a process list, then to filter is using <strong><code>grep</code></strong>, then filter using <strong><code>grep</code></strong> again to remove the line from the process list which was filtering for processes ('<strong><code>grep httpd</code></strong>' contains the phrase httpd so it gets included in the initial filter). Finally use the <code>wc</code> command to do a count of the result. This theory produces the following line of code which you can run on your system&hellip;</p>
<pre language="bash">
ps aux | grep http | grep -v "\(root\|grep\)" | wc -l
</pre>
<p>Here is an explanation&hellip;</p>
<dl>
    <dt><pre language="bash">
ps aux
</pre></dt>
    <dd>
    <p>Get a process list. The 'a' causes a full process list for the current terminal. The 'u' causes it to be user-oriented. The 'x' causes it to be for the current user only.</p>
    </dd>
    <dt><pre language="bash">
grep http
</pre></dt>
    <dd>
    <p>This goes through the list produced and reduces it to lines containing only the word 'http'.</p>
    </dd>
    <dt><pre language="bash">
grep -v "\(root\|grep\)"
</pre></dt>
    <dd>
    <p>Unfortunately for the previous process, it also contains one of the words it's filtering for - this means it appears as one of the processes. Root also owns one of the Apache processes (the parent one maybe?). We want to filter out these two so we use grep as we did before but filter out for the lines containing grep and root. The '-v' option tells grep to make this an inverse-filter.</p>
    </dd>
    <dt><pre language="bash">
wc -l</pre></dt>
    <dd>
    <p>This is a really simple and yet useful function. It's a word counter and the '<code>-l</code>' (thats a lowercase L) option tells it to count newlines which is what separates our process in the list!</p>
    </dd>
</dl>
<p>By running the above command you will get a number returned on the terminal. This tells you how many apache processes are currently running on your system. A slight variation on the initial 'ps' command will give you some pretty usefull information&hellip;</p>
<pre language="bash">
ps axo 'pid user size cmd' | grep http | grep -v "\(root\|grep\)"
</pre>
<p>This version will very nicely list you out a table of running apache processes (not caused by root or grep) with only 4 columns - <em>Process ID</em>, <em>Username</em> (of the process owner), <em>Size</em> (in Kb - I THINK) and the <em>Command</em> that was run. This means you can quickly see how much actual RAM your webserver is using for <strong>apache</strong>!</p>
<p>Finally - you want to be able to know how many processes are running over the periof of a day, etc... This is where <em>Rackspace</em> turned those commands into a VERY nice <em><strong>bash</strong></em> script!</p>
<pre language="bash">
#!/bin/bash

THRESHOLD=100
ADDRTO="admin@mysite.com"
SUBJECT="Apache Process Check"
LOCKFILE="/tmp/apache_process_check.lock"
LOGFILE="/var/log/apache_processes.log"

NUMHTTPD=`ps aux | grep http | grep -v "\(root\|grep\)" | wc -l`
echo "`date +'%Y-%m-%d %H:%M:%S %Z'` - ${NUMHTTPD}" >> ${LOGFILE}

if [[ ${NUMHTTPD} -gt ${THRESHOLD} ]]; then
  if [ ! -e "${LOCKFILE}" ]; then
    echo "The number of currently running httpd threads is ${NUMHTTPD}." | mail -s "${SUBJECT} - Above Threshold" ${ADDRTO}
    touch ${LOCKFILE}
  fi
else
  if [ -e "${LOCKFILE}" ]; then
    rm -f "${LOCKFILE}"
    echo "The number of currently running httpd threads is ${NUMHTTPD}." | mail -s "${SUBJECT} - Below Threshold" ${ADDRTO}
  fi
fi
</pre>
<p>This, quite simply, will log the apache process. If the threshold count is breached (in this case, 100) then it will create a lock file and email the address specified letting the admin know that they're quite close to their limit. The lock file gets deleted when the process count drops below the threshold again. This semaphore stops the script spamming the admin when the server is under load. It also pipes a timestamp and the result of the process count into a logfile (on a new line). This log could easily be imported into something like Excel if you want to produce pretty graphs. If you're slightly more challenge-oriented then maybe you could write a script to parse it into RRDTool!</p>
<p>The next step is to make that script executable and then setup crontab to run it regularly (say, every 5 minutes).</p>
<p>I'd like to thank <a title="Rackspace UK" href="http://www.rackspace.co.uk/"><strong>Rackspace</strong></a> for their &quot;<a title="Fanatical Support by Rackspace" href="http://www.rackspace.co.uk/support/"><em>fanatical support</em></a>&quot; - especially <a title="Daniels Blog" href="http://danb-uk.net/">Daniel</a> for going above and beyond the call of duty. This is a <u><em><strong>REALLY</strong></em></u> handy script!</p>
