$(document).ready(function() {
  
  $('#campaign_invite_list').hide();

  $("input:radio[name='campaign_privacy']").change(function() {

    if(this.value == 'true' && this.checked) 
    {
      $('#campaign_invite_list').toggle();
    }
    else
    {
      $('#campaign_invite_list').hide()
      $('#campaign_invitation_list').val('');
    }
  });
});
