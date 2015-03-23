var initAdminCampaignForm = function() {
  $('form').on('click', '.remove_fields', function(event) {
    $(this).prev('input:hidden').val('true');
    $(this).closest('.nested_form_field').hide();
    event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });
}

$(document).ready(initAdminCampaignForm);
$(document).ajaxComplete(initAdminCampaignForm);
