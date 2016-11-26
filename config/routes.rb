Rails.application.routes.draw do
  root to: 'home#show'
  resources :projects, only: [:new, :create, :index, :show]

  get '/login', to: 'sessions#new'
  get "/auth/:provider/callback", to: "sessions#create"
end
