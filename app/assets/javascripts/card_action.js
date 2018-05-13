$(document).ready(function() {
  $('.hole_card').show(1000);
  $('.dealer_btn').dblclick(function(){
    App.community.speak();
  });
  $('.drop_btn').dblclick(function(){
    $(this).hide();
    App.community.drop();
  });
  $('.hole_card_field').mouseout(function(){
    $(this).find('.show_hole_card').hide()
  });
  $('.hole_card_field').mouseover(function(){
    $(this).find('.show_hole_card').show()
  })
});
