jQuery(function() {

  var array = ["#facebook"]

  $('form').on('click', '.remove_fields', function(event) {
    for (var y = 0; y < array.length; y++) {
      if (($(array[y]).is(":hidden")) && ($(this).attr("id") == array[y])) {
        $('form').find(array[y]).show();
      }
    }

    $('form').prev('input[type=hidden]').val('1');
    $(this).closest('.nested_form_field').hide();
    return event.preventDefault();
  });

  $('.add_fields').click(function(event) {
    
    for (var x = 0; x < array.length; x++) {
      if ($(this)[0] == $(array[x])[0]) {
        $('form').find(array[x]).hide();
      }
    }
    
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
});
