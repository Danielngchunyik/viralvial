var setViralBoxHeight = function() {
  var newViraBoxHeight = $('#viralers-box').height();
  $('#viralvial-description').css("min-height", newViraBoxHeight);
}

$(document).ready(function() {
  setViralBoxHeight();
  smoothScroll.init({
    offset: 100
  });
});

$(window).resize(function() {
  setViralBoxHeight();
});