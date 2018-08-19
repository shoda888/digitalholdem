class GamesController < ApplicationController
  before_action :authenticate_player

  def index
    @games = Game.all
  end
  def show
    @game = Game.find(params[:id])
    @players = @game.players
  end
  def new
    @game = Game.new
  end
  def update
    @current_player.update(game_id: params[:id], chip: 500)
    redirect_to new_community_path
  end

  def create
  end
end
