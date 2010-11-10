Cwnmyr::Application.routes.draw do
  resource :session do
    match :destroy, :on => :member
  end

  resources :host_property_types
  resources :host_types do
    match :comments, :on => :member
  end

  resources :interface_property_types
  resources :interface_types
  resources :roles
  resources :services
  resources :statuses
  resources :users do
    match :foaf, :role, :comments, :forgot, :logs, :on => :member
  end

  resources :zones

  match 'host/:action/:node_code(/:hostname)(.:format)' => 'host#index'
  match 'interface/:action/:node_code/:hostname(/:code)(.:format)' => 'interface#index'
  match 'node/:action(/:code)(.:format)' => 'node#index'

  match 'configuration/:action(.:format)' => 'configuration#index'

  root :to => 'welcome#index'
  match '/:controller(/:action(/:id))(.:format)'
end
