$(function(){
  $('#red-button').click(function(){
    $('#header').css("background-color", "red");
    return false;
  });
  $('#green-button').click(function(){
    $('#header').css("background-color", "green");
    return false;
  });
  $('#blue-button').click(function(){
    $('#header').css("background-color", "blue");
    return false;
  });
  $('#reset-button').click(function(){
    $('#header').css("background-color", "#005a55");
    return false;
  });
});


