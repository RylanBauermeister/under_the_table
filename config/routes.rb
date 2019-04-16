Rails.application.routes.draw do
  resources :notifications
  resources :reviews
  resources :messages
  resources :donations
  resources :users
  get '/', to: 'static#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
