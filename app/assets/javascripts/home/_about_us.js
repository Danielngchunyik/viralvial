var removeAnimation = function(animation) {
  $('#viralvial-description').removeClass('animated ' + animation);
};

var performAction = function(event, animation, element, hideElement) {
  container = $('#viralvial-description')
  event.preventDefault();
  if (!element.hasClass('selected')) {
    element.css("display", "block").addClass('selected');
    container.addClass('animated ' + animation);
    hideElement.css("display", "none").removeClass('selected');
    setTimeout(function() { removeAnimation(animation) }, 1000);
  }
};

$(document).ready(function() {

  $(".viralers").click(function(event){
    performAction(event, 'fadeInLeft', $('#viralers-box'), $('#vials-box'));
  });

  $(".vials").click(function(event) {
    performAction(event, 'fadeInRight', $('#vials-box'), $('#viralers-box'));
  });
});
