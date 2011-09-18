#--
# cwnmyr routes
# © 2011 Keegan Quinn
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#++

Cwnmyr::Application.routes.draw do
  devise_for :users

  resources :host_property_types
  resources :host_types do
    match :comments, :on => :member
  end

  resources :interface_property_types
  resources :interface_types
  resources :roles
  resources :services
  resources :statuses
  resources :users, :only => [ :index, :show ] do
    match :foaf, :role, :comments, :forgot, :logs, :on => :member
  end

  resources :zones

  # These routes are for legacy controllers which have not yet been converted
  # to support RESTful operation. These should be rewritten ASAP.
  match 'host/:action/:node_code(/:hostname)(.:format)' => 'host#index'
  match 'interface/:action/:node_code/:hostname(/:code)(.:format)' => 'interface#index'
  match 'node/:action(/:code)(.:format)' => 'node#index'

  match 'configuration/:action(.:format)' => 'configuration#index'

  root :to => 'welcome#index'
  match '/:controller(/:action(/:id))(.:format)'
end
