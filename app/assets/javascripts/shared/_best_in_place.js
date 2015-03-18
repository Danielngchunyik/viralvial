$(document).ready(function() {

  var months = [ undefined, "January", "February", "March",
                 "April", "May", "June", "July", "August",
                 "September", "October", "November", "December"]

  
  // Successful update
  $(".best_in_place").best_in_place().bind('ajax:success', function() {
    $(this).transition('pulse')
    $('#profile_user_name_display').html($('#profile_user_name').html())
    if (months[$('#profile_user_birthday_month').html()] !== undefined) {
      $('#profile_user_birthday_month').html(months[$('#profile_user_birthday_month').html()]);
    }
  });

  // Failed update
  $(".best_in_place").best_in_place().bind('ajax:error', function() {
    $(this).transition({ animation: 'shake', duration: '0.5s' })
  })
});