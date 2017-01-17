---
excerpt: "<p>I recently needed to <strong>force a PDF to download</strong> using <a
  title=\"Apache HTTPD Site\" href=\"http://httpd.apache.org/\"><strong>Apache</strong></a>.
  The default behaviour for most browsers is to try to open the PDF inside the browser
  itself. This is fine for a small <strong>PDF</strong> or for powerful machines -
  but a large <strong>PDF </strong>on even a modest machine can often lock the browser
  up. This needed fixing!</p>\r\n<p>After 20 minutes of perusing the <a title=\"Apache
  HTTPD Site\" href=\"http://httpd.apache.org/\"><strong>Apache</strong></a> documents,
  I happened across the <em><a title=\"Apache Docs, FilesMatch\" href=\"http://httpd.apache.org/docs/2.0/mod/core.html#filesmatch\">FilesMatch</a></em>
  option which takes <em>Regular Expressions</em>. <a title=\"Regular Expressions
  Wikipedia definition\" href=\"http://en.wikipedia.org/wiki/Regular_expression\"><em>Regular
  Expressions</em></a> are cool things which pattern match; you give it a rather complicated
  (yet logical) pattern and it matches it for you. Initially I used something like
  this...</p>\r\n"
categories:
- software
- programming
- linux
- cool
- apache
layout: blog
title: Force a PDF to download
created: 1186418356
permalink: blog/06-08-2007/force-a-pdf-to-download
---
<p>I recently needed to <strong>force a PDF to download</strong> using <a title="Apache HTTPD Site" href="http://httpd.apache.org/"><strong>Apache</strong></a>. The default behaviour for most browsers is to try to open the PDF inside the browser itself. This is fine for a small <strong>PDF</strong> or for powerful machines - but a large <strong>PDF </strong>on even a modest machine can often lock the browser up. This needed fixing!</p>
<p>After 20 minutes of perusing the <a title="Apache HTTPD Site" href="http://httpd.apache.org/"><strong>Apache</strong></a> documents, I happened across the <em><a title="Apache Docs, FilesMatch" href="http://httpd.apache.org/docs/2.0/mod/core.html#filesmatch">FilesMatch</a></em> option which takes <em>Regular Expressions</em>. <a title="Regular Expressions Wikipedia definition" href="http://en.wikipedia.org/wiki/Regular_expression"><em>Regular Expressions</em></a> are cool things which pattern match; you give it a rather complicated (yet logical) pattern and it matches it for you. Initially I used something like this...</p>
<!--break-->
<pre language="apache">
<Files *.pdf>
  ForceType application/pdf
  Header set Content-Disposition attachment
</Files>
</pre>
<p>This worked PERFECTLY - except some files had upper-case extensions and some had lower and I could see situations in the future where combinations of upper and lower case would be used too - just to piss me off! Because of this, not even this would work...</p>
<pre language="apache">
<FilesMatch "\.(pdf|PDF)">
  ForceType application/pdf
  Header set Content-Disposition attachment
</FilesMatch>
</pre>
<p>That would match perfectly - as long as it was an EXACT match on upper OR lower case.</p>
<p>I was reaching the end of my patience - that is until I read the <strong><a title="Using Character Classes" href="http://perldoc.perl.org/perlrequick.html#Using-character-classes">Using Character Classes</a></strong> on <em><a title="Perl Doc" href="http://perldoc.perl.org/">PerlDoc</a></em>.</p>
<p>This showed me that I could force the <em>RegEx</em> (short for <em>Regular Expressions</em>) to match in a <strong>case-insensitive</strong> manner. This lead me to the following...</p>
<pre language="apache">
<FilesMatch "\.(?i:pdf)$">
  ForceType application/pdf
  Header set Content-Disposition attachment
</FilesMatch>
</pre>
<p>However this only worked in proper browsers - and the bulk of the world are sadistic enough&nbsp; to use Internet Explorer based ones. For some reason, if <em>Internet Explorer</em> see's the content type &quot;<em><strong>Application/PDF</strong></em>&quot; it will simply open it up in the reader. The solution? Why not pretend its a bog standard <a title="Octet Stream definition at Wikipedia" href="http://en.wikipedia.org/wiki/Octet_stream"><em>Octet Stream</em></a>, just like a Zip file? After all, that's basically all it is; a binary file... <em>A steam of bytes</em>.</p>
<pre language="php">
<FilesMatch "\.(?i:pdf)$">
  ForceType application/octet-stream
  Header set Content-Disposition attachment
</FilesMatch>
</pre>
<p>And there you have it&hellip; A perfectly working modification to <strong>force all PDF files to download</strong> - this will work for any file extensions you chose to put into the <a title="FilesMatch definition at the Apache Docs" href="http://httpd.apache.org/docs/2.0/mod/core.html#filesmatch"><em><strong>FilesMatch</strong></em></a> argument!</p>
