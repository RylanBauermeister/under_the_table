Rails.application.routes.draw do
  
  get '/messages/inbox', to: 'messages#inbox', as: "inbox"
  get '/messages/:receiver_id', to: 'messages#message_thread', as: "message_thread"

  resources :notifications
  resources :reviews
  resources :messages
  resources :donations
  resources :users do
    get '/donations', to: 'users#donations', as: "donations"
    get '/morph', to: 'users#morph', as: "morph"
  end
  get '/', to: 'static#index'
  get '/login', to: 'static#login'


  post '/login', to: 'static#attempt_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
