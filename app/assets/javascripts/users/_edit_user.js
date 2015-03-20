var initBIP = function() {
  
  // Successful update
  $(".best_in_place").best_in_place().bind('ajax:success', function() {
    $(this).transition('pulse')
    $('#profile_user_name_display').html($('#profile_user_name').html())
  });

  // Failed update
  $(".best_in_place").best_in_place().bind('ajax:error', function() {
    $(this).transition({ animation: 'shake', duration: '0.5s' })
  })
}

$(document).ready(initBIP);