Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show, :create, :update, :destroy]
      resources :sales, only: [:index, :show, :create, :update, :destroy]
      resources :suppliers, only: [:index, :show, :create, :update, :destroy]
      resources :orders, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :transactions, only: [:index, :show, :create, :update, :destroy]
      post 'login', to: 'session#create'
      delete 'logout', to: 'session#destroy'
    end
  end
end
