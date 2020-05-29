Rails.application.routes.draw do
  devise_for :users, skip: :all
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'sessions#create'
      get 'user', to: 'sessions#show'
      post 'facebook_login', to: 'sessions#facebook_login'

      resources :tasks, only: %i[index create update destroy] do
        patch 'complete', on: :member
      end
    end
  end
end
