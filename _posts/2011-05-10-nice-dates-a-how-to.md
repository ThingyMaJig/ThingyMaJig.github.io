---
categories:
- drupal
- howto
layout: blog
title: Nice Dates - A How To
created: 1305026696
permalink: blog/10-05-2011/nice-dates-a-how-to
---
<p>I've had several people ask me recently how I managed to get the nice date effect on my blog headers. It's quite simple really. All you need is:</p>
<ul>
<li><strong>An Image</strong> - A background image (a CSS Sprite) which contains the days, months and years.</li>
<li><strong>Some HTML</strong> - A VERY basic HTML template.</li>
<li><strong>Some CSS</strong> - To align the image sections.</li>
<li><strong>A PHP Snippet</strong> - A Drupal preprocess function.</li>
</ul>
<div><!--break--></div>
<h2>How to make a Nice Date block</h2>
<h3>The Image</h3>
<p>The image I use here was knocked up in Photoshop. It's just a grid of "output". Everything must be lined up pixel perfect to make the CSS easier to generate.</p>
<p style="text-align:center"><img alt="Dates grid" src="http://i.thingy-ma-jig.com/sites/thingy-ma-jig.co.uk/themes/tmj2/i/dates.png" style="width: 90px; height: 320px; border:1px solid #000;"></p>
<p>As you can see, on the left we have the Months (Jan -&gt; Dec), then the Days (01 -&gt; 31) and finally the years. You can also make out the grid layout; months are "2 rows per day" and day is "2 rows per year".</p>
<p>Using CSS, we can specify which "section" of the image appears in the HTML template. This is known as "spriting". It's a technique for clipping bits of a single image. Without the spriting technique, we'd need 12 (months) + 31 (days) + 7 (years) = 50 images!</p>
<h3>The HTML</h3>
<p>Using the following simple HTML, we can apply CSS to style appropriately.</p>
<pre language="html">
<div class="nice-date">
  <div class="month m-{MONTH_SHORT}">{MONTH_LONG}</div>
  <div class="day d-{DAY_SHORT}">{DAY_LONG}</div>
  <div class="year y-{YEAR_SHORT}">{YEAR_LONG}</div>
</div>
</pre>
<p>In the above, the values in curly braces are <em>variable</em> placeholders which should be replaced by appropriate data. SHORT implies a shortened date (eg, the year 2011 shortens to 11, the month January shortens to 01). LONG is the opposite of SHORT and is only there so that Search Engines and screen readers have some content to use (ie accessibility).</p>
<p> For example, 1st January 2011 would result in:</p>
<pre language="html">
<div class="nice-date">
  <div class="month m-01">January</div>
  <div class="day d-01">1st</div>
  <div class="year y-11">2011</div>
</div>
</pre>
<p>With CSS disabled (or to a Search Engine), this still reads <code>January 1st 2011</code>.</p>
<h3>The CSS</h3>
<p>The following CSS is used to align the sprite images into the HTML above.</p>
<pre language="css">
.nice_date {
  float:right;
  position:relative;
  width:41px;
  height:40px;
}

.nice_date .month,
.nice_date .day,
.nice_date .year {
  position:absolute;
  text-indent:-1000em;
  background:transparent url(i/dates.png) no-repeat;
}
.nice_date .month { top:5px;  left:0;  width:25px; height:10px; }
.nice_date .day   { top:20px; left:0;  width:25px; height:20px; }
.nice_date .year  { bottom:0; right:0; width:15px; height:40px; }

.nice_date .m-01 { background-position:0     0; }
.nice_date .m-02 { background-position:0  -10px; }
.nice_date .m-03 { background-position:0  -20px; }
.nice_date .m-04 { background-position:0  -30px; }
.nice_date .m-05 { background-position:0  -40px; }
.nice_date .m-06 { background-position:0  -50px; }
.nice_date .m-07 { background-position:0  -60px; }
.nice_date .m-08 { background-position:0  -70px; }
.nice_date .m-09 { background-position:0  -80px; }
.nice_date .m-10 { background-position:0  -90px; }
.nice_date .m-11 { background-position:0 -100px; }
.nice_date .m-12 { background-position:0 -110px; }

.nice_date .d-01 { background-position:-25px      0; }
.nice_date .d-02 { background-position:-25px  -20px; }
.nice_date .d-03 { background-position:-25px  -40px; }
.nice_date .d-04 { background-position:-25px  -60px; }
.nice_date .d-05 { background-position:-25px  -80px; }
.nice_date .d-06 { background-position:-25px -100px; }
.nice_date .d-07 { background-position:-25px -120px; }
.nice_date .d-08 { background-position:-25px -140px; }
.nice_date .d-09 { background-position:-25px -160px; }
.nice_date .d-10 { background-position:-25px -180px; }
.nice_date .d-11 { background-position:-25px -200px; }
.nice_date .d-12 { background-position:-25px -220px; }
.nice_date .d-13 { background-position:-25px -240px; }
.nice_date .d-14 { background-position:-25px -260px; }
.nice_date .d-15 { background-position:-25px -280px; }
.nice_date .d-16 { background-position:-50px      0; }
.nice_date .d-17 { background-position:-50px  -20px; }
.nice_date .d-18 { background-position:-50px  -40px; }
.nice_date .d-19 { background-position:-50px  -60px; }
.nice_date .d-20 { background-position:-50px  -80px; }
.nice_date .d-21 { background-position:-50px -100px; }
.nice_date .d-22 { background-position:-50px -120px; }
.nice_date .d-23 { background-position:-50px -140px; }
.nice_date .d-24 { background-position:-50px -160px; }
.nice_date .d-25 { background-position:-50px -180px; }
.nice_date .d-26 { background-position:-50px -200px; }
.nice_date .d-27 { background-position:-50px -220px; }
.nice_date .d-28 { background-position:-50px -240px; }
.nice_date .d-29 { background-position:-50px -260px; }
.nice_date .d-30 { background-position:-50px -280px; }
.nice_date .d-31 { background-position:-50px -300px; }

.nice_date .y-06 { background-position:-75px      0; }
.nice_date .y-07 { background-position:-75px -040px; }
.nice_date .y-08 { background-position:-75px -080px; }
.nice_date .y-09 { background-position:-75px -120px; }
.nice_date .y-10 { background-position:-75px -160px; }
.nice_date .y-11 { background-position:-75px -200px; }
.nice_date .y-12 { background-position:-75px -240px; }
.nice_date .y-13 { background-position:-75px -280px; }
</pre>
<p>As you can see, the first part just sets up the element sizes and positions. The last chuck of code defines the background offsets for the sprite.</p>
<p>Note: You may need to adjust bits of this based on your own settings. For example, if you remake the Dates PNG Sprite, you will need to adjust ALL the background positions (unless you keep to the same grid).</p>
<h3>The PHP</h3>
<p>The following PHP is used to embed the HTML Template into a Node.</p>
<pre language="php">
function THEMENAME_preprocess_node(&$vars) {
  $vars['nide_date'] = _THEMENAME_nice_date($vars['created']);
}
function _THEMENAME_nice_date($timestamp) {
  // Nice Date
  $ys = date('y', $timestamp);
  $yl = date('Y', $timestamp);
  $ms = date('m', $timestamp);
  $ml = date('M', $timestamp);
  $d  = date('d', $timestamp);

  return "<div class="nice-date">
  <div class=\"month m-{$ms}\">{$ml}</div>
  <div class=\"day d-{$d}\">{$d}</div>
  <div class=\"year y-{$ys}\">{$yl}</div>
</div>";
}
</pre>
<p>You've probably guessed, but you should replace THEMENAME with the name of the theme (eg, this theme is currently called "tmj2"). You now have a variable, <code>$nide_date</code> to print into your <code>node.tpl.php</code>.</p>
<p>You can also use the same function in <code>hook_preprocess_comment</code> too, if your site has comments enabled.</p>
<h3>Other Tips</h3>
<ul>
<li>You could bundle this up into a module to re-use across several sites. The preprocess hooks in Drupal 6+ are accessible from Modules.</li>
<li>You could alter the Sprite PNG to use a different font; I used Helvetica to fit with the site's clean/simple font design. Someone like <a href="http://morten.dk/">Morten (the King of Denmark)</a> might prefer to remake it using <a href="http://new.myfonts.com/fonts/underware/bello/">Bello</a> to match his blogs header title.</li>
<li>Altering the layout is possible too; maybe you're prefer to the date along the top and the month on the side?</li>
</ul>
<p>If you implement this on your site, please share your link below! (Note to spammers, my site uses No Follow and I check for link spam, so save us both some time ;-) hehe).</p>
