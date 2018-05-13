class SessionsController < ApplicationController
  before_action :forbid_login_player, {only: [:new,:create]}

  def new
  end

  def index
  end

  def create
    @player = Player.find_by(name: params[:name], password: params[:password])
    if @player
      session[:player_id] = @player.id
      flash[:notice] = "ログインしました"
      redirect_to games_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render new_session_path, name:params[:name]
    end
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end
end
