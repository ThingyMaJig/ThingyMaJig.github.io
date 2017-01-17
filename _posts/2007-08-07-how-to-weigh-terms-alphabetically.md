---
excerpt: "<p>Following on from my <em><a title=\"Numbering Rows in MySQL\" href=\"http://www.thingy-ma-jig.co.uk/blog/02-01-2007/ordering-menu-items-alphabetically\">Numbering
  Rows in MySQL</a></em> article, today I needed to populate the <strong>weight column</strong>
  of the <em>term_data</em> table for about a hundred <strong>terms</strong> so that
  they incremented in alphabetical order. This was, on the face of it, a very tedious
  task; click edit, select weight from drop-down, submit, 'goto 1'.</p>\r\n<p>As I
  said in my <em><a title=\"Numbering Rows in MySQL\" href=\"http://www.thingy-ma-jig.co.uk/blog/02-01-2007/ordering-menu-items-alphabetically\">Numbering
  Rows in MySQL</a></em> article, I don't like tedious - but I do like over-complicated
  methods which actually make my life more interesting and less tedious... Enter a
  nifty <strong>MySQL</strong> script!</p>\r\n"
categories:
- programming
- mysql
- drupal
- cool
layout: blog
title: How to weigh terms alphabetically
created: 1186484363
permalink: blog/07-08-2007/how-to-weigh-terms-alphabetically
---
<p>Following on from my <em><a title="Numbering Rows in MySQL" href="http://www.thingy-ma-jig.co.uk/blog/02-01-2007/ordering-menu-items-alphabetically">Numbering Rows in MySQL</a></em> article, today I needed to populate the <strong>weight column</strong> of the <em>term_data</em> table for about a hundred <strong>terms</strong> so that they incremented in alphabetical order. This was, on the face of it, a very tedious task; click edit, select weight from drop-down, submit, 'goto 1'.</p>
<p>As I said in my <em><a title="Numbering Rows in MySQL" href="http://www.thingy-ma-jig.co.uk/blog/02-01-2007/ordering-menu-items-alphabetically">Numbering Rows in MySQL</a></em> article, I don't like tedious - but I do like over-complicated methods which actually make my life more interesting and less tedious... Enter a nifty <strong>MySQL</strong> script!</p>
<!--break-->
<p>This is basically the same as the <em><a title="Numbering Rows in MySQL" href="http://www.thingy-ma-jig.co.uk/blog/02-01-2007/ordering-menu-items-alphabetically">Numbering Rows in MySQL</a></em> tip, except this works on the <em>term_data</em> table instead of <em>menu</em>. Its defines a <strong>variable</strong> and updates the table, setting the <strong>weight</strong> to the <strong>variable</strong> value before <strong>incrementing</strong> it.</p>
<pre language="mysql">
SET @cnt = 0;

UPDATE term_data
SET weight = @cnt := (@cnt+1)
WHERE vid=2
ORDER BY name;
</pre>
<p>If you use SQLyog, as I do, you must hit the button to <strong>Execute All Queries</strong> (the double green arrow, or Shift+F5 for the shortcut-minded ones). If you don't do this you end up sitting there like a lemon for a few minutes wondering why no rows are being updated.</p>
<p>I might be tempted in the future to turn this into a module where you can set all the weights for terms in a given vocabulary based on an alphabetical order.</p>
