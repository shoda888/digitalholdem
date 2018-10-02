class Admin::PlayersController < Admin::ApplicationController
  before_action :authenticate_player

  def index
    @players = Player.all.order('created_at desc')
  end
  def show
    @player = Player.find(params[:id])
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
    flash[:notice] = "プレイヤー登録されました。"
    redirect_to player_path(@current_player)
  end

  def refresh
    p1 = Player.find_by(name: 'player1')
    p1.game_id = params[:game_id]
    p1.chip = 500
    p1.save
    p0 = Player.find_by(name: 'player0')
    p0.game_id = params[:game_id]
    p0.chip = 500
    p0.save
    redirect_to admin_games_path
  end

  def proxy
    session[:player_id] = params[:id]
    flash[:notice] = "代理ログインしました"
    redirect_to games_path
  end

  private

  def player_params
    params.require(:player).permit(:name, :password, :role)
  end
end
