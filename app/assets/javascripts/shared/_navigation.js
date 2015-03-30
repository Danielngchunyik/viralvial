// Add PJAX attribute on pagination links
var ajaxPaginationLinks = function() {
  [].slice.call($('.pagination a')).forEach(function(el) {
    $(el).attr('data-run-pjax', true);
  });
}

$(function() {
  $(document).pjax('a[data-run-pjax]', '[data-pjax-container]');
});

$(document).ready(ajaxPaginationLinks);
$(document).ajaxComplete(ajaxPaginationLinks);
