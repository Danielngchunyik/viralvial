// Render CSS Animations
var runAnimations = function(e, remove, animation) {
  $(e).removeClass(remove).addClass('animated ' + animation);

  setTimeout( function() {
    $(e).removeClass('animated ' + animation);
  }, 1000);
}
