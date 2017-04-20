---
categories:
- drupal
- howto
- code
- tips
layout: blog
title: Thingy Ma Jig - Now brought to you by Drupal 7
created: 1295213632
permalink: blog/16-01-2011/thingy-ma-jig-now-brought-to-you-by-drupal-7
---
So, Drupal 7 is out. Have you heard? It was a bit of a quiet launch really. ;-)

When it came to upgrading by blog, I decided (eventually) that I needed to do a cleanup as the Database had been upgraded from 4.7, to 5 and then to 6 - with many modules added and removed in between. New year, new drupal, new blog (kinda)!
<!--break-->

It's also a good excuse to test out that some of the modules I maintain actually work in Drupal 7 (such as <a href="http://drupal.org/project/page_title">Page Title</a> and <a href="http://drupal.org/project/globalredirect">GlobalRedirect</a>). It's also a kick up the arse to get <a href="http://drupal.org/project/relevant_content">Relevant Content</a> ported to Drupal 7!

## Theme:

The theme was ported over relatively easily - although it's now using the Boron base theme to make it HTML 5 (another new whizz-bang thing). Mostly it was a matter of remembering to change a lot of instances where a variable got printed out to use the new render() function instead.

## Content:

The content was easily ported over using the following MySQL:

### Nodes

```mysql
INSERT INTO [NEW_DB].node
SELECT n.nid, n.vid, n.type, 'und', n.title, n.uid, n.status, n.created, n.changed, n.comment, n.promote, n.sticky, n.tnid, n.translate
FROM [OLD_DB].node n WHERE n.type IN ('blog', 'page');
```

```mysql
INSERT INTO [NEW_DB].node_revision
SELECT nr.nid, nr.vid, nr.uid, nr.title, nr.log, nr.timestamp, n.status, n.comment, n.promote, n.sticky
FROM [OLD_DB].node_revisions nr
INNER JOIN [OLD_DB].node n ON n.vid = nr.vid
WHERE n.type IN ('page', 'blog')
```

### Node body
```mysql
INSERT INTO [NEW_DB].field_data_body
SELECT
  'node', n.type, 0, nr.nid, nr.vid, 'und', 0, nr.body, nr.teaser,
  CASE nr.format
    WHEN 3 THEN 'full_html'
    ELSE 'filtered_html'
  END AS format
FROM [OLD_DB].node_revisions nr
INNER JOIN [OLD_DB].node n ON n.vid = nr.vid
WHERE n.type IN ('page', 'blog')
```

```mysql
INSERT INTO [NEW_DB].field_revision_body
SELECT
  'node', n.type, 0, nr.nid, nr.vid, 'und', 0, nr.body, nr.teaser,
  CASE nr.format
    WHEN 3 THEN 'full_html'
    ELSE 'filtered_html'
  END AS format
FROM [OLD_DB].node_revisions nr
INNER JOIN [OLD_DB].node n ON n.vid = nr.vid
WHERE n.type IN ('page', 'blog')
```

### Comments
```mysql
INSERT INTO [NEW_DB].comment
SELECT
  c.cid, c.pid, c.nid, c.uid, c.subject, c.hostname, c.timestamp, c.timestamp,
  CASE c.status WHEN 0 THEN 1 ELSE 0 END,
  c.thread, c.name, c.mail, c.homepage, 'und'
FROM [OLD_DB].comments c
LEFT JOIN [NEW_DB].comment c2 ON c2.cid = c.cid
INNER JOIN [OLD_DB].node n ON n.nid = c.nid
WHERE n.type IN ('page', 'blog') AND c2.cid IS NULL
```

```mysql
INSERT INTO [NEW_DB].field_data_comment_body
SELECT
  'comment', CONCAT('comment_node_', n.type), 0, c.cid, c.cid, 'und', 0, c.comment,
  CASE c.format
    WHEN 3 THEN 'full_html'
    ELSE 'filtered_html'
  END
FROM [OLD_DB].comments c
LEFT JOIN [NEW_DB].field_data_comment_body c2 ON c2.entity_type = 'comment' AND c2.entity_id = c.cid
INNER JOIN [OLD_DB].node n ON n.nid = c.nid
WHERE n.type IN ('page', 'blog') AND c2.entity_type IS NULL
```

```mysql
INSERT INTO [NEW_DB].field_revision_comment_body
SELECT
  'comment', CONCAT('comment_node_', n.type), 0, c.cid, c.cid, 'und', 0, c.comment,
  CASE c.format
    WHEN 3 THEN 'full_html'
    ELSE 'filtered_html'
  END
FROM [OLD_DB].comments c
LEFT JOIN [NEW_DB].field_revision_comment_body c2 ON c2.entity_type = 'comment' AND c2.entity_id = c.cid
INNER JOIN [OLD_DB].node n ON n.nid = c.nid
WHERE n.type IN ('page', 'blog') AND c2.entity_type IS NULL
```

### URL Aliases
```mysql
INSERT INTO [NEW_DB].url_alias
SELECT u.pid, u.src, u.dst, 'und'
FROM [OLD_DB].url_alias u
LEFT JOIN [OLD_DB].node n ON u.src = CONCAT('node/', CAST(n.nid AS CHAR))
WHERE (u.src LIKE 'node/%' OR u.src LIKE 'taxonomy/%') AND (n.type IS NULL OR n.type IN ('page', 'blog'))
```

### Taxonomy
```mysql
INSERT INTO [NEW_DB].taxonomy_term_data
SELECT t.tid, t.vid, t.name, t.description, 'full_html', 0
FROM [OLD_DB].term_data t
```

```mysql
INSERT INTO [NEW_DB].taxonomy_term_hierarchy
SELECT t.tid, 0
FROM [OLD_DB].term_hierarchy t
```

```mysql
INSERT INTO [NEW_DB].taxonomy_index
SELECT n.nid, t.tid, n.sticky, n.created
FROM [OLD_DB].node n
INNER JOIN [OLD_DB].term_node t ON t.nid = n.nid
WHERE n.type IN ('blog', 'page')
```

### Node taxonomy
```mysql
INSERT INTO [NEW_DB].field_data_field_tags
SELECT
  'node', i.type, 0 AS deleted, i.nid, i.vid, 'und' AS LANGUAGE,
  @delta := CASE WHEN @prevnid = i.nid THEN @delta:=@delta+1 ELSE CASE WHEN @prevnid := i.nid THEN @delta := 0 ELSE @delta := 0 END END AS delta,
  i.tid
FROM (
  SELECT n.nid, n.vid, n.type, t.tid
  FROM [OLD_DB].node n
  INNER JOIN [OLD_DB].term_node t ON t.nid = n.nid
  WHERE n.type IN ('blog', 'page')
  ORDER BY n.nid ASC
) AS i
```

```mysql
INSERT INTO [NEW_DB].field_revision_field_tags
SELECT
  'node', i.type, 0 AS deleted, i.nid, i.vid, 'und' AS LANGUAGE,
  @delta := CASE WHEN @prevnid = i.nid THEN @delta:=@delta+1 ELSE CASE WHEN @prevnid := i.nid THEN @delta := 0 ELSE @delta := 0 END END AS delta,
  i.tid
FROM (
  SELECT n.nid, n.vid, n.type, t.tid
  FROM [OLD_DB].node n
  INNER JOIN [OLD_DB].term_node t ON t.nid = n.nid
  WHERE n.type IN ('blog', 'page')
  ORDER BY n.nid ASC
) AS i
```

### Files
```mysql
INSERT INTO [NEW_DB].file_managed
SELECT
  f.fid, f.uid,
  SUBSTRING_INDEX(f.filepath, '/', -1) AS `filename`,
  REPLACE(f.filepath, 'sites/thingy-ma-jig.co.uk/files/', 'public://') AS `uri`,
  f.filemime, f.filesize, f.status, f.timestamp
FROM [OLD_DB].files f
```

```mysql
INSERT INTO [NEW_DB].field_revision_field_image
SELECT
  'node', n.type, 0 AS `deleted`, n.nid, n.vid, 'und' AS `language`, 0 AS `delta`, ctb.field_image_fid AS `fid`,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(ctb.field_image_data, LOCATE('alt', ctb.field_image_data)), 8), '"', 2), '"', -1) AS `alt`,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(ctb.field_image_data, LOCATE('title', ctb.field_image_data)), 8), '"', 2), '"', -1) AS `title`
FROM [OLD_DB].node n
INNER JOIN [OLD_DB].content_type_blog ctb ON ctb.vid = n.vid
WHERE n.type IN ('blog') AND ctb.field_image_fid IS NOT NULL
```

### Page Title
```mysql
INSERT INTO [NEW_DB].page_title
SELECT p.*
FROM [OLD_DB].page_title p
LEFT JOIN [NEW_DB].page_title p2 ON p.type = p2.type AND p.id = p2.id
WHERE p2.id IS NULL;
```

### Meta Tags

Unfortunately, at the time of writing, the Metatags module is not available and Nodewords has not been updated. The current "hack" solution is to have two fields (field_meta_description and field_meta_keywords), add then to the node and term 'bundles' and just use SQL to get the content into them. Then, using a custom module, embed them into the header manually (using hook_html_head_alter).

#### Nodes
```mysql
INSERT INTO [NEW_DB].field_data_field_meta_description
SELECT
  'node', n.type, 0, n.nid, n.vid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].node n
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 5 AND nw.id = n.nid AND nw.name = 'description'
WHERE n.type IN ('blog', 'page');
```

```mysql
INSERT INTO [NEW_DB].field_revision_field_meta_description
SELECT
  'node', n.type, 0, n.nid, n.vid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].node n
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 5 AND nw.id = n.nid AND nw.name = 'description'
WHERE n.type IN ('blog', 'page');
```

```mysql
INSERT INTO [NEW_DB].field_data_field_meta_keywords
SELECT
  'node', n.TYPE, 0, n.nid, n.vid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].node n
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 5 AND nw.id = n.nid AND nw.name = 'keywords'
WHERE n.type IN ('blog', 'page');
```

```mysql
INSERT INTO [NEW_DB].field_revision_field_meta_keywords
SELECT
  'node', n.type, 0, n.nid, n.vid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].node n
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 5 AND nw.id = n.nid AND nw.name = 'keywords'
WHERE n.type IN ('blog', 'page');
```

#### Terms
```mysql
INSERT INTO [NEW_DB].field_data_field_meta_description
SELECT
  'taxonomy_term', 'tags', 0, t.tid, t.tid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].term_data t
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 6 AND nw.id = t.tid AND nw.NAME = 'description';
```

```mysql
INSERT INTO [NEW_DB].field_revision_field_meta_description
SELECT
  'taxonomy_term', 'tags', 0, t.tid, t.tid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].term_data t
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 6 AND nw.id = t.tid AND nw.NAME = 'description';
```

```mysql
INSERT INTO [NEW_DB].field_data_field_meta_keywords
SELECT
  'taxonomy_term', 'tags', 0, t.tid, t.tid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].term_data t
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 6 AND nw.id = t.tid AND nw.NAME = 'keywords';
```

```mysql
INSERT INTO [NEW_DB].field_revision_field_meta_keywords
SELECT
  'taxonomy_term', 'tags', 0, t.tid, t.tid, 'und', 0,
  SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTR(SUBSTR(nw.content, LOCATE('value', nw.content)), 8), '"', 2), '"', -1),
  'plain_text'
FROM [OLD_DB].term_data t
INNER JOIN [OLD_DB].nodewords nw ON nw.type = 6 AND nw.id = t.tid AND nw.NAME = 'keywords';
```

## Modules:

I also stripped back some functionality to make the site easier to maintain, but pretty much all of what I needed worked directly from checkout. I'm still using Gravatar, Flickr, Views and Panels (I still need to configure the panels).

### Issues?

I found an odd issue with Drupal core. I didn't want my comments to "permalink" to comment URL's - I wanted them to anchor to their point on the page. So I just thought I'd alter the entity info and switch the callback used for the URI. This caused an error where the Comment module had not completely been updated to the new Drupal 7 API. <a href="http://drupal.org/node/1027936">See Issue 1027936</a>.

Also, as mentioned above, Nodewords/Metatags are currently unavailable so I had to "hack" together my own module using hidden fields. Here is the code that enables me to get Meta description and keywords on nodes and terms + frontpage:

```php
function MODULE_html_head_alter(&amp;$head) {
  if (($obj = menu_get_object('node', 1)) || ($obj = menu_get_object('taxonomy_term', 2))) {
    $description = isset($obj->field_meta_description['und'][0]['safe_value']) ? $obj->field_meta_description['und'][0]['safe_value'] : '';
    $keywords    = isset($obj->field_meta_keywords['und'][0]['safe_value']) ? $obj->field_meta_keywords['und'][0]['safe_value'] : '';
  }
  elseif (drupal_is_front_page()) {
    $description = 'FRONTPAGE DESCRIPTION';
    $keywords = 'FRONTPAGE KEYWORDS';
  }

  if (!empty($description)) {
    $head['tmj_tweaks_description'] = array(
      '#type' => 'html_tag',
      '#tag' => 'meta',
      '#attributes' => array('name' => 'description', 'content' => $description),
    );
  }
  if (!empty($keywords)) {
    $head['tmj_tweaks_keywords'] = array(
      '#type' => 'html_tag',
      '#tag' => 'meta',
      '#attributes' => array('name' => 'keywords', 'content' => $keywords),
    );
  }
}
```

This just pulls the node or term object from the Menu API, grabs the values from the field (or the hardcoded frontpage values) and pushes them into the head as html tag elements.

During the upgrade I also submitted some patches to the <a href="http://drupal.org/project/geshifilter">GeSHi module</a> (which powers the code highlighting on this site) and the <a href="http://drupal.org/project/gravatar">Gravatar module</a> (which powers the user profile icons on comments).

So far, I'm really liking Drupal 7 - it's shaping up to be a very nice release!
