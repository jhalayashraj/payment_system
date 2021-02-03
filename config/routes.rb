Rails.application.routes.draw do
  devise_for :merchants
  resources :merchants, except: %i[new create]

  root to: 'merchants#index'
end
