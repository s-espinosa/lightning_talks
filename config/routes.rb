Rails.application.routes.draw do
  root to: 'home#show'

  get '/no-lightning-talk', to: 'home#no_lightning_talk'

  resources :projects, only: [:new, :create, :index, :show, :edit, :update] do
    resources :votes, only: [:new, :create, :edit, :update]
  end

  resources :lightning_talks, only: [:show] do
    resources :projects, only: [:index]
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    get '/scoreboard', to: 'scoreboard#show'
    resources :lightning_talks, only: [:index, :show, :new, :create, :update]
    resources :projects, only: [:index, :edit, :update, :show, :destroy]
  end

  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'

  get '/clever_students', to: 'pages#clever', as: 'clever'
  mount ActionCable.server, at: '/cable'
end
