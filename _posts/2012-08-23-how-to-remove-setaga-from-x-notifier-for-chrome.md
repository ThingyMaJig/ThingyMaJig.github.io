---
categories:
- tips
layout: post
title: How to remove Setaga from X-Notifier for Chrome
created: 1345716016
permalink: blog/23-08-2012/how-to-remove-setaga-from-x-notifier-for-chrome
---
<p>I am a huge fan of the <a href="https://chrome.google.com/webstore/detail/x-notifier-for-gmailhotma/cdfjbkbddpfnoplfhceolpopfoepleco">X Notifier extension for Chrome</a>, however recently the developer has added an advertising component called <a href="http://www.setaga.com/">Setaga</a>. I don't recall agreeing or opt-ing into this, but its possible I did without thinking. In any case, I hate this and wanted to remove it.</p>
<!-- break -->
<p>I found <a href="http://xnotifier.tobwithu.com/wp/forums/topic/setaga" title="Segata Forum Post">a post on their forum</a>, but could not see how to remove it. So I did it myself. Here's how:</p>
<ol>
  <li>Find the extension. For me (on Windows 7) it was in:<br /><pre>C:\Users\{USERNAME}\AppData\Local\Google\Chrome\User Data\Default\Extensions\apebebenniibdlpbookhgelaghfnaonp\1.0.12_0</pre>. Note, that random text is the application ID. You also see it in the URL for the extension on the <a href="https://chrome.google.com/webstore/category/home">Webstore site</a>.</li>
  <li>Next, open <code>manifest.json</code> in something like Notepad++.</li>
  <li>Lines 8-12 look like this. Remove them (ensuring the syntax of the json remains in-tact):<pre language="js">
   "content_scripts": [ {
      "js": [ "content/setaga/inject.js" ],
      "matches": [ "http://*/*" ],
      "run_at": "document_start"
   } ],
</pre>Save the file.</li>
  <li>Go into the Content folder and delete the <code>segata</code> folder.</li>
  <li>Restart Chrome</li>
</ol>
<p>It's possible this "fix" may need to be reapplied when the addon updates. Hence me writing this. So I remember how to do it.</p>
