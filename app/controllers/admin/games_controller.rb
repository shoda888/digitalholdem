class Admin::GamesController < ApplicationController
  before_action :authenticate_player
  def index
    @games = Game.all
  end
  def show
  end
  def new
    @game = Game.new
  end

  def edit
  end
  def update
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
