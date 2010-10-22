#--
# $Id: routes.rb 504 2007-07-14 12:19:03Z keegan $
# Copyright 2004-2007 Keegan Quinn
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

ActionController::Routing::Routes.draw do |map|
  map.resource :session,
    :new => { :create => :any }, :member => { :destroy => :any }

  map.resources :host_property_types
  map.resources :host_types, :member => { :comments => :get }
  map.resources :interface_property_types
  map.resources :interface_types
  map.resources :roles
  map.resources :services
  map.resources :statuses

  map.resources :users, :member => {
    :forgot => :any, :role => :any,
    :logs => :get, :comments => :get, :foaf => :get
  }
  map.resources :zones

  map.connect 'host/:action/:node_code/:hostname',
    :controller => 'host', :hostname => nil
  map.connect 'interface/:action/:node_code/:hostname/:code',
    :controller => 'interface', :code => nil
  map.connect 'node/:action/:code',
    :controller => 'node', :code => nil

  map.configuration 'configuration/:action', :controller => 'configuration'

  map.stats 'stats/:action', :controller => 'sitealizer'

  map.welcome '', :controller => 'welcome'

  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
