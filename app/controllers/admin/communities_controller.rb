class Admin::CommunitiesController < Admin::ApplicationController
  before_action :authenticate_player
  def index
    @game = Game.find(params[:game_id])
    @communities = @game.communities.order(created_at: :asc)
  end
end
