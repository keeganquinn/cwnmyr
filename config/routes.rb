Rails.application.routes.draw do
  namespace :admin do
    resources :contacts, :groups, :hosts, :host_properties, :host_types, :interfaces, :interface_properties, :interface_types, :nodes, :node_links, :statuses, :tags, :users, :user_links, :zones
    root to: "users#index"
  end

  root to: 'visitors#index'

  devise_for :users
  resources :nodes, :users, :zones

  get 'config/index' => 'config#index', as: :config
end
