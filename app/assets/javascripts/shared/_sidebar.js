$(document).ready(function() {
  $('#dashboard-sidebar').sidebar('setting', 'transition', 'overlay');
  $('#dashboard-sidebar').sidebar('attach events', '#menu-button');
  
  $('#menu-button').removeClass('disabled');
});
