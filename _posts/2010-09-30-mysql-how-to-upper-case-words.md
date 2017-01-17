---
excerpt: "<p>&nbsp;I recently needed to clean up a MySQL Table which contained people's
  names. Upon searching the MySQL commands, I was surprised to find there was no equivalent
  of PHP's <a href=\"http://www.php.net/manual/en/function.ucfirst.php\">ucfirst</a>
  or <a href=\"http://www.php.net/manual/en/function.ucwords.php\">ucwords</a>. There
  were commands to convert entire strings into upper or lower case, but not <em>just
  the first letter</em>.</p>\r\n"
categories:
- tips
- programming
- mysql
- howto
- code
layout: blog
title: 'MySQL: How to upper-case words'
created: 1285848908
permalink: blog/30-09-2010/mysql-how-upper-case-words
---
<p>&nbsp;I recently needed to clean up a MySQL Table which contained people's names. Upon searching the MySQL commands, I was surprised to find there was no equivalent of PHP's <a href="http://www.php.net/manual/en/function.ucfirst.php">ucfirst</a> or <a href="http://www.php.net/manual/en/function.ucwords.php">ucwords</a>. There were commands to convert entire strings into upper or lower case, but not <em>just the first letter</em>.</p>
<!--break-->
<p>However, I quickly found a simple script to make a word uppercase:</p>
<pre class="mysql">
UPDATE table SET field=CONCAT(UCASE(SUBSTRING(field, 1, 1)),LCASE(SUBSTRING(field, 2)));
</pre>
<h2>What if the name needs two capitals?</h2>
<p>But then I found an issue; what if someone has a hyphen in their name (like O'Reily) or have a double barreled name (like Smith-John)? This script would make them <em>O'reily</em> and <em>Smith-john</em> (respectively).</p>
<p>I did some more searching and have ended up writing the following two MySQL functions (tested in MySQL 5.1).</p>
<h2>Capitalize any given string</h2>
<p>This function is a clone of the <strong>ucfirst</strong> function in PHP.</p>
<pre class="mysql">
DROP FUNCTION IF EXISTS UC_FIRST;
CREATE FUNCTION UC_FIRST(oldWord VARCHAR(255)) RETURNS VARCHAR(255)
  RETURN CONCAT(UCASE(SUBSTRING(oldWord, 1, 1)),SUBSTRING(oldWord, 2));
</pre>
<h2>Capitalize a string based on a delimiter</h2>
<p>This function takes a string and a delimiter and capitalizes every words based on breaking the string up using the delimiter.</p>
<pre class="mysql">
DROP FUNCTION IF EXISTS UC_DELIMETER;
DELIMITER //
CREATE FUNCTION UC_DELIMETER(oldName VARCHAR(255), delim VARCHAR(1), trimSpaces BOOL) RETURNS VARCHAR(255)
BEGIN
  SET @oldString := oldName;
  SET @newString := "";
  
  tokenLoop: LOOP
    IF trimSpaces THEN SET @oldString := TRIM(BOTH " " FROM @oldString); END IF;
    
    SET @splitPoint := LOCATE(delim, @oldString);
    
    IF @splitPoint = 0 THEN
      SET @newString := CONCAT(@newString, UC_FIRST(@oldString));
      LEAVE tokenLoop;
    END IF;
  
    SET @newString := CONCAT(@newString, UC_FIRST(SUBSTRING(@oldString, 1, @splitPoint)));
    SET @oldString := SUBSTRING(@oldString, @splitPoint+1);
  END LOOP tokenLoop;
  
  RETURN @newString;
END//
DELIMITER ;
</pre>
<h2>A quick demo on capitalizing a name in MySQL</h2>
<p>This can then be tested using a line such as this:</p>
<pre class="mysql">
SELECT UC_DELIMETER('testing-this-thing', '-', TRUE);
</pre>
<p>Which should produce</p>
<pre class="mysql">
Testing-This-Thing
</pre>
<h2>How should I use this function in MySQL?</h2>
<p>The <code>UC_DELIMETER</code> function takes 3 parameters:</p>
<ul>
    <li>String to work on</li>
    <li>Delimiter - one character only.</li>
    <li>Trim Spaces Boolean. If <code>TRUE</code> then spaces get removed from each end of a string. See Below</li>
</ul>
<p>The trailing spaces paramenter was added because some people had entered their names with a space after the hyphen in their name, for example:</p>
<pre>
John- smith
</pre>
<p>This feature would allow you to run:</p>
<pre class="mysql">
SELECT UC_DELIMETER('John- smith', '-', TRUE);
</pre>
<p>This would produce:</p>
<pre>
John-Smith
</pre>
<p>Can anybody suggest any improvements to this? The above simply satisfies my needs, but it'd be great to get this expanded to be more &quot;general purpose&quot;.</p>
