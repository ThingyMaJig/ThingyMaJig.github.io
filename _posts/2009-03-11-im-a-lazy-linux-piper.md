---
categories:
- tip
- svn
- linux
- howto
- geek
- drupal
layout: blog
title: I'm a lazy linux piper
created: 1236770433
permalink: blog/11-03-2009/lazy-linux-piping
---
This morning I updated a site to the latest release of Drupal 5.16. Nothing special there at all. I've done that many times as has (hopefully) mabye other drupal devs&hellip; However, I'm a bit of a newbie when it comes to SVN. Didn't I mention this drupal site was in an SVN repository? ;-)
<!--break-->

So, I've `svn copy`'d the trunk to an "_`update_to_5.16`_" branch, checked out this branch and done a `cvs up -dP -r DRUPAL-5-16`. Everything is going according to plan so far. Next I run `svn status` to get a list of files which I need to mark as added or deleted (or to list anything else which has gone wrong). What happens next is I get a list of hundreds of CVS _Template_ files which have been added to the CVS folders. For example:

```
?      profiles/default/CVS/Template
M      profiles/default/CVS/Entries
M      profiles/default/CVS/Tag
?      profiles/CVS/Template
M      profiles/CVS/Tag
?      themes/bluemarine/CVS/Template
M      themes/bluemarine/CVS/Entries
M      themes/bluemarine/CVS/Tag
M      themes/engines/phptemplate/phptemplate.engine
?      themes/engines/phptemplate/CVS/Template
M      themes/engines/phptemplate/CVS/Entries
M      themes/engines/phptemplate/CVS/Tag
?      themes/engines/CVS/Entries.Log
?      themes/engines/CVS/Template
M      themes/engines/CVS/Tag
?      themes/garland/images/CVS/Template
M      themes/garland/images/CVS/Entries
M      themes/garland/images/CVS/Tag
?      themes/garland/minnelli/CVS/Template
M      themes/garland/minnelli/CVS/Entries
M      themes/garland/minnelli/CVS/Tag
?      themes/garland/minnelli/color/CVS/Template
M      themes/garland/minnelli/color/CVS/Entries
M      themes/garland/minnelli/color/CVS/Tag
?      themes/garland/CVS/Template
...
...
```

So as you can see from this (shortened) list, several Entries & Tag files have been modified (along with 1 core file). The files labelled with a ? are ones which are new in the _Working Copy_ which are not in the SVN repository.

Now those who know me or read my blog may know I dont enjoy tedious jobs. I think the definition of tedious could be described as typing `svn add themes/garland/minnelli/CVS/Template` hundreds of times (for each ? file in list which was much longer that than). What do I do when I have to do tedious jobs? I find a bash script which will do it for me and then blog about it!

So, firstly, I tried piping the `svn st` results through grep to filter out the results which need adding. I also add a filter to only add Template entries to start with.

```bash
svn st | grep ^? | grep Template$
```

The `svn st` is short-hand for `svn status`.

Next we need to strip out the question marks and spaces at the beginning of each line. Enter `gawk`. I'm not an expert at `gawk`, but this time it seemed to _Just Work<sup>TM</sup>_.

```bash
svn st | grep ^? | grep Template$ | gawk '{ print $2 }'
```

I then trid to just pipe that into `svn add`. Subversion did **not** appreciate this and complained about there not being enough arguments. "Ok", I thought &mdash; I've seen this problem before when trying to work with the results of a list of files produced by the `find` command&hellip; What about the `xargs` command? _<abbr title="English slang for 'Would you believe it'">Would you adam and eve it</abbr>_? It worked!

```bash
$ svn st | grep ^? | grep Template$ | gawk '{ print $2 }' | xargs svn add
A         profiles/default/CVS/Template
A         profiles/CVS/Template
A         themes/bluemarine/CVS/Template
A         themes/engines/phptemplate/CVS/Template
A         themes/engines/CVS/Template
A         themes/garland/images/CVS/Template
A         themes/garland/minnelli/CVS/Template
A         themes/garland/minnelli/color/CVS/Template
A         themes/garland/CVS/Template
A         themes/garland/color/CVS/Template
A         themes/CVS/Template
A         themes/chameleon/CVS/Template
A         themes/chameleon/marvin/CVS/Template
A         themes/pushbutton/CVS/Template
A         scripts/CVS/Template
A         sites/default/CVS/Template
A         sites/all/CVS/Template
A         sites/CVS/Template
A         misc/farbtastic/CVS/Template
A         misc/CVS/Template
A         CVS/Template
A         includes/CVS/Template
A         modules/aggregator/CVS/Template
A         modules/blog/CVS/Template
A         modules/system/CVS/Template
A         modules/upload/CVS/Template
A         modules/filter/CVS/Template
A         modules/node/CVS/Template
A         modules/drupal/CVS/Template
A         modules/help/CVS/Template
A         modules/forum/CVS/Template
A         modules/book/CVS/Template
A         modules/block/CVS/Template
A         modules/statistics/CVS/Template
A         modules/contact/CVS/Template
A         modules/CVS/Template
A         modules/tracker/CVS/Template
A         modules/path/CVS/Template
A         modules/ping/CVS/Template
A         modules/locale/CVS/Template
A         modules/profile/CVS/Template
A         modules/watchdog/CVS/Template
A         modules/comment/CVS/Template
A         modules/menu/CVS/Template
A         modules/legacy/CVS/Template
A         modules/search/CVS/Template
A         modules/throttle/CVS/Template
A         modules/poll/CVS/Template
A         modules/blogapi/CVS/Template
A         modules/color/images/CVS/Template
A         modules/color/CVS/Template
A         modules/taxonomy/CVS/Template
A         modules/user/CVS/Template
```

Brilliant! One line of commands joined together with a pipe and I have saved many, **many** minutes of tedious and bording typing!

