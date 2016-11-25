Rails.application.routes.draw do
  get '/', to: 'home#show'
  resources :projects, only: [:new, :index]

  get '/login', to: 'sessions#new'
  get "/auth/:provider/callback", to: "sessions#create"
end
