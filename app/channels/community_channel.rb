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

  def check
    @hole = current_player.holes.last
    @community = @hole.community
    case @community.aasm_state
    when 'preflop'
      chips_to_pod(1)
    when 'flop'
      chips_to_pod(3)
    when 'turn'
      chips_to_pod(9)
    when 'river'
      chips_to_pod(27)
    else
    end
    @community.save
    current_player.save
    CommunityChannel.broadcast_to(current_player.game, { message: 'check', player: current_player.name, chip: current_player.chip, pod: @community.pod})
  end

  private

  def winner_get_chips
    player = Player.find_by(name: @winners[0])
    @community.holes.find_by(player_id: player.id).update_column(:out_come, true)
    player.chip += @community.pod  #勝利プレイヤーのチップ数が加わる
    player.save
  end

  def chips_to_pod(num)
    current_player.chip -= num
    @community.pod += num
  end
end
