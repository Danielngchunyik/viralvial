var addClassToDateSelect = function() {
  $('.day').addClass('field');
  $('.month').addClass('field');
  $('.year').addClass('field');
}

$(document).ready(function() {
  if ($('#admin-campaign-form').size() > 0) {
    addClassToDateSelect()
  }
});