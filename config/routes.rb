Rails.application.routes.draw do
  root to: "static_pages#landing"
  get "/home", to: "static_pages#home"
  get "/auth/facebook/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :uploads, only: [:create, :index, :new]
  resources :games, only: [:new]
end
