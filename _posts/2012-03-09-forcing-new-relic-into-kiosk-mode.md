---
categories:
- drupal
- new relic
- greasemonkey
layout: blog
title: Forcing New Relic into Kiosk Mode
created: 1331305531
permalink: blog/09-03-2012/forcing-new-relic-into-kiosk-mode
---
<p>New Relic is a great bit of kit - nobody can deny that. I recently needed to configure it on a standalone box so it could be open on a large screen so my colleagues and I could see the current status of our sites. New Relic has a <em>Kiosk Mode</em> which strips out some of the navigation from the page an optimises it for "viewing only". Very handy.</p>
<!--break-->
<p>I wanted a setting to force (or at least default) the page into Kiosk mode so that when I opened the bookmark on the browser, I didn't have to scroll to the bottom, click it, scroll back up and then refresh any other relevant tabs. It didn't look like there was a feature for this and the Kiosk Mode link was just a java function call; there was no URL.</p>
<p>So I turned to GreaseMonkey.</p>
<h2>Enter GreaseMonkey</h2>
<p><a href="http://www.greasespot.net/">GreaseMonkey</a> is a <a href="https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/">Firefox Addon</a> which allows you to bind custom JS scripts to all (or specific) pages. There is a <a href="http://userscripts.org/">repository of over 74,000 scripts</a> which let you customize all kinds of sites (Twitter, Gmail, Facebook, etc) including <a href="http://userscripts.org/tags/drupal">Drupal</a>.</p>
<p>However there was nothing for New Relic.</p>
<p>Until now.</p>
<h2>Using GreaseMonkey with New Relic</h2>
<p>As it turns out, the script is <strong>very</strong> simple.</p>
<pre language="javascript">
// ==UserScript==
// @name            New Relic Kiosk Mode
// @namespace       http://www.thingy-ma-jig.co.uk/
// @icon            http://www.thingy-ma-jig.co.uk/sites/thingy-ma-jig.co.uk/files/greasemonkey/NewRelic_inline_small.png
// @description     Force New Relic into Kiosk mode by setting the cookie on page load if ?kiosk is in the URL
// @include         https://rpm.newrelic.com/*?kiosk
// @updateURL       http://www.thingy-ma-jig.co.uk/sites/thingy-ma-jig.co.uk/files/greasemonkey/newrelic-kioskmode.user.js
// @version         1.0
// ==/UserScript==

unsafeWindow.RPM.kioskMode._setCookie();
</pre>
<p>Once the cookie is set, New Relic handles the rest. All you need to do is append "<code>?kiosk</code>" onto the URL (maybe in your bookmarks?) and the page loads in Kiosk mode.</p>
<p>You can install the script by clicking on this button.</p>
<p style="text-align:center"><a href="http://www.thingy-ma-jig.co.uk/sites/thingy-ma-jig.co.uk/files/greasemonkey/newrelic-kioskmode.user.js" class="button blue bigbutton">Install Kiosk Mode Script</a></p>
<h2>Find It On UserScripts.org</h2>
<p>I have also <a href="http://userscripts.org/scripts/show/127956">added the script to UserScripts.org</a>, for those that are interested.</p>
