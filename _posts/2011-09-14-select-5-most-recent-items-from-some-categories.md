---
categories:
- mysql
- tips
- drupal
layout: blog
title: Select 5 most recent items from some categories
created: 1316005652
permalink: blog/14-09-2011/select-5-most-recent-items-from-some-categories
---
<p>Ever needed to build a list which "sub-selects", say, 5 items from a given list of categories? This snippet should help.</p>
<!--break-->
<p>Assume the following schema&hellip;</p>
<pre language="mysql">
CREATE TABLE content (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL DEFAULT '',
  body LONGTEXT NOT NULL,
  status INT(11) NOT NULL DEFAULT '1',
  created INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  KEY content_created (created)
);

CREATE TABLE tags(
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
);

CREATE TABLE content_tags (
  tid INT(10) UNSIGNED NOT NULL,
  cid INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (tid, cid),
  KEY content_id (cid)
);
</pre>
<p>Now we can insert some dummy data&hellip;</p>
<pre language="mysql">
TRUNCATE content;
INSERT INTO content (title, STATUS, created) VALUES
  ('Ut Secundum Modo',             1, UNIX_TIMESTAMP('2011-09-12 12:00:00')),
  ('Quidem Accumsan Facilisis',    1, UNIX_TIMESTAMP('2011-09-14 17:00:00')),
  ('Vel Ut Oppeto Interdico ',     1, UNIX_TIMESTAMP('2011-09-10 09:00:00')),
  ('Iustum Nimis Venio',           1, UNIX_TIMESTAMP('2011-09-11 12:30:00')),
  ('Consequat Defui Verto Macto',  1, UNIX_TIMESTAMP('2011-09-13 19:00:00')),
  ('Quae Natu Facilisis Ille Jus', 1, UNIX_TIMESTAMP('2011-09-09 21:15:00')),
  ('Abico Meus Ullamcorper',       0, UNIX_TIMESTAMP('2011-09-01 00:00:00')),
  ('Ulciscor Antehabeo Gravis',    1, UNIX_TIMESTAMP('2011-09-05 11:00:00'));

TRUNCATE tags;
INSERT INTO tags (title) VALUES ('alpha'), ('beta'), ('gamma'), ('delta');

TRUNCATE content_tags;
INSERT INTO  content_tags(tid, cid) VALUES
  (1,1), (4,1),
  (2,2), (3,2), (4,2),
  (1,3), (3,3), (4,3),
  (3,4), (4,4),
  (2,5),
  (3,6), (4,6),
  (1,7), (4,7),
  (1,8);
</pre>
<p>The <code>TRUNCATE</code>'s are only there to ensure these test tables are empty and that the auto incrementing ID's starts from 1.</p>
<p>Now if you run the following query, you will get a list of up to 3 of the most recent posts from each category.</p>
<pre language="mysql">
SELECT tag_id, tag_name, content_id, content_title FROM (
  SELECT
    CASE
      WHEN @id != t.id THEN @row_num := 1
      ELSE @row_num := @row_num + 1
    END AS rownum,
    t.id tag_id,
    t.title tag_name,
    c.id content_id,
    c.title content_title,
    @id := t.id
  FROM tags t
  INNER JOIN content_tags ct ON ct.tid = t.id
  INNER JOIN content c ON c.id = ct.cid
  JOIN (SELECT @id := NULL, @row_num := 0) a
  WHERE c.status = 1
  ORDER BY t.id ASC, c.created DESC
) r
WHERE rownum < 4
</pre>
<p>This produces&hellip;</p>
<table style="width:100%">
  <caption><em>Note how the <strong>beta</strong> tag only has 2 items; this is due to the INSERT's above.</em></caption>
  <thead>
    <tr><th>tag_id</th><th>tag_name</th><th>content_id</th><th>content_title</th></tr>
  </thead>
  <tbody>
    <tr> <td>1</td> <td>alpha</td> <td>1</td> <td>Ut Secundum Modo</td> </tr>
    <tr> <td>1</td> <td>alpha</td> <td>3</td> <td>Vel Ut Oppeto Interdico</td> </tr>
    <tr> <td>1</td> <td>alpha</td> <td>8</td> <td>Ulciscor Antehabeo Gravis</td> </tr>
    <tr> <td>2</td> <td>beta</td>  <td>2</td> <td>Quidem Accumsan Facilisis</td> </tr>
    <tr> <td>2</td> <td>beta</td>  <td>5</td> <td>Consequat Defui Verto Macto</td> </tr>
    <tr> <td>3</td> <td>gamma</td> <td>2</td> <td>Quidem Accumsan Facilisis</td> </tr>
    <tr> <td>3</td> <td>gamma</td> <td>4</td> <td>Iustum Nimis Venio</td> </tr>
    <tr> <td>3</td> <td>gamma</td> <td>3</td> <td>Vel Ut Oppeto Interdico</td> </tr>
    <tr> <td>4</td> <td>delta</td> <td>2</td> <td>Quidem Accumsan Facilisis</td> </tr>
    <tr> <td>4</td> <td>delta</td> <td>1</td> <td>Ut Secundum Modo</td> </tr>
    <tr> <td>4</td> <td>delta</td> <td>3</td> <td>Vel Ut Oppeto Interdico</td> </tr>
  </tbody>
</table>
<br />
<h3>How to use in Drupal</h3>
<p>The above example could easily be adapted for a Drupal site; to list the 4 most recent items in all terms in a given vocabulary&hellip;</p>
<pre language="mysql">
SELECT term_id, term_name, node_id, node_title FROM (
  SELECT
    CASE
      WHEN @id != td.tid THEN @row_num := 1
      ELSE @row_num := @row_num + 1
    END AS rownum,
    td.tid term_id,
    td.name term_name,
    n.nid node_id,
    n.title node_title,
    @id := td.tid
  FROM term_data td
  INNER JOIN term_node tn ON tn.tid = td.tid
  INNER JOIN node n ON n.vid = tn.vid
  JOIN (SELECT @id := NULL, @row_num := 0) a
  WHERE n.status = 1 AND td.vid = 1
  ORDER BY td.tid ASC, n.created DESC
) r
WHERE rownum < 5
</pre>
