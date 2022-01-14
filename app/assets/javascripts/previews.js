$(function() {
  $("#inputer input").keyup(function() {
    $.get($("#inputer").attr("action"), $("#inputer").serialize(), null, "script");
    return false;
  });
});
$(document).on('turbolinks:load', function();
