App.community = App.cable.subscriptions.create "CommunityChannel",
  connected: ->
    # alert 'connected'
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # alert 'disconnected'
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data['message'])
    switch data['message']
      when 'start'
        $('.player_start_btn').show(500)
      when 'raise'
        current_player = data['player']
        $my_pod = $("##{current_player}_card_field").siblings(".player_chip_number").find('input')
        $my_raise_field = $("##{current_player}_card_field").siblings(".player_raise_field").find('input')
        $my_raise_field.val("#{parseInt($my_raise_field.val()) + 1}")  #raiseフィールドに+1
        $my_pod.val("#{parseInt($my_pod.val()) - 1}") #my_podが-1
      when 'bet'
        current_player = data['player']
        $my_raise_field = $("##{current_player}_card_field").siblings(".player_raise_field").find('input')
        $table_pod = $(".pod_chip_number").find('input')
        $player_action_btn = $("##{current_player}_call_btn").parent()
        $player_action_btn.css('visibility', 'hidden')

        $second_player_action_field = $("#player0_call_btn").parent()
        $second_player_action_field.css('visibility', 'visible')
        setTimeout (->
          $second_player_pod = $("#player0_card_field").siblings(".player_chip_number").find('input')
          $second_player_raise_field = $("#player0_card_field").siblings(".player_raise_field").find('input')
          $second_player_raise_field.val("#{parseInt($my_raise_field.val())}")  #testerにコール
          $second_player_pod.val("#{parseInt($second_player_pod.val()) - parseInt($second_player_raise_field.val())}")
          $second_player_action_field.css('visibility', 'hidden')

          $last_player_action_field = $("#player1_call_btn").parent()
          $last_player_action_field.css('visibility', 'visible')
          setTimeout (->
            $last_player_pod = $("#player1_card_field").siblings(".player_chip_number").find('input')
            $last_player_raise_field = $("#player1_card_field").siblings(".player_raise_field").find('input')
            $last_player_raise_field.val("#{parseInt($my_raise_field.val())}")  #testerにコール
            $last_player_pod.val("#{parseInt($last_player_pod.val()) - parseInt($last_player_raise_field.val())}")
            $last_player_action_field.css('visibility', 'hidden')
            setTimeout (->
              $table_pod.val("#{parseInt($table_pod.val()) + 3 * parseInt($my_raise_field.val())}")
              $my_raise_field.val(0) #ベットが終わり、テーブルに回収される
              $second_player_raise_field.val(0) #ベットが終わり、テーブルに回収される
              $last_player_raise_field.val(0) #ベットが終わり、テーブルに回収される
            ), 1000
          ), 1000
        ), 1000
      when "river"
        $first_player_action_field = $("##{data['stayers'][0]}_call_btn").parent()
        $first_player_action_field.css('visibility', 'visible');
        $('p.state_text').text('リバーです。')
        $('#card1').show(1000)
        $('#card0').show(1000)
      when 'showdown'
        $('p.state_text').text('オープン')
        $('.player_action_field').css('visibility', 'hidden')
        $('.show_hand_name').show(1000)
        $('.show_hole_card').show(1000)
        $('.others_hole_card').show(1000)
      else
        for val, i in data['winner']
          if data['winner'].length == 1
            $("##{data['winner'][0]}_card_field").find('.show_hand_name').append('<div><i class="fas fa-trophy fa-2x faa-wrench animated"></i></div>')
            $('.hole_card_field').not("##{data['winner'][0]}_card_field").slideUp(500)
          else
            $("##{data['winner'][i]}_card_field").append("<div id='#{data['winner'][i]}', class='select_winner'><div class='btn btn-warning'>select a winner</div></div>")

  speak: (message)->
    @perform 'speak', message: message

  drop: ->
    @perform 'drop'

  raise: ->
    @perform 'raise'

  bet: ->
    @perform 'bet'
