var viralerTemplate = 
  '<div class="textbox">'
    +'<p> VIRALER </p>'
    +'<div class="top-padding"> You, are the heart of what ViralVial is all about. Without you, there is no one to create the</div>'  
    +'<div class="text"> most imaginative stories. Without you, there will be no trending topics. Without you, life</div>' 
    +'<div class="text"> would be too boring! So if you LOVE creating creative content, LOVE starting trends and LOVE</div>'  
    +'<div class="text"> bringing excitement to the world, we want YOU to be a Viraler! When you share our campaigns,</div>'
    +'<div class="text"> you not only inspire those around you to help themselves, you also get to work with your</div>' 
    +'<div class="text"> favorite brands, gain exposure to be a key opinion leader and be rewarded for it. Like what you</div>' 
    +'<div class="text"> just read? Join our growing community!</div>'
  +'</div>';

var vialsTemplate =
  '<div class="textbox">'
    +'<p> VIALS </p>'
    +'<div class="top-padding"> You, exciting brands, are like the fresh air injected into social media. Thanks to you, we get to</div>' 
    +'<div class="text"> run awesome campaigns for our Viralers to participate in, adding colours into our sometime</div>' 
    +'<div class="text"> mundane timelines. You give great reasons to spark the next most talked about thing in town</div>'  
    +'<div class="text"> with your unique products and useful services. Most importantly, you get to work with us to</div>'   
    +'<div class="text"> find your most influential and relevant fans for your brands, and keep them close to you!</div>'  
    +'<div class="text"> Sounds like a deal? Contact us now!'
  +'</div>';


var removeAnimation = function(animation) {
  $('#viralvial-description').removeClass('animated ' + animation);
};

var performAction = function(event, animation, clickName, element, removeElement, template) {
  event.preventDefault();
  if (!element.hasClass(clickName)) {
    element.html($(template));
    element.addClass('animated ' + animation + ' ' + clickName);
    element.removeClass(removeElement);
    setTimeout(function() { removeAnimation(animation) }, 1000);
  }
};

$(document).ready(function() {

  $(".viraler").click(function(event){
    performAction(event, 'fadeInLeft', 'viraler', $('#viralvial-description'), 'vials', viralerTemplate);
  });

  $(".vials").click(function(event) {
    performAction(event, 'fadeInRight', 'vials', $('#viralvial-description'), 'viraler', vialsTemplate);
  });
});
