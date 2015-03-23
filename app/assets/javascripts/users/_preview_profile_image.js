var initPreviewImage = function() {

  var preview = $('.upload-previewer')

  $(".uploader").change(function(event) {
    var file, input, reader;

    input = $(event.currentTarget);
    file = input[0].files[0];
    reader = new FileReader();

    reader.onload = function(e) {
      var image_base64 = e.target.result;
      preview.attr("src", image_base64);
    };

    reader.readAsDataURL(file);
  });
}

$(document).ready(initPreviewImage);
$(document).ajaxComplete(initPreviewImage);