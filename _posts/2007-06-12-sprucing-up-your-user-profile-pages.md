---
excerpt: "<p>I recently launched <a title=\"DBP Codebase\" href=\"http://codebase.dbp-site.com/\">a
  Drupal Codebase site for a programming community</a> and wanted to have the user
  profiles to be more than just a &quot;<em>signed up on</em>...&quot; and a <em>Tracker
  Tab</em>. I wanted them to have <strong>structured</strong> and <strong>customisable
  blocks</strong>, <strong>dynamic content</strong>, a <strong>Peer to Peer Message
  Board</strong> (almost finished)... I can have my dreams cant I?!</p>\r\n<p>I recently
  wrote a book page on <a title=\"Creating views programmatically\" href=\"http://drupal.org/node/138828\">how
  to programmatically create a view</a>. I wanted to do this as it would allow to
  me control almost an entire website with <strong>multiple content types</strong>,
  <strong>terms</strong> and <strong>users</strong> (as well as combinations of the
  three) along with RSS feeds - all powered by the <strong>Views Module</strong> +
  a bolt on module consisting mostly of a <em>menu callback</em> and a function to
  make and configure a view. This worked pretty well for a first try and principle
  test!</p>\r\n<p>I then realised - <em>hey, if you can do this with Views - why cant
  you do it with Panels too?</em> Panels are fantastically useful for structuring
  multiple blocks, views and nodes onto a page. So I tried&hellip; And you can!</p>\r\n"
categories:
- programming
- drupal
- design
- cool
layout: post
title: Sprucing up your User Profile Pages
created: 1181662652
permalink: blog/12-06-2007/sprucing-up-your-user-profile-pages
---
<p>I recently launched <a title="DBP Codebase" href="http://codebase.dbp-site.com/">a Drupal Codebase site for a programming community</a> and wanted to have the user profiles to be more than just a &quot;<em>signed up on</em>...&quot; and a <em>Tracker Tab</em>. I wanted them to have <strong>structured</strong> and <strong>customisable blocks</strong>, <strong>dynamic content</strong>, a <strong>Peer to Peer Message Board</strong> (almost finished)... I can have my dreams cant I?!</p>
<p>I recently wrote a book page on <a title="Creating views programmatically" href="http://drupal.org/node/138828">how to programmatically create a view</a>. I wanted to do this as it would allow to me control almost an entire website with <strong>multiple content types</strong>, <strong>terms</strong> and <strong>users</strong> (as well as combinations of the three) along with RSS feeds - all powered by the <strong>Views Module</strong> + a bolt on module consisting mostly of a <em>menu callback</em> and a function to make and configure a view. This worked pretty well for a first try and principle test!</p>
<p>I then realised - <em>hey, if you can do this with Views - why cant you do it with Panels too?</em> Panels are fantastically useful for structuring multiple blocks, views and nodes onto a page. So I tried&hellip; And you can!</p>
<!--break-->
<p>I'm not going to bother doing it to THIS site as I'm the only user - pretty pointless. However it will be useful for those of you who have a user-driven website and want to have <strong>user profiles</strong> be a little more interesting.</p>
<p>Firstly, you want to define a few views. Currently (at time of writing), I have 2 - <em><strong>Most Recent Snippet</strong></em> and <em><strong>Nodes Comments On</strong></em> (I wanted Most Recent Comments, but Views wont do that for me AFAIK). Next, you need to override the <a href="http://api.drupal.org/api/5/function/theme_user_profile" title="User Profile Theme function in Drupal 5 API Docs"><strong><em>theme_user_profile</em></strong></a> function in your <em><strong>template.php</strong></em>. This is the code I used:</p>
<code lang="php">
//Initial Load
$panels->content = array();
$panels->access = array();
$panels->title = $account->name;
$panels->css_id = "css_id";
$panels->layout = "twocol";


//Users Code
$temparea = new StdClass();
$temparea->area = 'left';
$temparea->type = 'views';
$temparea->configuration = array(
  'view' => 'code_by_user',
  'type' => 'block',
  'pager_id' => 0,
  'nodes_per_page' => 20,
  'args' => $account->name,
  'url' => '',
  'show_title' => 1,
  );
$temparea->position = 1;
$panels->content[$temparea->area][] = $temparea;


//Users Comments
$temparea = new StdClass();
$temparea->area = 'right';
$temparea->type = 'views';
$temparea->configuration = array(
  'view' => 'comment_by_user',
  'type' => 'block',
  'pager_id' => 0,
  'nodes_per_page' => 20,
  'args' => $account->name,
  'url' => '',
  'show_title' => 1,
  );
$temparea->position = 1;
$panels->content[$temparea->area][] = $temparea;




$layouts = panels_get_layouts();
$layout = $layouts[$panels->layout];
$layout['css_id'] = $panels->css_id;

panels_is_panels_page(TRUE);
$content_types = panels_get_content_types();

foreach ($panels->content as $location => $list) {
  foreach ($list as $area) {
    $function = $content_types[$area->type]['callback'];
    if (function_exists($function)) {
      $content[$area->area] .= $function($area->configuration);
    }
  }
}


$output = panels_get_layout($layout, $content);
drupal_set_title(filter_xss_admin($panels->title));
return $output;
</code>
<p>As you can see, first step is to initialise the panel settings - in this case I want to use the <em><strong>twocol</strong></em> panel layout along with the <em>username</em> as the panel title and the <em>CSS ID</em> of '<em>css_id</em>' (original, eh). This is easy.</p>
<p>The next two steps are slightly more complex as they involve creating associative arrays of the panel. I've not investigated ALL of these types, but I found the easiest way was to unserialize and &quot;print_r&quot; the contents of one of the <em><strong>configuration</strong></em> fields from the <em><strong>panels_area</strong></em> table in the database. This can give you and idea of what goes in where. To embed a View, you can follow my example above with the value for the <strong>view</strong> key being the view id, <strong>type</strong> being the <em>type</em> of view output (eg, <em>embed</em>, <em>block</em> or <em>page</em>), <strong>pager_id</strong> being a uniquely identifiable value fpr multiple pagers on a page and so on - most of this can be found in the Drupal Views documentation.</p>
<p>Nearly there; next we grab the panel layouts and select the entry from the layouts array determined by our panels selection earlier on. We also set the CSS ID.</p>
<p>Following this we grab all the content types compatible with panels. We need to do this so we can find which callback we need to execute to get the data out of a &quot;Views Panel&quot; or a &quot;Block Panel&quot;, etc. This will also check that the content type you've assigned to that panel actually HAS a valid and existing callback too. The results of the callback are appended into an array of strings where they key is the ID of the area you'd putting data into (eg 'left').</p>
<p>The final stage is to pass the layout and contents through the panels module, set the title of the page based on the panels configuration above (in this case, the user name) and then return the output.</p>
<p>If anyone has any suggestions for this - I'd happily take them on board. At some point over the next week or so, once I have all this ironed out 100% - I'll write it up as a book entry to go alongside my Creating a View Programmatically &quot;tutorial&quot;.</p>
