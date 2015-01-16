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

  var countdown = $('span.countdown').text();
  
  //var txt='16:22:15';

  //txt = "CHIBAI"
  var regex='((?:(?:[0-1][0-9])|(?:[2][0-3])|(?:[0-9])):(?:[0-5][0-9])(?::[0-5][0-9])?(?:\\s?(?:am|AM|pm|PM))?)'; // hh:mm:ss 1

  var re = new RegExp(regex);
  var myArray = re.exec(countdown);
  if( myArray != null ){
    console.log("Match")
    // if not null it will output something
    //console.log(myArray);  
  }
  else{
    var re = countdown.search('week')
    console.log("No match")
  }
  
});
