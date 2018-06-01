class Admin::PlayersController < Admin::ApplicationController
  before_action :authenticate_player

  def index
    @players = Player.all.order('created_at desc')
  end
  def show
    @player = Player.find(params[:id])
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
