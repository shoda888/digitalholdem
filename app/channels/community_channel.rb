class CommunityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "community_channel"
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
    else
    end
    @community.save
    ActionCable.server.broadcast 'community_channel', message: "#{@community.aasm_state}"
  end
end
