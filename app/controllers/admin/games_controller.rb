class Admin::GamesController < Admin::ApplicationController
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

  def edit
  end
  def update
    @current_player.update(game_id: params[:id])
    redirect_to new_community_path
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to admin_games_path
    else
      render :new
    end
  end
  def destroy
    @game = Game.find(params[:id])
    @game.delete
    redirect_to admin_games_path
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
