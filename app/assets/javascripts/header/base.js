$(document).ready( function() {

  // Trigger header animations
  setTimeout( function() {
      runAnimations('#navbar-left', 'hide', 'fadeInDown');
      runAnimations('#navbar-right', 'hide', 'fadeInDown');
  }, 800);

  // Trigger about us view
  $('.about-us').on ('click', function() {
    $('#campaigns-list').addClass('none');
    $('#about-us').removeClass('none');
  });
});