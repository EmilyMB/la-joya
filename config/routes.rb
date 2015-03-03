Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/auth/facebook/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :uploads
  resources :games
end
