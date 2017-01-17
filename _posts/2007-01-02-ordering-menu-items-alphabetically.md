---
excerpt: "<p>Faced with a tedious task of ordering a set of rows using a weight column?
  Don't want to type the numbers out? Would rather find a difficult but more interesting
  method? I have the answer for you!</p>\r\n"
categories:
- programming
- mysql
- howto
- drupal
- cool
layout: blog
title: Ordering Menu Items Alphabetically
created: 1167740153
permalink: blog/02-01-2007/ordering-menu-items-alphabetically
---
<p>Faced with a tedious task of ordering a set of rows using a weight column? Don't want to type the numbers out? Would rather find a difficult but more interesting method? I have the answer for you!</p>
<!--break-->
<p>In Drupal, menu items (like the projects list on this site) are ordered by giving each one a weight. This means you can order the items in anyway you like! The problem I had was I imported about 60 menu items but not in alphabetical order. I didn't really want to type all the numbers out again so I sought out a less tedious but much more complicated method - its what I do!</p>
<p>As google is my friend, it helped me on my way to:<br />
<a title="How To Number Rows In MySQL" href="http://xaprb.com/blog/2006/12/02/how-to-number-rows-in-mysql/">How to number rows in MySQL, by Xaprb</a></p>
<div>[adsense:468x60:4496506397]</div>
<p>Using Xaprb's site and code I quickly produced a simple select query which ordered my list&hellip;</p>
<pre language="mysql">
SET @cnt = 0;

SELECT
  mid, title, weight,
  @cnt := (@cnt + 1) AS row_number
FROM menu
WHERE pid=36
ORDER BY title;
</pre>
<p>This selected all menu ID's, title's, weight's and a row count column which incremented a variable called cnt, filtering the list by menu items with a parent ID of 36 and ordering by the title (default ascending). This produced a list like this (EXAMPLE):</p>
<table style="margin: 10px auto;">
    <tbody>
        <tr>
            <th>ID</th>
            <th>Sport</th>
            <th>Weight</th>
            <th>Row Count</th>
        </tr>
        <tr class="odd">
            <td>13</td>
            <td>golf</td>
            <td>19</td>
            <td>1</td>
        </tr>
        <tr class="even">
            <td>1</td>
            <td>rugby</td>
            <td>-2</td>
            <td>2</td>
        </tr>
        <tr class="odd">
            <td>4</td>
            <td>soccer</td>
            <td>11</td>
            <td>3</td>
        </tr>
        <tr class="even">
            <td>20</td>
            <td>swimming</td>
            <td>-8</td>
            <td>4</td>
        </tr>
    </tbody>
</table>
<div>[adsense:468x60:4496506397]</div>
<p>This table shows that the only ordered columns are the title and row count, but the weight (which is used by Drupal) is NOT ordered&hellip; This means we're half way to a solution!</p>
<p>Unfortunately, with the <code>UPDATE</code> command, you cant use the variable column additionally as you would in a select (eg, above)&hellip; However I have learned that you can include the <em>formula</em> part in the <strong>set</strong> section of the <code>UPDATE</code>&hellip; I shall Explain by example!</p>
<pre language="mysql">
SET @cnt = 0;

UPDATE menu
SET weight = @cnt := (@cnt+1)
WHERE pid=36
ORDER BY title;
</pre>
<p>Same situation as above, (filtering and ordering) - basically I want to update all menu items with a parent ID of 36, ordered by title in ascending order and I want to set the weight to the value of <em>@cnt</em> which itself is equal to its current value plus one</p>
<p>I ran that and was politely told that a number of rows had been updated, so I ran the select again and was shown:</p>
<table style="margin: 10px auto;">
    <tbody>
        <tr>
            <th>ID</th>
            <th>Sport</th>
            <th>Weight</th>
            <th>Row Count</th>
        </tr>
        <tr class="odd">
            <td>13</td>
            <td>golf</td>
            <td>1</td>
            <td>1</td>
        </tr>
        <tr class="even">
            <td>1</td>
            <td>rugby</td>
            <td>2</td>
            <td>2</td>
        </tr>
        <tr class="odd">
            <td>4</td>
            <td>soccer</td>
            <td>3</td>
            <td>3</td>
        </tr>
        <tr class="even">
            <td>20</td>
            <td>swimming</td>
            <td>4</td>
            <td>4</td>
        </tr>
    </tbody>
</table>
<p>BRILLIANT! It worked!</p>
<p>I hope this helps people out - certainly taken the mundanity out of that job!</p>
