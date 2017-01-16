---
excerpt: "<p>A while ago we started having issues running a website. Bandwidth. Upon
  investigation, we saw that the majority of bandwidth was being use by image files
  and of those, lot was from the ImageCache folder. It was also causing a lot of excess
  server load by consuming Apache processes. Something needed to be done.</p>\r\n"
categories:
- performance
- howto
- geek
- drupal
layout: post
title: Drupal, ImageCache & Performance
created: 1258198096
permalink: blog/14-11-2009/drupal-imagecache-performance
---
<p>A while ago we started having issues running a website. Bandwidth. Upon investigation, we saw that the majority of bandwidth was being use by image files and of those, lot was from the ImageCache folder. It was also causing a lot of excess server load by consuming Apache processes. Something needed to be done.</p>
<!--break-->
<div>[adsense:468x60:4496506397]</div>
<p>Our first step was to farm all ImageCache handling off to a cheap server with lots of bandwidth. We rented a VPS from A2B2 and setup &nbsp;sub-domain, files.example.com, to point at this server. I installed Lighttpd as, from experience, it is VERY good at serving files quickly and &quot;cheaply&quot;. After the basic configuration (such as setting up the VHost)&nbsp;we needed to figure out how to get the files over there. I toyed with setting up a NFS share over the internet and mapping the files folder directly to the VPS, but there were some risks with it (dropped connections, VPS rebooting, etc) so I&nbsp;ended up settling on using RSync over SSH.</p>
<p>So I setup a user on the VPS, mapped a files folder from the home directory to the website folder and enabled the user access in <code>/etc/ssh/sshd_config</code> by adding them to the <code>AllowUsers</code> line with something like:</p>
<pre class="codeblock" language="ssh">
AllowUsers joebloggs@123.123.123.123
</pre>
<p>This line restricts the user joebloggs to only connect from 123.123.123.123. We then setup some <a href="http://sial.org/howto/openssh/publickey-auth/">Key Authentication</a> so that we didn't need to hard code any passwords. The advantage of doing it this way is that you can give the client the public key, the host the private key and configure access so that the user can only use this key between the two machines.</p>
<p>Once this was done, we needed to setup RSync. With a little research I found the right set of commands to allow to sync the files folder over to the VPS.</p>
<pre class="codeblock" language="bash">
/usr/bin/rsync -cavz  -e 'ssh -v -i /root/.ssh/files.example.com_id_rsa' --progress  --delete /var/www/html/www.example.com/drupal/sites/all/files/imagecache/ joebloggs@files.example.com:~/files/imagecache/
</pre>
<p>So this might seem like a long and complicated command... but it's not really. The RSync args basically tell it to:</p>
<ul>
    <li>Checksum (c) - compares files by a checksum instead of date/time.</li>
    <li>Archive Mode (a) - basically enables several other features such as recursing into directories and preserving permissions &amp; timestamps.</li>
    <li>Verbosity (v) - handy for debugging later if it goes wrong.</li>
    <li>Compression (z) - Enable compression during transfer</li>
</ul>
<p>The next option (e) lets RSync know what remote shell to use. In this case, we're telling it to use SSH. The SSH command also has a few parameters. The first (v) is to enable Verbosity - again, good for debugging - and the second is for the identity file - in this case our public key for the VPS.</p>
<p>We have a couple more parameters going over to RSync; progress and delete. Progress simply tells us (in an interactive environment) how the transfers are doing; we don't really NEED this for the background tasks. The delete rule tells RSync to remove files from the VPS which are no longer on the main server; this helps to keep things tidy.</p>
<p>The next RSync parameter is the &quot;source&quot; path (ie what do we want to copy?). In this case, the ImageCache folder inside our sites files folder. The final parameter is where to copy it to, in this case the joebloggs account at the files server in the home folder.</p>
<p>After running this, we had a folder on the VPS which was a &quot;mirror&quot; of the main site's ImageCache. Things were looking good!</p>
<p>I then finished mapping the files folder in &quot;joebloggs&quot; home folder to the VPS's files VHost DocumentRoot. It was very important to keep the URL structure the same, so I created the following path...</p>
<pre class="codeblock" language="bash">
/var/www/html/files.example.com/sites/all/files
</pre>
<p>I then used /etc/fstab to create a bind entry so I could mount the website's files folder to the users home files folder. The reason I did this was because the joebloggs account also had an FTP account which was &quot;Root Jailed&quot; and I wanted people to be able to get to the files folder over FTP&hellip;</p>
<p>Ok&hellip; so now we could access the same file in two ways:</p>
<ul>
    <li>http://www.example.com/sites/all/files/imagecache/myprofile/myimage.png</li>
    <li>http://files.example.com/sites/all/files/imagecache/myprofile/myimage.png</li>
</ul>
<p>Everything was looking good, so I then setup RSync to run every 5 minutes to sync files over between the two servers.</p>
<p>The next step was to tell our website to point image cache URL's to the files server instead of the webserver. Drupal's theme overrides makes this VERY easy. The first step is to copy the <code>theme_imagecache</code> function from <a href="http://drupalcode.org/viewvc/drupal/contributions/modules/imagecache/imagecache.module?revision=1.112.2.5&amp;view=markup&amp;pathrev=DRUPAL-6--2">imagecache.module</a>&nbsp;(line 826) to your theme's template.php file. For reference, this is the function as of time of writing (it may change in future releases, so it is always worth checking your installed version).</p>
<pre class="codeblock" language="php">
function theme_imagecache($presetname, $path, $alt = '', $title = '', $attributes = NULL, $getsize = TRUE) {
  // Check is_null() so people can intentionally pass an empty array of
  // to override the defaults completely.
  if (is_null($attributes)) {
    $attributes = array('class' => 'imagecache imagecache-'. $presetname);
  }
  if ($getsize && ($image = image_get_info(imagecache_create_path($presetname, $path)))) {
    $attributes['width'] = $image['width'];
    $attributes['height'] = $image['height'];
  }

  $attributes = drupal_attributes($attributes);
  $imagecache_url = imagecache_create_url($presetname, $path);
  return '<img src="'. $imagecache_url .'" alt="'. check_plain($alt) .'" title="'. check_plain($title) .'" '. $attributes .' />';
}
</pre>
<p>Now we need to make a few tweaks. Firstly, rename the function to match your theme (eg, <code>garland_imagecache</code>). Secondly, add a line just before the return:</p>
<pre class="codeblock" language="php">
$imagecache_url = 'http://files.example.com'. $imagecache_url;
</pre>
<p>This adds the absolute URL prefix to the ImageCache URL (<code>$imagecache_url</code> starts with the base path which is usually a slash (/)).</p>
<p>Now you should have something like this:</p>
<pre class="codeblock" language="php">
function garland_imagecache($presetname, $path, $alt = '', $title = '', $attributes = NULL, $getsize = TRUE) {
  // Check is_null() so people can intentionally pass an empty array of
  // to override the defaults completely.
  if (is_null($attributes)) {
    $attributes = array('class' => 'imagecache imagecache-'. $presetname);
  }
  if ($getsize && ($image = image_get_info(imagecache_create_path($presetname, $path)))) {
    $attributes['width'] = $image['width'];
    $attributes['height'] = $image['height'];
  }

  $attributes = drupal_attributes($attributes);
  $imagecache_url = imagecache_create_url($presetname, $path);
  $imagecache_url = 'http://files.example.com'. $imagecache_url;
  return '<img src="'. $imagecache_url .'" alt="'. check_plain($alt) .'" title="'. check_plain($title) .'" '. $attributes .' />';
}
</pre>
<p>It was soon after this I realised a slight problem. What happens if you request a file which hasn't been sync'd over to the VPS yet? You will start getting 404 errors until it gets sync'd&hellip; And everything was going so well!</p>
<p>I did a little researched and stumbled into the LUA Scripting system in Lighttpd. This allowed me to create a very simple script which acts very much like Drupal's Clean URL Apache Rewrite rule which converts non-existing files into a index.php?q=blah format.</p>
<pre class="codeblock" language="lua">
attr = lighty.stat(lighty.env['physical.path'])
if (not attr) then
  lighty.header["Location"] = "http://www.example.com"  .. lighty.env["request.uri"]
  return 302
end
</pre>
<p>What does this do?! Well, it takes the physical path of the request (ie the internal filesystem path) and does a &quot;stat&quot; on it (which basically checks if it exists by getting some info on the file). If the attributes for the file dont exist then we need to redirect the request back to the main server where the file is more likely to exist. We send the redirect as a 302 rather than a 301 (as the redirect isn't permanent). Once the file gets transferred over via the next due RSync, Lighttpd will be able to &quot;stat&quot; the file and therefore wont redirect it anymore.</p>
<p>So, we did this for one of our big sites and our bandwidth usages dropped significantly as our VPS started handling the files. The main webserver also had less to do and started responding better too!</p>
<p>Our VPS gave us 400Gb for &pound;15/month. 400Gb with our host would have cost us somewhere in the region of &pound;600/month. So that's a pretty big saving!</p>
