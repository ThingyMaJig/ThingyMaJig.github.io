---
categories:
- drupal
- howto
layout: post
title: Re-ordering the elements of a Drupal Webform Datepicker
created: 1370339182
permalink: blog/04-06-2013/re-ordering-the-elements-of-a-drupal-webform-datepicker
---
<p>The Date Picker widget, when using webforms, defaultly appears in American form (Month, Day, Year). For UK sites this isn't often desirable. Doing a quick google and I stumbled upon <a href="https://twitter.com/davidsonj" rel="author">James Davidson</a>'s <a href="http://davidsonj.com/blog/how-reorder-date-format-webform-date-picker">blog post on how to re-theme the element</a> from earlier this year. I thought it was certainly one approach, but felt there must have been a neater alternative. So here is my approach:</p>
<!--break-->
<pre language="php">
/**
 * Implements hook_webform_component_render_alter().
 */
function THEMENAME_webform_component_render_alter(&$element, &$component) {
  if ($element['#type'] == 'date') {
    $element['#process'][] = 'THEMENAME_webform_expand_date';
  }
}

/**
 * Process function to re-order the elements in the date widget.
 */
function THEMENAME_webform_expand_date($element) {
  $element['day']['#weight'] = 0;
  $element['month']['#weight'] = 1;
  $element['year']['#weight'] = 2;
  return $element;
}
</pre>
<p>Obviously you can replace <code>THEMENAME</code> with what ever theme or module name you like; in my case I put this in the <code>template.php</code> file.</p>
