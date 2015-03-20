var runHoverTriggers = function(el, message) {
  $(el).html(message)
}

$(document).ready(function() {
  if ($("body").hasClass("user_dashboard index")) {

    // Trigger Interest Form Modal
    $('#interest-form-modal').modal('setting', 'closable', false).modal('show');

    // End
  
    //Social Media Connect Hover Button Functions

    $('#facebook-disconnect').mouseenter(function() {
      runHoverTriggers('#facebook-disconnect', 'disconnect from facebook');
    })

    $('#facebook-disconnect').mouseleave(function() {
      runHoverTriggers('#facebook-disconnect', 'facebook');
    });

    $('#twitter-disconnect').mouseenter(function() {
      runHoverTriggers('#twitter-disconnect', 'disconnect from twitter');
    });

    $('#twitter-disconnect').mouseleave(function() {
      runHoverTriggers('#twitter-disconnect', 'twitter');
    })

    // End

    // Trigger Profile Image Modal Form

    $('.trigger-profile-image-change').on('click', function(e) {
      e.preventDefault();
    });

    $('#profile-image-modal').modal('attach events', '.trigger-profile-image-change', 'show');

    // End
  }
});