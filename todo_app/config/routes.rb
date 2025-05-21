Rails.application.routes.draw do
  resources :users
  resources :tasks
  resources :projects
  resources :messages
  resources :friendships
  resource :session, only: [:new, :create, :destroy]

  root "tasks#index"
end
