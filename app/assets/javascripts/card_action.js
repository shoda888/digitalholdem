$(document).ready(function() {
  $('.hole_card').show(1000);
  $('.show_hole_card').show()
  $('.player_action_field').css('visibility', 'hidden');
  $('#player1_call_btn').parent().css('visibility', 'visible');
  $('.dealer_btn').click(function(){
    App.community.speak();
  });
  $(document).on("click", ".select_winner", function(){
    $(this).hide();
    var selected = $(this).attr('id');
    App.community.speak(selected);
  });
  $('.drop_btn').click(function(){
    $(this).hide();
    console.log('drop');
    App.community.drop();
  });
  $('.call_field').click(function(){
    App.community.check();
  });
});
