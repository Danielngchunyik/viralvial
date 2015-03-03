var setShareBoxHeight = function() {

  var heights = [];
  var shareboxes = document.querySelectorAll('.sharebox .context');

  for (var x = 0; x < shareboxes.length; x ++) {
    heights.push($(shareboxes[x]).height())
  }

  var newShareBoxHeight = Math.max.apply( Math, heights );
  console.log(newShareBoxHeight);
  $('.sharebox .context').css("min-height", newShareBoxHeight);
}

$(document).ready(function() {
  setShareBoxHeight();
});

$(window).resize(function() {
  setShareBoxHeight();
});