class GamesController < ApplicationController
  def index
    @games = Game.all
  end
  def show
    @game = Game.find(params[:id])
  end
  def new
    @game = Game.new
  end
  def update
    # @current_player.game_id = params[:id]
    # @current_player.save
    @current_player.update(game_id: params[:id])
    redirect_to new_community_path
  end

  def create
  end
end
