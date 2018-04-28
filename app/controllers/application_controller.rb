class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  StatusConverter = {'preflop':5, 'flop':2, 'turn':1, 'river':0}
  before_action :set_current_player

  def set_current_player
    @current_player = Player.find_by(id: session[:player_id])
  end

  def authenticate_player
    # if !@current_user
    #   flash[:notice] = "ログインが必要です"
    #   redirect_to new_session_path
    # end
  end

  def forbid_login_player
    # if @current_user
    #   flash[:notice] = "すでにログインしています"
    #   redirect_to posts_path
    # end
  end
end
