Rails.application.routes.draw do
  root to: 'home#show'
  get '/no-demo-night', to: 'home#no_demo_night', as: 'no_demo_night'
  resources :projects, only: [:new, :create, :index, :show] do
    resources :votes, only: [:new, :create]
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :demo_nights, only: [:show, :new, :create]
    resources :projects, only: [:index, :edit]
  end

  get '/login', to: 'sessions#new'
  get "/auth/:provider/callback", to: "sessions#create"
end
