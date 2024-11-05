Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :companies, except: :destroy
  resources :posts, only: [:index, :show]
  resources :users, only: [:index, :show] 
  resources :domains, only: [:index, :show]

  resources :posts do
    resources :comments, only: [:show, :index, :create, :update, :destroy]
  end
  resources :comments do
    resources :comments, only: [:show, :index, :create, :update, :destroy]
  end
end
