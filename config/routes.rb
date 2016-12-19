Rails.application.routes.draw do
  root to: 'home#show'
  resources :projects, only: [:new, :create, :index, :show] do
    resources :votes, only: [:new, :create]
  end

  resources :demo_nights, only: [:show] do
    resources :projects, only: [:index]
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :demo_nights, only: [:index, :show, :new, :create]
    resources :projects, only: [:index, :edit]
  end

  get '/login', to: 'sessions#new'
  get "/auth/:provider/callback", to: "sessions#create"
end
