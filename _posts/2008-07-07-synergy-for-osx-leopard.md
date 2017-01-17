---
excerpt: "<p>I recently setup my PC in the living room with my TV so I could play
  games and watch streamed video from the net (eg, <a title=\"BBC iPlayer\" href=\"http://www.bbc.co.uk/iplayer/\">BBC's
  iPlayer</a>). Unfortunately this always meant having a keyboard and mouse attached.</p>\r\n<p>Then
  came along <a title=\"Synergy - the software KVM App\" href=\"http://synergy2.sourceforge.net/\">Synergy</a>.</p>\r\n"
categories:
- technology
- software
- mac
- howto
- geek
layout: blog
title: Synergy for OSX Leopard
created: 1215424852
permalink: blog/07-07-2008/synergy-osx-leopard-deamon-mode
---
<p>I recently setup my PC in the living room with my TV so I could play games and watch streamed video from the net (eg, <a title="BBC iPlayer" href="http://www.bbc.co.uk/iplayer/">BBC's iPlayer</a>). Unfortunately this always meant having a keyboard and mouse attached.</p>
<p>Then came along <a title="Synergy - the software KVM App" href="http://synergy2.sourceforge.net/">Synergy</a>.</p>
<!--break-->
<p>[adsense:468x60:4496506397]</p>
<p>Synergy is like a software <a title="Wikipedia definition of a KVM Switch" href="http://en.wikipedia.org/wiki/KVM_switch">KVM switch</a>... First you configure the server and teach it where the screens &quot;<em>are</em>&quot; (this will make sense in a minute). You start then server on the machine which has control of the keyboard and mouse - in this case my laptop - and the client(s) - in this case just my PC although you can configure more. The server keeps and eye on where the controlling mouse is on the screens. If you move it off one of the configured edges then you take control of the machine thats configured for that edge. For example, Screen B could be to the right of Screen A (and therefore Screen A is to the left of B - but not necessarily!).</p>
<p>In my case all I have to do on my Mac Book Pro is to nudge the pointer off the top of the screen and I then take control of the PC plugged into my TV!</p>
<h2>Nothing is ever easy....</h2>
<p>Unfortunately, it appears that Synergy (V1.3.1 at least) doesn't like running in <strong><em>Deamon Mode</em></strong> on OSX 10.5. <em><strong>Deamon Mode</strong></em> allows the server to run quietly in the background without requiring you to have a terminal window open all the time. For some reason it just crashes.</p>
<p>This morning I had a brainwave - the <a title="Wikipedia article about the Screen GNU App" target="_top" href="http://en.wikipedia.org/wiki/GNU_Screen">Screen</a> command in UNIX operating systems allows you to start a process and detach it from the terminal! I generally only use this for applications I want to run on a remote machine from which I might get disconnected half way through (eg, if I want to run a long download which I can periodically check back on but dont want to break if my internet connection drops). Normally in UNIX, a process gets tied to the terminal it is run from so if the terminal dies (or the SSH connection to a remote machine), usually the child processes die with it. <em><strong>Screen</strong></em> stops this!</p>
<p>[adsense:468x60:4496506397]</p>
<p>I simply created a <em>startup script</em> like this</p>
<pre language="bash">
#!/bin/sh
screen -d -m /Applications/synergy-1.3.1/synergys --config /Applications/synergy-1.3.1/synergy.conf -f
exit
</pre>
<p>The <code>-d -m</code> options tell screen to start in a forked and detached mode!</p>
<p>You can then use the Accounts section in System Preferences to tell it to run the startup script upon login! Easy!</p>
