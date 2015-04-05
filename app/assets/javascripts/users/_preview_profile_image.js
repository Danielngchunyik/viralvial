var initPreviewImage = function(previewer, uploader) {

  var preview = $(previewer)

  $(uploader).change(function(event) {
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

$(document).ready(function() {
  initPreviewImage('.upload-previewer', '.uploader');
  initPreviewImage('.upload-previewer-1', '.uploader-1');
  initPreviewImage('.upload-previewer-2', '.uploader-2');
});

$(document).ajaxComplete(function() {
  initPreviewImage('.upload-previewer', '.uploader')
});