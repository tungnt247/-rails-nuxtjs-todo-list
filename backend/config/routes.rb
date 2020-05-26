Rails.application.routes.draw do
  devise_for :users, skip: :all
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :todos
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      get 'user', to: 'sessions#show'
    end
  end
end
