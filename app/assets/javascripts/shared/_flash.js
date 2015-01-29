$(document).ready(function () {
  $(".message.closeable .close.icon").on("click", function() {
    $('.message.closeable').fadeOut("slow");
  });
});