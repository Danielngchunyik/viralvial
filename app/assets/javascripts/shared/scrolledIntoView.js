// Check if DOM has scrolled into view
var isScrolledIntoView = function(elem) {
  var e = $(elem);
  
  if (e.size() > 0) {
    var w = $(window);

    var inView = w.scrollTop() + w.height();
    var elemTop = e.offset().top;

    return (inView > elemTop);
  }
}