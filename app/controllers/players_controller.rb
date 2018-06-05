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
    if @holes.present?
      if @win_holes.present?
        @max_hand = @win_holes.max{|a, b| a.hand_before_type_cast <=> b.hand_before_type_cast}.hand
      else
        @max_hand = '- -'
      end
      @win_rate = @win_holes.length/@stay_holes.length.to_f * 100
    else
      @win_rate = '- -'
    end
  end

  def update
    @current_player.update(role: params[:become])
    flash[:notice] = "ディーラー登録されました。ディーラーとしてゲームを開始してください。" if params[:become] == 'dealer'
    flash[:notice] = "プレイヤー登録されました。" if params[:become] == 'normal'
    redirect_to player_path(@current_player)
  end

  private

  def player_params
    params.require(:player).permit(:name, :password, :role)
  end
end
