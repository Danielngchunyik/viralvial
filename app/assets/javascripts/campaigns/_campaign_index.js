$(document).ready(function() {
  
  $('.cookie.nag')
    .nag('show')
  ; 
  $('.cookie.nag')
    .nag('clear')
  ;
  $('.cookie.nag')
    .nag({
      key      : 'accepts-cookies',
      value    : true
    })
  ;
});
