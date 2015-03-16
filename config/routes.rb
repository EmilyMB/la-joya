Rails.application.routes.draw do
  root to: "static_pages#landing"
  get "/home", to: "static_pages#home"
  get "/auth/facebook/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :uploads
  resources :games, only: [:new, :update, :index]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :words, only: [:index, :show]
    end
  end
end
