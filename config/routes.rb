Rails.application.routes.draw do
  namespace :admin do
    resources :groups, :hosts, :nodes, :users, :zones
    root to: "users#index"
  end

  root to: 'visitors#index'

  devise_for :users
  resources :nodes, :users, :zones

  get 'config/index' => 'config#index', as: :config
end
