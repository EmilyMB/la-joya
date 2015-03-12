Rails.application.routes.draw do
  root to: "static_pages#landing"
  get "/home", to: "static_pages#home"
  get "/auth/facebook/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  post "/audio/save_file", to: "uploads#stuff"
  resources :uploads, only: [:create, :index, :new, :update]
  resources :games, only: [:new, :update, :index]
end
