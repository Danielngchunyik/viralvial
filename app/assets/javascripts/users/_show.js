var runHoverTriggers = function(el, message) {
  $(el).html(message)
}

var initInterestModal = function() { 

  // Trigger Interest Form Modal
  $('#interest-form-modal').modal('setting', 'closable', false).modal('show');
}

var initProfile = function() {

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

  // Trigger Profile Image Modal Form

  $('.trigger-profile-image-change').on('click', function(e) {
    e.preventDefault();
  });

  $('#profile-image-modal').modal('attach events', '.trigger-profile-image-change', 'show');
}

$(document).ready(function() {
  initProfile();
  initInterestModal();
});

$(document).ajaxComplete(initProfile);