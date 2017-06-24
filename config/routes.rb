Rails.application.routes.draw do
  namespace :admin do
    resources :contacts, :groups, :hosts, :host_properties, :host_types, :interfaces, :interface_properties, :interface_types, :nodes, :node_links, :statuses, :tags, :users, :user_links, :zones
    root to: "users#index"
  end

  root to: 'visitors#index'

  devise_for :users
  resources :users
  resources :hosts, :node_links, :markers

  resources :zones do
    member do
      get 'markers'
    end
  end
  resources :nodes do
    member do
      get 'graph'
      get 'markers'
      get 'wl'
    end
  end

  get 'config' => 'config#index', as: :config
  get 'config/dns_zone_external' => 'config#dns_zone_external'
  get 'config/dns_zone_internal' => 'config#dns_zone_internal'
  get 'config/smokeping_external' => 'config#smokeping_external'
  get 'config/smokeping_internal' => 'config#smokeping_internal'
  get 'config/nagios_external' => 'config#nagios_external'
  get 'config/nagios_internal' => 'config#nagios_internal'
end
