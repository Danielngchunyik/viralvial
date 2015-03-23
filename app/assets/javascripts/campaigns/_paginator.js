var paginatorTransition = function() {
  $(".pagination a").on("click", function() {
    $(".pagination").html("Loading the vials..");
  });
}

$(document).ready(paginatorTransition);
$(document).ajaxComplete(paginatorTransition);