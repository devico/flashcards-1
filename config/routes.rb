Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  root 'home#index' 
  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  get 'sign_up', to: 'users#new', as: :sign_up
  resources :cards
  resources :decks, only: [:index, :new, :create, :destroy]
  post 'home', to: 'home#check'
  post "oauth/callback" => "oauths#callback"
  post "decks/activate" => "decks#activate", :as => :activate_deck
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
