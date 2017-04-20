requirejs(['jquery'], function ($) {
  'use strict';
  $('#sidebar-toggle').on('click', function() {
    $('body').toggleClass('open');
  });
});