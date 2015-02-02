var setHeight = function() {
  newHeight = $('#viralers-box').height();
  $('#viralvial-description').css("min-height", newHeight);
}

$(document).ready(function() {
  setHeight();
  smoothScroll.init({
    offset: 100
  });
});

$(window).resize(function() {
  setHeight();
})