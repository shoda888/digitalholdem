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

  def show
    @player = @current_player
    @holes = @player.holes
    @win_holes = @holes.select{|hole| hole.out_come == true}
    @stay_holes = @holes.select{|hole| hole.stay? }
    @max_hand = @win_holes.max{|a, b| a.hand_before_type_cast <=> b.hand_before_type_cast}.hand
    @win_rate = @win_holes.length/@stay_holes.length.to_f * 100
  end

  def update
    @current_player.update(role: 'admin')
    flash[:notice] = "管理者登録されました。ゲームに参加の際はディーラーとしてゲームを開始してください。"
    redirect_to player_path(@current_player)
  end

  private

  def player_params
    params.require(:player).permit(:name, :password, :role)
  end
end
