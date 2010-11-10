Cwnmyr::Application.routes.draw do
  resource :session do
    member do
      any :destroy
    end
  end

  resources :host_property_types
  resources :host_types do
    member do
      get :comments
    end
  end

  resources :interface_property_types
  resources :interface_types
  resources :roles
  resources :services
  resources :statuses
  resources :users do
    member do
      get :foaf
      any :role
      get :comments
      any :forgot
      get :logs
    end
  end

  resources :zones

  match 'host/:action/:node_code(/:hostname)(.:format)' => 'host#index'
  match 'interface/:action/:node_code/:hostname(/:code)(.:format)' => 'interface#index'
  match 'node/:action(/:code)(.:format)' => 'node#index'

  match 'configuration/:action(.:format)' => 'configuration#index', :as => :configuration

  match '' => 'welcome#index', :as => :welcome
  match '/:controller(/:action(/:id))(.:format)'
end
