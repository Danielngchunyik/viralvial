$(document).ready(function() {

  // Check Animation Trigger
  var triggered = false;
  
  // Get Parallax Elements
  var parallax = document.querySelectorAll(".parallax"), speed = 0.65;

  // Initiate Smoothscroll
  smoothScroll.init({
    offset: 100
  });

  // Run Landing Page Animations
  $('#hero-banner').addClass("animated fadeInDown");
  
  setTimeout( function() {
    $('.hero-context .right').removeClass("hide").addClass("animated fadeInDown");
  }, 1200);

  setTimeout( function() {
    $('.hero-context .banner-title').removeClass("hide").addClass("animated fadeInDown");
  }, 1400);

  // Remove Animations Upon Conclusion
  setTimeout( function() {
    $('#hero-banner').removeClass("animated fadeInDown");
    $('.hero-context .right').removeClass("animated fadeInDown");
    $('.hero-context .banner-title').removeClass("animated fadeInDown");
  }, 2400);

  // Set Typer Timeout
  setTimeout( function() {
    $('[data-typer-targets]').typer();
  }, 6400);


  window.onscroll = function() {

    // Trigger Parallax
    [].slice.call(parallax).forEach(function(el,i){

      var windowYOffset = (window.pageYOffset - $(el).position().top);
   
      if (el.id == 'contact-us') {
        windowYOffset += 380;
      }

      var elBackgrounPos = "50%" + (windowYOffset * speed) + "px";
    
      el.style.backgroundPosition = elBackgrounPos;
    });

    if (isScrolledIntoView('#contact-us') && triggered == false) {

      // Animate Contact Us Form    
      setTimeout( function() {
        $('#contact-us-title').removeClass("hide").addClass("animated fadeInLeft");
      }, 600);

      setTimeout( function() {
        $('#contact-left').removeClass("hide").addClass("animated fadeInLeft");
        $('#contact-right').removeClass("hide").addClass("animated fadeInRight");
      }, 1000);

      // Remove Animations
      setTimeout( function() {
        $('#contact-us-title').removeClass("animated fadeInLeft");
        $('#contact-left').removeClass("animated fadeInLeft");
        $('#contact-right').removeClass("animated fadeInRight");
      }, 2500);

      triggered = true;
    }
  }
});
