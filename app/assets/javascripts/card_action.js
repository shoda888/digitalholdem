$(document).ready(function() {
  $('.hole_card').show(1000);
  $('.dealer_btn').click(function(){
    App.community.speak();
  });
  $(document).on("click", ".select_winner", function(){
    var selected = $(this).attr('id')
    console.log(selected)
    App.community.speak(selected);
  });
  $('.drop_btn').click(function(){
    $(this).hide();
    App.community.drop();
  });
  $('.hole_card_field').mouseout(function(){
    $(this).find('.show_hole_card').hide()
  });
  $('.hole_card_field').mouseover(function(){
    $(this).find('.show_hole_card').show()
  });
});
