class Admin::CommunitiesController < Admin::ApplicationController
  before_action :authenticate_player
  def index
    @game = Game.find(params[:game_id])
    @communities = Community.where(game_id: params[:game_id])
  end
end
