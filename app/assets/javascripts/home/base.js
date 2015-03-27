$(document).ready(function() {

  if ($("body").hasClass("home index")) {

    // Check Animation Trigger
    var triggered = false;
    
    // Initiate Smoothscroll
    smoothScroll.init({
      speed: 1000,
      offset: 50
    });

    // Run Landing Page Animations  
    setTimeout( function() {
      $('.hero-content .banner-title').removeClass("hide").addClass("animated fadeInDown");
    }, 1200);

    // Remove Animations Upon Conclusion
    setTimeout( function() {
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
    $('.about-browser').on('click', function() {
      $('#about-us').addClass('none');
      $('#campaigns-list').removeClass('none').addClass('animated fadeInDown');
    });

    // Smoothen out scrolling for Chrome Browsers
    if (window.addEventListener) {window.addEventListener('DOMMouseScroll', function(){});}
    window.onmousewheel = document.onmousewheel = function(){};

    // Initialize Parallax
    var parallax = document.querySelectorAll(".parallax"),
        speed = 0.65;

    window.onscroll = function() {

      // Run Parallax
      [].slice.call(parallax).forEach(function(el,i){

        var windowYOffset = (window.pageYOffset - $(el).position().top),
            elBackgrounPos = "50% " + (windowYOffset * speed) + "px";
          
        el.style.backgroundPosition = elBackgrounPos;
      });

      //Contact Form Animations when scrolled into view
      if (isScrolledIntoView('#contact-us') && triggered == false) {

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
  }
});