$(document).ready(function() {
  var $player_action_btn = $('.call_field').parent();
  $(".player_action_field:not(:has('#player1_call_btn,#player0_call_btn'))").css('visibility', 'visible');
  $('.dealer_btn').click(function(){
    App.community.speak();
  });
  $(document).on("click", ".select_winner", function(){
    $(this).hide();
    var selected = $(this).attr('id');
    App.community.speak(selected);
  });
  $(document).keydown(function(e){
    if ( $player_action_btn.css('visibility') == 'visible' ){
      switch(e.which){
        case 13: // Key[Enter]
        $player_action_btn.css('visibility', 'hidden')
        App.community.drop();
        break;
        case 32: // Key[Space]
        $player_action_btn.css('visibility', 'hidden');
        App.community.check();
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
