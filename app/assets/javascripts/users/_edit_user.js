var initBIP = function() {
  
  // Successful update
  $(".best_in_place").best_in_place().bind('ajax:success', function() {
    runAnimations(this, '', 'pulse');
    $('#profile_user_name_display').html($('#profile_user_name').html());
    $('#header-user-name').html($('#profile_user_name').html());
  });

  // Failed update
  $(".best_in_place").best_in_place().bind('ajax:error', function() {
    runAnimations(this, '', 'shake');
  })
}

$(document).ready(initBIP);
$(document).ajaxComplete(initBIP);
