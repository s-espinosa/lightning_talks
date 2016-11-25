Rails.application.routes.draw do
  get '/', to: 'home#show'
  resources :projects, only: [:new, :index]
end
