Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

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
