$(document).ready(function() {
  var $player_action_btn = $('.call_field').parent();
  $(".player_action_field:not(:has('#player1_call_btn,#player0_call_btn'))").css('visibility', 'visible');
  $('#card4').show(10)
  $('#card3').show(10)
  $('#card2').show(10)
  $('.dealer_btn').click(function(){
    console.log(parseInt($('.pod_chip_number').find('input').val()));
    App.community.speak(parseInt($('.pod_chip_number').find('input').val()));
  });
  $(document).on("click", ".select_winner", function(){
    $(this).hide();
    var selected = $(this).attr('id');
    console.log(selected);
    App.community.speak(selected);
  });
  $(document).keydown(function(e){
    if ( $player_action_btn.css('visibility') == 'visible' ){
      switch(e.which){
        case 13: // Key[Enter]
        $player_action_btn.css('visibility', 'hidden');
        value = parseInt($player_action_btn.parents('.hole_card_field').siblings('.player_raise_field').find('input').val());
        console.log(value);
        App.community.bet(value);
        break;
        case 32: // Key[Space]
        App.community.raise();
        break;
      }
    }
  });
  // click操作無効
  // $('.drop_btn').click(function(){
  //   console.log('drop');
  //   App.community.drop();
  // });
  // $('.call_field').click(function(){
  //   App.community.check();
  // });
});
