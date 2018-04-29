Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :communities
  resources :sessions
  resources :games
  resources :players
end
