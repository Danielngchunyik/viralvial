$(document).ready(function() {
  jQuery(".best_in_place").best_in_place().bind('ajax:success', function() {
    debugger
    $(this).effect('highlight', { color: "#B9F6CA" });
  });
});