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
      loser_lose_chips
      #判断できない場合、ディーラーによるキッカー判断がおこなわれる
    when 'finished'
      @losers = @winners.reject{ |winner| winner == data['message']}
      @winners = [data['message']]
      winner_get_chips
      loser_lose_chips
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
    @community = @hole.community.last
    case @community.aasm_state
    when 'preflop'
      current_player.chip -= 1
    when 'flop'
      current_player.chip -= 2
    when 'turn'
      current_player.chip -= 4
    when 'river'
      current_player.chip -= 8
    else
    end
    current_player.save
    @hole.drop
    @hole.save
    CommunityChannel.broadcast_to(current_player.game, { message: 'drop', player: current_player.name })
  end

  private

  def winner_get_chips
    player = Player.find_by(name: @winners[0])
    @community.holes.find_by(player_id: player.id).update_column(:out_come, true)
    number_of_losers = @community.holes.count{|hole| hole.stay?}  # ホールがステイのプレイヤーの数を算出する
    player.chip += 16 * (number_of_losers + 1)  #勝利プレイヤーのチップ数が加わる
    player.save
  end
  def loser_lose_chips
    @losers.each do |loser|
      player = Player.find_by(name: loser)
      player.chip -= 16 #敗者プレイヤーのチップ数が減る
      player.save
    end
  end
end
