class CommunityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "community_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'community_channel', message: data['message']
  end
end
