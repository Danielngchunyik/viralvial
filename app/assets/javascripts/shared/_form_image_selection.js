var initImageSelection = function() {
  // Form Image Selection
  $('.selectable-image').click(function (e) {
    e.preventDefault();
    var image = $(this);
    var radioId = image.attr('id') + '-radio';
    var radio = $('#' + radioId);

    $('.selectable-image').css('border', 'none');
    image.css('border', '3px solid blue');

    $('.default-image-radio').prop('checked', false);
    radio.prop('checked', true);
  }); 
}