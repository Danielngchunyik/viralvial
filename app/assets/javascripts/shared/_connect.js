var triggerConnect = function() {
    // Trigger connect Modal
    $('.trigger-connect').on('click', function(e) {
      e.preventDefault();
    });

    $('#connect-modal').modal('attach events', '.trigger-connect', 'show');
}

$(document).ready(triggerConnect);
$(document).ajaxComplete(triggerConnect);