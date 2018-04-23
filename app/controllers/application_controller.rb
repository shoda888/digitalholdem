class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  StatusConverter = {'preflop':5, 'flop':2, 'turn':1, 'river':0}
end
