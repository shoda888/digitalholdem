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
    unless @current_player.tester?
      @game = Game.find(params[:id])
      if @game.players.any?{|player| player.admin? && player != @current_player}
        redirect_to game_path(@game), notice: '1テーブルにつき1管理者です'
        return
      end
    end
    @current_player.update(game_id: params[:id])
    redirect_to new_community_path
  end

  def create
  end
end
