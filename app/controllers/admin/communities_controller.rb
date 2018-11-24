class Admin::CommunitiesController < Admin::ApplicationController
  # before_action :authenticate_player
  def index
    @game = Game.find(params[:game_id])
    @communities = @game.communities.order(created_at: :asc)
  end
  def api
    @game = Game.find(params[:game_id])
    @communities = @game.communities.order(created_at: :asc)
    @communities = @communities.map do |community|
      {
        id: community.id,
        flop_start: community.created_at.instance_eval { '%s.%03d' % [strftime('%H:%M:%S'), (usec / 1000.0).round] },
        river_start: community.state_histories.find_by(state: 'river')&.created_at&.instance_eval { '%s.%03d' % [strftime('%H:%M:%S'), (usec / 1000.0).round] },
        river_end: community.state_histories.find_by(state: 'showdown')&.created_at&.instance_eval { '%s.%03d' % [strftime('%H:%M:%S'), (usec / 1000.0).round] },
        flop_pod: community.flop_pod,
        river_pod: community.river_pod,
        finished: community.state_histories.find_by(state: 'finished')&.created_at&.instance_eval { '%s.%03d' % [strftime('%H:%M:%S'), (usec / 1000.0).round] }
      }
    end
    render json: @communities
  end
end
