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
        $("##{data['player']}_card_field").hide()
        # $("##{data['player']}_card_field").find('.player_action_field').css('visibility', 'hidden')
      when 'check'
        $("##{data['player']}_call_btn").parent().css('visibility', 'hidden')
        $("##{data['player']}_card_field").siblings().find('input').val("#{data['chip']}")
        $(".pod_chip_number").find('input').val("#{data['pod']}")
      when "flop"
        $('.player_action_field').css('visibility', 'visible')
        $('#card4').show(1000)
        $('#card3').show(1000)
        $('#card2').show(1000)
      when "turn"
        $('.player_action_field').css('visibility', 'visible')
        $('#card1').show(1000)
      when "river"
        $('.player_action_field').css('visibility', 'visible')
        $('#card0').show(1000)
      when 'showdown'
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
