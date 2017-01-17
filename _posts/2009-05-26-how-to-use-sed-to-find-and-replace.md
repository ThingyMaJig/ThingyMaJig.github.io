---
excerpt: "<p>After Worldpay recently changed to use the RBS&nbsp;system, I was tasked
  with finding every instance of <code>select.worldpay.com/wcc/purchase</code> in
  our forms and replacing it with <code>select.wp3.rbsworldpay.com/wcc/purchase</code>.
  There appeared to be thousands of files and I&nbsp;wasn't going to do it manually&hellip;</p>\r\n"
categories:
- tip
- linux
- howto
- bash
layout: blog
title: How to use "sed" to find and replace
created: 1243345565
permalink: blog/26-05-2009/how-use-sed-find-and-replace
---
<p>After Worldpay recently changed to use the RBS&nbsp;system, I was tasked with finding every instance of <code>select.worldpay.com/wcc/purchase</code> in our forms and replacing it with <code>select.wp3.rbsworldpay.com/wcc/purchase</code>. There appeared to be thousands of files and I&nbsp;wasn't going to do it manually&hellip;</p>
<!--break-->
<p>A quick google later and I found that you can easily use a combination of Grep (to find the files) and sed (a text stream editor) to change the content. Notice how in sed, the find and replace strings have to have the forward slash escaped as we're using it as delimiter.</p>
<pre class="codeblock">
grep "select.worldpay.com/wcc/purchase" . -Rl | xargs sed -i 's/select.worldpay.com\/wcc\/purchase/select.wp3.rbsworldpay.com\/wcc\/purchase/g'</pre>
<p>This probably isn't perfect - but it did the job for me and I hope it helps anyone else that stumbles upon it&nbsp;:)</p>
