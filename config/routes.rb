Rails.application.routes.draw do
  root to: "sessions#new"
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  post 'proxy', to: 'admin/players#proxy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :games
    resources :players
  end

  resources :communities do
    resource :reviews
  end
  resources :sessions
  resources :games
  resources :players
end
