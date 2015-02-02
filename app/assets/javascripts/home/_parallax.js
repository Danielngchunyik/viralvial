$(document).ready(function() {
  var parallax = document.querySelectorAll(".parallax"),
      speed = 0.65;

  window.onscroll = function(){
    [].slice.call(parallax).forEach(function(el,i){

      var windowYOffset = (window.pageYOffset - $(el).position().top),
          elBackgrounPos = "50%" + (windowYOffset * speed) + "px";
      
      el.style.backgroundPosition = elBackgrounPos;
    });
  };
});