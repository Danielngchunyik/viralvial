$(document).ready( function() {

  // Trigger header animations
  setTimeout( function() {
      $('#navbar-left').removeClass("hide").addClass("animated fadeInDown")
      $('#navbar-right').removeClass("hide").addClass("animated fadeInDown");
  }, 800);

  // Remove animation classes
  setTimeout( function() {
      $('#navbar-left').removeClass("animated fadeInDown");
      $('#navbar-right').removeClass("animated fadeInDown");
  }, 1800);

  // Trigger about us view
  $('.about-us').on ('click', function() {
    $('#campaigns-list').addClass('none');
    $('#about-us').removeClass('none');
  });
});