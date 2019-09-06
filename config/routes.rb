# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    authenticate :user, ->(user) { user.admin? } do
      mount Blazer::Engine, at: 'blazer'
      mount PgHero::Engine, at: 'pghero'
    end
    resources :build_providers, :contacts, :devices, :device_builds,
              :device_properties, :device_property_types,
              :device_property_options, :device_types, :groups,
              :interfaces, :networks, :nodes, :statuses, :users, :zones
    root to: 'users#index'
  end

  get 'browse', to: 'visitors#browse'
  get 'search', to: 'visitors#search'
  root to: 'visitors#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  resources :contacts, :device_types, :groups, :networks, :statuses, :users
  resources :devices do
    member do
      get 'build_config'
      get 'conf'
      get 'graph'
      post 'build'
    end
  end
  resources :nodes do
    member do
      get 'graph'
    end
  end

  get 'nodes/logos/:id', to: 'nodes#logos'

  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
end
