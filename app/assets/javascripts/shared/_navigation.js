// var runPageTransition = function(elem) {

//   var active_page = document.getElementsByClassName('active-page');
//   $(active_page).removeClass('active-page').addClass('hide');
//   $(elem).addClass('active-page animated fadeIn').removeClass('hide');

//   setTimeout(function() {
//     $(elem).removeClass('animated fadeIn');
//   }, 1000);

// };

// $(document).ready(function() {

//   // User Show Navigation Page Transition

//   $('.overview-link').on('click', function(e) {
//     e.preventDefault();
//     runPageTransition('#overview-dashboard');
//   });

//   $('.profile-link').on('click', function(e) {
//     e.preventDefault();
//     runPageTransition('#user-dashboard');
//   });

//   // End
// });