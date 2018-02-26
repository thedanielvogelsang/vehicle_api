Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    namespace :v1 do
      resources :vehicles, only: [:index, :show, :create, :update, :destroy]
      resources :options, only: [:index, :show, :create, :update, :destroy]
      resources :makes, only: [:index, :show, :create, :update, :destroy]
      resources :models, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
