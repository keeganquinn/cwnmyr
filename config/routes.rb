# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    authenticate :user, ->(user) { user.admin? } do
      mount Blazer::Engine, at: 'blazer'
      mount PgHero::Engine, at: 'pghero'
    end
    resources :contacts, :devices, :device_properties, :device_types, :groups,
              :interfaces, :interface_properties, :interface_types,
              :nodes, :node_links, :statuses, :users, :zones
    root to: 'users#index'
  end

  get 'browse', to: 'visitors#browse'
  get 'search', to: 'visitors#search'
  root to: 'visitors#index'

  devise_for :users

  resources :contacts, :device_properties, :device_types, :groups,
            :interfaces, :interface_properties, :interface_types,
            :node_links, :statuses, :users, :zones
  resources :devices do
    member do
      get 'graph'
    end
  end
  resources :nodes do
    member do
      get 'graph'
    end
  end

  get 'nodes/logos/:id', to: 'nodes#logos'
end
