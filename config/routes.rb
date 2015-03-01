Rails.application.routes.draw do
  root to: "static_pages#home"

  resources :uploads
  resources :games
end
