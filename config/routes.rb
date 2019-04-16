Rails.application.routes.draw do
  resources :notifications
  resources :reviews
  resources :messages
  resources :donations
  resources :users
  get '/', to: 'static#index'
  get '/login', to: 'static#login'
  post '/login', to: 'static#attempt_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
