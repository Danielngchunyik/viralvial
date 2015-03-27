// Check if DOM has scrolled into view
var isScrolledIntoView = function(elem) {
  var w = $(window);
  var e = $(elem);

  var inView = w.scrollTop() + w.height();
  var elemTop = e.offset().top;
  
  return (inView > elemTop);
}