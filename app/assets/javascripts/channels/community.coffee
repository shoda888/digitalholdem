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
        $("##{data['player']}_card_field").slideUp(500)
      when "flop"
        $('#card4').show(1000)
        $('#card3').show(1000)
        $('#card2').show(1000)
      when "turn"
        $('#card4').show(1000)
        $('#card3').show(1000)
        $('#card2').show(1000)
        $('#card1').show(1000)
      when "river"
        $('#card4').show(1000)
        $('#card3').show(1000)
        $('#card2').show(1000)
        $('#card1').show(1000)
        $('#card0').show(1000)
      else
        $('#card4').show(1000)
        $('#card3').show(1000)
        $('#card2').show(1000)
        $('#card1').show(1000)
        $('#card0').show(1000)
        $('.show_hand_name').show(1000)
        $('.show_hole_card').show(1000)
        $('.others_hole_card').show(1000)

  speak: (message)->
    @perform 'speak', message: message

  drop: ->
    @perform 'drop'
