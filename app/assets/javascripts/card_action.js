$(document).ready(function() {
  $('.hole_card').show(1000);
  $('.status_change_btn').dblclick(function(){
    App.community.speak();
  });
  $('.admin_start_btn').click(function(){
    App.community.ready();
  });
  $('.hole_card_field').mouseout(function(){
    $(this).find('.show_hole_card').hide()
  });
  $('.hole_card_field').mouseover(function(){
    $(this).find('.show_hole_card').show()
    // $('.hole_card_field > .show_hole_card').show()
  })
  //
  // $('#c1_hole').mouseover(function(){
  //   $(this).attr('src', '/c1.png');
  // });
  // $('#c2_hole').mouseover(function(){
  //   $(this).attr('src', '/c2.png');
  // });
  // $('#c3_hole').mouseover(function(){
  //   $(this).attr('src', '/c3.png')
  // });
  // $('#c4_hole').mouseover(function(){
  //   $(this).attr('src','/c4.png');
  // });
  // $('#c5_hole').mouseover(function(){
  //   $(this).attr('src','/c5.png');
  // });
  // $('#c6_hole').mouseover(function(){
  //   $(this).attr('src', '/c6.png');
  // });
  // $('#c7_hole').mouseover(function(){
  //   $(this).attr('src', '/c7.png');
  // });
  // $('#c8_hole').mouseover(function(){
  //   $(this).attr('src', '/c8.png')
  // });
  // $('#c9_hole').mouseover(function(){
  //   $(this).attr('src','/c9.png');
  // });
  // $('#c10_hole').mouseover(function(){
  //   $(this).attr('src','/c10.png');
  // });
  // $('#c11_hole').mouseover(function(){
  //   $(this).attr('src', '/c11.png')
  // });
  // $('#c12_hole').mouseover(function(){
  //   $(this).attr('src','/c12.png');
  // });
  // $('#c13_hole').mouseover(function(){
  //   $(this).attr('src','/c13.png');
  // });
  // $('#d1_hole').mouseover(function(){
  //   $(this).attr('src', '/d1.png');
  // });
  // $('#d2_hole').mouseover(function(){
  //   $(this).attr('src', '/d2.png');
  // });
  // $('#d3_hole').mouseover(function(){
  //   $(this).attr('src', '/d3.png')
  // });
  // $('#d4_hole').mouseover(function(){
  //   $(this).attr('src','/d4.png');
  // });
  // $('#d5_hole').mouseover(function(){
  //   $(this).attr('src','/d5.png');
  // });
  // $('#d6_hole').mouseover(function(){
  //   $(this).attr('src', '/d6.png');
  // });
  // $('#d7_hole').mouseover(function(){
  //   $(this).attr('src', '/d7.png');
  // });
  // $('#d8_hole').mouseover(function(){
  //   $(this).attr('src', '/d8.png')
  // });
  // $('#d9_hole').mouseover(function(){
  //   $(this).attr('src','/d9.png');
  // });
  // $('#d10_hole').mouseover(function(){
  //   $(this).attr('src','/d10.png');
  // });
  // $('#d11_hole').mouseover(function(){
  //   $(this).attr('src', '/d11.png')
  // });
  // $('#d12_hole').mouseover(function(){
  //   $(this).attr('src','/d12.png');
  // });
  // $('#d13_hole').mouseover(function(){
  //   $(this).attr('src','/d13.png');
  // });
  // $('#h1_hole').mouseover(function(){
  //   $(this).attr('src', '/h1.png');
  // });
  // $('#h2_hole').mouseover(function(){
  //   $(this).attr('src', '/h2.png');
  // });
  // $('#h3_hole').mouseover(function(){
  //   $(this).attr('src', '/h3.png')
  // });
  // $('#h4_hole').mouseover(function(){
  //   $(this).attr('src','/h4.png');
  // });
  // $('#h5_hole').mouseover(function(){
  //   $(this).attr('src','/h5.png');
  // });
  // $('#h6_hole').mouseover(function(){
  //   $(this).attr('src', '/h6.png');
  // });
  // $('#h7_hole').mouseover(function(){
  //   $(this).attr('src', '/h7.png');
  // });
  // $('#h8_hole').mouseover(function(){
  //   $(this).attr('src', '/h8.png')
  // });
  // $('#h9_hole').mouseover(function(){
  //   $(this).attr('src','/h9.png');
  // });
  // $('#h10_hole').mouseover(function(){
  //   $(this).attr('src','/h10.png');
  // });
  // $('#h11_hole').mouseover(function(){
  //   $(this).attr('src', '/h11.png')
  // });
  // $('#h12_hole').mouseover(function(){
  //   $(this).attr('src','/h12.png');
  // });
  // $('#h13_hole').mouseover(function(){
  //   $(this).attr('src','/h13.png');
  // });
  // $('#s1_hole').mouseover(function(){
  //   $(this).attr('src', '/s1.png');
  // });
  // $('#s2_hole').mouseover(function(){
  //   $(this).attr('src', '/s2.png');
  // });
  // $('#s3_hole').mouseover(function(){
  //   $(this).attr('src', '/s3.png')
  // });
  // $('#s4_hole').mouseover(function(){
  //   $(this).attr('src','/s4.png');
  // });
  // $('#s5_hole').mouseover(function(){
  //   $(this).attr('src','/s5.png');
  // });
  // $('#s6_hole').mouseover(function(){
  //   $(this).attr('src', '/s6.png');
  // });
  // $('#s7_hole').mouseover(function(){
  //   $(this).attr('src', '/s7.png');
  // });
  // $('#s8_hole').mouseover(function(){
  //   $(this).attr('src', '/s8.png')
  // });
  // $('#s9_hole').mouseover(function(){
  //   $(this).attr('src','/s9.png');
  // });
  // $('#s10_hole').mouseover(function(){
  //   $(this).attr('src','/s10.png');
  // });
  // $('#s11_hole').mouseover(function(){
  //   $(this).attr('src', '/s11.png')
  // });
  // $('#s12_hole').mouseover(function(){
  //   $(this).attr('src','/s12.png');
  // });
  // $('#s13_hole').mouseover(function(){
  //   $(this).attr('src','/s13.png');
  // });
});
