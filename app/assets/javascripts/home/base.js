// Remove or add absolute positioning from header
var editHeaderPositionValue = function () {
  if ($('#campaigns-show').size() > 0) {
    $('header.landing').css('position', 'static');
  }
  else if ($('#hero-banner').size() > 0) {
    $('header.landing').css('position', 'absolute');
  }
}

var runLandingPageScript = function() {

  if ($("body").hasClass("home index")) {

    // Check Animation Trigger
    var triggered = false;
    
    // Initiate Smoothscroll
    smoothScroll.init({
      speed: 1000,
      offset: 50
    });

    // Remove or add absolute positioning from header
    editHeaderPositionValue();

    // Run Landing Page Animations
    setTimeout( function() {
      runAnimations('.hero-content .banner-title', 'hide', 'fadeInDown');
    }, 1200);

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

    // Smoothen out parallax scrolling for Chrome Browsers
    if (window.addEventListener) {window.addEventListener('DOMMouseScroll', function(){});}
    window.onmousewheel = document.onmousewheel = function(){};


    // Initialize Parallax Values
    var parallax = document.querySelectorAll(".parallax"),
        speed = 0.65;

    window.onscroll = function() {

      // Run Parallax Scrolling
      [].slice.call(parallax).forEach(function(el,i){

        var windowYOffset = (window.pageYOffset - $(el).position().top)
        
        var elBackgrounPos = "50% " + (windowYOffset * speed) + "px";
          
        el.style.backgroundPosition = elBackgrounPos;
      });

      //Contact Form Animations when scrolled into view
      if (isScrolledIntoView('#contact-us') && triggered == false) {

        setTimeout( function() {
          runAnimations('#contact-us-title', 'hide', 'fadeInLeft');
        }, 600);

        setTimeout( function() {
          runAnimations('#contact-left', 'hide', 'fadeInLeft');
          runAnimations('#contact-right', 'hide', 'fadeInRight');
        }, 1000);

        triggered = true;
      }
    }
  }
}

$(document).ready(runLandingPageScript);
$(document).ajaxComplete(editHeaderPositionValue);