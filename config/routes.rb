Rails.application.routes.draw do
  namespace :admin do
    resources :contacts, :groups, :hosts, :host_properties, :host_types,
              :interfaces, :interface_properties, :interface_types,
              :nodes, :node_links, :statuses, :tags, :users, :user_links, :zones
    root to: 'users#index'
  end

  root to: 'visitors#index'

  devise_for :users

  resources :host_types, :hosts, :host_properties, :host_types,
            :interfaces, :interface_properties, :interface_types,
            :node_links, :users, :user_links, :statuses
  resources :nodes do
    member do
      get 'graph'
    end
  end
  resources :zones do
    member do
      get 'conf'
    end
  end
end
