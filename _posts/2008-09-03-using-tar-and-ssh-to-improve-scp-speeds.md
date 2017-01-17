---
excerpt: "<p>I am currently in the process of migrating several dozen sites between
  two servers. I tried using <a href=\"http://en.wikipedia.org/wiki/Secure_copy\"
  title=\"SCP - Secure Copy\">scp</a> command to copy the sites over however <a href=\"http://en.wikipedia.org/wiki/Secure_copy\"
  title=\"SCP - Secure Copy\">scp</a> is a <strong>very slow command when transferring
  many small files</strong>.</p>\r\n<p>I did a little research on&nbsp;<a href=\"http://www.cyberciti.biz/faq/howto-use-tar-command-through-network-over-ssh-session/\"
  title=\"How to use tar over a secure SSH connection @ UnixCraft\">how to use tar
  over an ssh connection</a>&nbsp;and realised that you could specify the <em><a href=\"http://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29\"
  title=\"STDOut on Wikipedia\">stdout</a></em> on <em>tar.</em></p>\r\n"
categories:
- linux
- howto
- geek
layout: blog
title: Using Tar and SSH to improve SCP Speeds
created: 1220439975
permalink: blog/03-09-2008/using-tar-and-ssh-improve-scp-speeds
---
<p>I am currently in the process of migrating several dozen sites between two servers. I tried using <a href="http://en.wikipedia.org/wiki/Secure_copy" title="SCP - Secure Copy">scp</a> command to copy the sites over however <a href="http://en.wikipedia.org/wiki/Secure_copy" title="SCP - Secure Copy">scp</a> is a <strong>very slow command when transferring many small files</strong>.</p>
<p>I did a little research on&nbsp;<a href="http://www.cyberciti.biz/faq/howto-use-tar-command-through-network-over-ssh-session/" title="How to use tar over a secure SSH connection @ UnixCraft">how to use tar over an ssh connection</a>&nbsp;and realised that you could specify the <em><a href="http://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29" title="STDOut on Wikipedia">stdout</a></em> on <em>tar.</em></p>
<!--break-->
<h2>How?</h2>
<p>[adsense:468x60:4496506397]</p>
<p>Using this method effectively sends the compressed tarball to the terminal. You then pipe that into an <em>ssh session</em> which is running the extract version of the previous tar function along with the <em>change directory</em>&nbsp;argument. This, essentially, sends the compressed tarball into a decompression process at the other end over a secure ssh &quot;pipe&quot;.</p>
<p>The result is a pretty quick file transfer which - as the data is being sent in a compressed GZIP form (of BZip2 if you replace the z with a j in the tar functions) you save on bandwidth too.</p>
<p>Here an an example of how to do this, assuming you are in (for example)&nbsp;<code>/var/www/html/</code> and the website you want to transfer is the folder <code>www.example.com</code>.</p>
<pre language="bash">
tar czf - www.example.com/ | ssh joebloggs@otherserver.com tar xzf - -C ~/</pre>
<p>This will send the entire www.example.com folder over to the home folder on your target server in <strong>compressed </strong>form over and <strong>encrypted </strong>connection.</p>
<p>&nbsp;</p>
<hr />
<p>This is the latest version, based on <a href="https://gist.github.com/KartikTalwar/4393116">some performance tweaks to SSH</a> for older boxes, like low power NAS'. In my case, SSH was maxing out the CPU on the NAS which was limiting my transfer rate.</p>
<pre language="bash">
ssh 192.168.1.2 -T -c arcfour -o Compression=no -x "tar cf - /remote/path" | tar xf - -C .
</pre>
<p><a href="https://gist.github.com/KartikTalwar/4393116">The Gist</a> has the explanation, but basically we are interested in the following items:</p>
<ul>
<li>T: turn off pseudo-tty to decrease cpu load on destination.</li>
<li>c arcfour: use the weakest but fastest SSH encryption. Must specify "Ciphers arcfour" in sshd_config on destination.</li>
<li>o Compression=no: Turn off SSH compression.</li>
<li>x: turn off X forwarding if it is on by default.</li>
</ul>
<p>In my case, this meant going from ~0.5Mb/s to around 3Mb/s.</p>
