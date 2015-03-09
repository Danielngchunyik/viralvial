$(document).ready(function() {

  // Check Animation Trigger
  var triggered = false;
  
  // Initiate Smoothscroll
  smoothScroll.init({
    speed: 1000,
    offset: 50
  });

  // Run Landing Page Animations  
  setTimeout( function() {
    $('#navbar-left').removeClass("hide").addClass("animated fadeInDown")
    $('#navbar-right').removeClass("hide").addClass("animated fadeInDown");
  }, 800);

  setTimeout( function() {
    $('.hero-content .banner-title').removeClass("hide").addClass("animated fadeInDown");
  }, 1200);

  // Remove Animations Upon Conclusion
  setTimeout( function() {
    $('#navbar-left').removeClass("animated fadeInDown")
    $('#navbar-right').removeClass("animated fadeInDown");
    $('.hero-content .banner-title').removeClass("animated fadeInDown");
  }, 2200);

  // Set Typer Timeout
  setTimeout( function() {
    $('[data-typer-targets]').typer();
  }, 6400);

  // Trigger connect Modal
  $('.trigger-connect').on('click', function(e) {
    e.preventDefault();
  });

  $('#connect-modal').modal('attach events', '.trigger-connect', 'show');

  // User clicks browse on about-us
  $('#about-browser').on('click', function() {
    $('#about-us').addClass('none');
    $('#campaigns-list').removeClass('none').addClass('animated fadeInDown');
  })

  window.onscroll = function() {
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