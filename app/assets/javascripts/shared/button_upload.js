var runLoaderAnimation = function(button, context) {
  $(button).on('click', function(context) {
    $(context).addClass('ui text loader');
  });
};

$(document).ready(function(){
  runLoaderAnimation('#image-loader', '.modal-styling');
});

$(document).ajaxComplete(function(){
  runLoaderAnimation('#image-loader', '.modal-styling');
});

