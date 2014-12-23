$(document).ready(function() {
  
  $('#campaign_invite_list').hide();

  $("input:radio[name='campaign_privacy']").change(function() {

    if(this.value == 'true' && this.checked) 
    {
      $('#campaign_invite_list').show();
    }
    else
    {
      $('#campaign_invite_list').hide();
    }
  });
});
