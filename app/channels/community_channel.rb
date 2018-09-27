class CommunityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "community_channel"
    stream_for current_player.game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @game = current_player.game
    @community = @game.communities.last
    case @community.aasm_state
    when 'flop'
      @community.flop_pod = data['message']
      @community.to_river!
      @community.save
    when 'river'
      @community.river_pod = data['message'] - @community.flop_pod
      @community.open!
      @community.save
    when 'showdown'
      @community.finish!
      #holeがstayのプレイヤーのhole.handが一番大きいのが勝ち
      @handlist = {}
      @community.holes.each do |hole|
        @handlist["#{hole.player.name}"] = hole.hand_before_type_cast if hole.stay?
      end
      max_val = (@handlist.max{|x,y| x[1] <=> y[1]})[1]
      @winners = @handlist.select{|k,v| v == max_val}.keys
      @losers = @handlist.select{|k,v| v != max_val}.keys
      winner_get_chips  if @winners.length == 1
      #判断できない場合、ディーラーによるキッカー判断がおこなわれる
    when 'finished'
      @winners = [data['message']]
      winner_get_chips
    else
    end

    if @community.finished?
      CommunityChannel.broadcast_to(current_player.game, { message: 'finished', winner: @winners })
    else
      CommunityChannel.broadcast_to(current_player.game, { message: @community.aasm_state, player: current_player.name })
    end
  end

  def raise
    CommunityChannel.broadcast_to(current_player.game, { message: 'raise', player: current_player.name })
  end

  def bet(data)
    chips_to_pod(data['value'])
    current_player.save
    CommunityChannel.broadcast_to(current_player.game, { message: 'bet', player: current_player.name })
  end

  private

  def winner_get_chips
    player = Player.find_by(name: @winners[0])
    @community.holes.find_by(player_id: player.id).update_column(:out_come, true)
    # player.chip += @community.pod  #勝利プレイヤーのチップ数が加わる
    player.chip += @community.flop_pod + @community.river_pod
    player.save
  end

  def chips_to_pod(num)
    current_player.chip -= num
    # @community.pod += num
  end
end
