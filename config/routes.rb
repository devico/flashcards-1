Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index' 
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  get 'sign_up', to: 'users#new', as: :sign_up
  resources :cards
  post 'home', to: 'home#check'

end
