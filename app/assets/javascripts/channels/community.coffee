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
      when 'drop'
        current_player = data['player']
        $("##{current_player}_card_field").hide(100)
        if current_player == data['stayers'][0]
          $second_player_action_field = $("##{data['stayers'][1]}_call_btn").parent()
          $second_player_action_field.css('visibility', 'visible')
        else if current_player == data['stayers'][1]
          $last_player_action_field = $("##{data['stayers'][2]}_call_btn").parent()
          $last_player_action_field.css('visibility', 'visible')
        else
      when 'check'
        current_player = data['player']
        $current_player_action_field = $("##{current_player}_call_btn").parent()
        $my_pod = $("##{current_player}_card_field").siblings().find('input')
        $table_pod = $(".pod_chip_number").find('input')
        $current_player_action_field.css('visibility', 'hidden');
        $my_pod.val("#{data['chip']}")
        $table_pod.val("#{data['pod']}")
        if current_player == data['stayers'][0]
          $second_player_action_field = $("##{data['stayers'][1]}_call_btn").parent()
          $second_player_action_field.css('visibility', 'visible')
        else if current_player == data['stayers'][1]
          $last_player_action_field = $("##{data['stayers'][2]}_call_btn").parent()
          $last_player_action_field.css('visibility', 'visible')
        else
      when "flop"
        $first_player_action_field = $("##{data['stayers'][0]}_call_btn").parent()
        $first_player_action_field.css('visibility', 'visible');
        $('p.state_text').text('フロップです。コールには３枚のチップが必要です。')
        $('#card4').show(1000)
        $('#card3').show(1000)
        $('#card2').show(1000)
      when "turn"
        $first_player_action_field = $("##{data['stayers'][0]}_call_btn").parent()
        $first_player_action_field.css('visibility', 'visible');
        $('p.state_text').text('ターンです。コールには９枚のチップが必要です。')
        $('#card1').show(1000)
      when "river"
        $first_player_action_field = $("##{data['stayers'][0]}_call_btn").parent()
        $first_player_action_field.css('visibility', 'visible');
        $('p.state_text').text('リバーです。コールには２７枚のチップが必要です。')
        $('#card0').show(1000)
      when 'showdown'
        $('p.state_text').text('ショーダウンです。')
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

  check: ->
    @perform 'check'
