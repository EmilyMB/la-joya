Rails.application.routes.draw do

  get 'uploads/new'

  get 'uploads/create'

  get 'uploads/index'

  root to: "static_pages#home"

  resources :uploads

end
