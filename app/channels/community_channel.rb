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
      @game.players.each do |player|
        @hole = player.holes.last
        @handlist["#{player.name}"] = @hole.hand_before_type_cast if @hole.stay?
      end
      max_val = (@handlist.max{|x,y| x[1] <=> y[1]})[1]
      @winners = @handlist.select{|k,v| v == max_val}.keys
      @losers = @handlist.select{|k,v| v != max_val}.keys
      winner_get_chips  if @winners.length == 1
      loser_lose_chips
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

  private

  def winner_get_chips
    @winners.each do |winner|
      player = Player.find_by(name: winner)
      player.holes.last.out_come = true
      player.chip += 24 #勝利プレイヤーのチップ数が5加わる
      player.save
    end
  end
  def loser_lose_chips
    @losers.each do |loser|
      player = Player.find_by(name: loser)
      player.chip -= 12 #敗者プレイヤーのチップ数が2減る
      player.save
    end
  end
end
