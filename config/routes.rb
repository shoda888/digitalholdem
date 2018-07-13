Rails.application.routes.draw do
  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :games
    resources :players
  end

  resources :communities
  resources :sessions
  resources :games
  resources :players
end
