class PlayersController < ApplicationController
  before_action :forbid_login_player, {only: [:new,:create]}
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      session[:player_id] = @player.id
      flash[:notice] = "ユーザーが登録されました"
      redirect_to games_path
    else
      render new_player_path
    end
  end
  private

  def player_params
    params.require(:player).permit(:name, :password)
  end
end
