Rails.application.routes.draw do
  get '/users/messages', to: 'users#messages', as: "users_messages"
  get '/users/messages/:receiver_id', to: 'users#message_thread', as: "users_message_thread"
  
  resources :notifications
  resources :reviews
  resources :messages
  resources :donations
  resources :users do
    get '/donations', to: 'users#donations', as: "donations"
  end
  get '/', to: 'static#index'
  get '/login', to: 'static#login'


  post '/login', to: 'static#attempt_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
