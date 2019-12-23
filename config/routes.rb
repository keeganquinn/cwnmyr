# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    authenticate :user, ->(user) { user.admin? } do
      mount Blazer::Engine, at: 'blazer'
      mount PgHero::Engine, at: 'pghero'
    end
    resources :build_providers, :contacts, :devices, :device_builds,
              :device_properties, :device_property_types,
              :device_property_options, :device_types, :events, :groups,
              :interfaces, :networks, :nodes, :statuses, :users, :zones
    root to: 'users#index'
  end

  get 'browse', to: 'visitors#browse'
  root to: 'visitors#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  resources :contacts, :device_types, :events, :groups, :networks,
            :statuses, :users
  resources :devices do
    member do
      post 'build'
      get 'build_config'
      get 'conf'
      get 'graph'
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

  get '/android-chrome-192x192.png',
      to: 'visitors#chromeicon_192', format: 'png'
  get '/android-chrome-512x512.png',
      to: 'visitors#chromeicon_512', format: 'png'
  get '/apple-touch-icon.png',
      to: 'visitors#touchicon_180', format: 'png'
  get '/browserconfig.xml',
      to: 'visitors#browserconfig', format: 'xml'
  get '/favicon-16x16.png',
      to: 'visitors#favicon_png16', format: 'png'
  get '/favicon-32x32.png',
      to: 'visitors#favicon_png32', format: 'png'
  get '/favicon.ico',
      to: 'visitors#favicon_ico', format: 'ico'
  get '/mstile-150x150.png',
      to: 'visitors#mstile_150', format: 'png'
  get '/safari-pinned-tab.svg',
      to: 'visitors#maskicon_svg', format: 'svg'
  get '/site.webmanifest',
      to: 'visitors#webmanifest', format: 'json'
end
