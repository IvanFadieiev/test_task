Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root  'sessions#new'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  get 'my_posts',   to: 'posts#my_posts'
  resources :users do
    resources :posts, only: [:new, :create]
  end
  resources :posts do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
end
