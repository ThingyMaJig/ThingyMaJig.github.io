---
categories:
- code
- programming
layout: blog
title: Entity Encode Text Using PHP
created: 1297087617
permalink: blog/07-02-2011/entity-encode-text-using-php
---
Ever needed to Entity Encode a block of text (maybe to partially protect it from spam bots or just hide/obfuscate the content?). I did. It's pretty easy.

If it's just basic Entity Encoding, you can always use `htmlentities` - however this only does the "important" characters such as quotes, ampersands and angle brackets.
<!--break-->
If you want to entity encode ALL characters from a string, try this:

```php
$phone_number = mb_encode_numericentity('0123 456789', array(0x00, 0xff, 0,  0xffff), 'UTF-8');
```

That produces:

    &amp;#48;&amp;#49;&amp;#50;&amp;#51;&amp;#32;&amp;#52;&amp;#53;&amp;#54;&amp;#55;&amp;#56;&amp;#57;

This is pretty useful if you want to hide a phone number from things like the Skype auto-highlighter.
