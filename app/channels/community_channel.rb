class CommunityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "community_channel"
    stream_for current_player.game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    @game = current_player.game
    @community = @game.communities.last
    case @community.aasm_state
    when 'preflop'
      @community.to_flop
    when 'flop'
      @community.to_turn
    when 'turn'
      @community.to_river
    when 'river'
      @community.open
    when 'showdown'
      @community.finish
      #holeがstayのプレイヤーのhole.handが一番大きいのが勝ち
      @handlist = {}
      @game.players.each do |player|
        @hole = player.holes.last
        if @hole.stay?
          @handlist["#{player.name}"] = @hole.hand_before_type_cast
        end
      end
      max_val = (@handlist.max{|x,y| x[1] <=> y[1]})[1]
      @winners = @handlist.select{|k,v| v == max_val}.keys
      @winners.each do |winner|
        player = Player.find_by(name: winner)
        player.holes.last.out_come = true
        player.save
      end
      #判断できない場合、ディーラーによるキッカー判断がおこなわれる
    else
    end
    @community.save
    if @community.finished?
      CommunityChannel.broadcast_to(current_player.game, { message: 'finished', winner: @winners })
    else
      CommunityChannel.broadcast_to(current_player.game, { message: @community.aasm_state })
    end
  end

  def drop
    @hole = current_player.holes.last
    @hole.drop
    @hole.save
    CommunityChannel.broadcast_to(current_player.game, { message: 'drop', player: current_player.name })
  end
end
