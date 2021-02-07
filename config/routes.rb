Rails.application.routes.draw do
  devise_for :merchants
  resources :merchants, except: %i[new create]

  root to: 'merchants#index'

  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      post 'sign_in', to: 'sessions#sign_in'
      resources :transactions, only: [:create]
    end
  end
end
