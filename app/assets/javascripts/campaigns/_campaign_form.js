$(document).ready(function() {
  
  $('#campaign_invite_list').hide();

  $("input:radio[name='campaign[private]']").change(function() {

    if(this.value == 'true' && this.checked) 
    {
      $('#campaign_invite_list').toggle();
    }
    else
    {
      $('#campaign_invite_list').hide();
      $('#campaign_invitation_text_field').val('');
    }
  });
});
