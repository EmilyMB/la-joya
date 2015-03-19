Rails.application.routes.draw do
  root to: "static_pages#landing"
  get "/home", to: "static_pages#home"
  get "/auth/facebook/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  patch "/add_meaning", to: "uploads#add_meaning"
  delete "/remove_upload", to: "uploads#remove_upload"
  resources :uploads, except: [:show]
  resources :games, only: [:new, :update]
  resource :dashboard, only: [:show]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :words, only: [:index, :show]
    end
  end
end
