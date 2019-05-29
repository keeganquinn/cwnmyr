# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    authenticate :user, ->(user) { user.admin? } do
      mount Blazer::Engine, at: 'blazer'
      mount PgHero::Engine, at: 'pghero'
    end
    resources :contacts, :groups, :hosts, :host_properties, :host_types,
              :interfaces, :interface_properties, :interface_types,
              :nodes, :node_links, :statuses, :users, :user_links, :zones
    root to: 'users#index'
  end

  get 'search', to: 'visitors#search'
  root to: 'visitors#index'

  devise_for :users

  resources :host_types, :host_properties, :host_types,
            :interfaces, :interface_properties, :interface_types,
            :node_links, :users, :user_links, :statuses
  resources :hosts do
    member do
      get 'graph'
    end
  end
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

  get 'nodes/logos/:id', to: 'nodes#logos'
end
