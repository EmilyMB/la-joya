Rails.application.routes.draw do
  root to: "static_pages#landing"
  get "/home", to: "static_pages#home"
  get "/auth/facebook/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :uploads
  resources :games, only: [:new, :update, :index]
end
