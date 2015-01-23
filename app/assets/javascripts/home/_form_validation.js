$(document).ready(function() {

  $('#contact_form')
    .form({
      name: {
        identifier: 'contact_name',
        rules: [
          {
            type: 'empty',
            prompt: 'Please enter your name'
          }
        ]
      },

      email: {
        identifier: 'contact_email',
        rules: [
          {
            type: 'email',
            prompt: 'Please enter a valid email address'
          }
        ]
      },

      content: {
        identifier: 'contact_content',
        rules: [
          {
            type: 'empty',
            prompt: 'Please enter your message'
          }
        ]
      }
    }, {
      inline: true
    });
});