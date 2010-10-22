#--
# $Id: host_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
# Copyright 2004-2006 Keegan Quinn
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

require File.dirname(__FILE__) + '/../test_helper'
require 'host_controller'

# Re-raise errors caught by the controller.
class HostController; def rescue_action(e) raise e end; end

class HostControllerTest < ActionController::TestCase
  fixtures :hosts, :host_services, :host_types, :host_property_types
  fixtures :services, :zones, :nodes, :statuses, :users

  def setup
    @controller = HostController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'host', { :controller => 'host', :action => 'index' }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'host/show/nodecode/hostname', {
      :controller => 'host', :action => 'show',
      :node_code => 'nodecode', :hostname => 'hostname'
    }

    get :show, {
      :node_code => nodes(:first).code, :hostname => hosts(:first).name
    }

    assert_template 'show'
    assert_not_nil assigns(:host)
    assert assigns(:host).valid?
  end

  def test_new
    assert_routing 'host/new/nodecode', {
      :controller => 'host', :action => 'new', :node_code => 'nodecode'
    }

    assert_requires_login { get :new, :node_code => nodes(:first).code }

    num_hosts = Host.count

    assert_accepts_login(:arthur) {
      get :new, :node_code => nodes(:first).code

      assert_template 'new'
      assert_not_nil assigns(:host)

      post :new, {
        :node_code => nodes(:first).code,
        :host => {
          :host_type_id => host_types(:first).id,
          :status_id => statuses(:first).id,
          :name => 'testing',
          :top_level_hostname => true
        }
      }

      assert_redirected_to(:action => 'show',
                           :node_code => nodes(:first).code,
                           :hostname => 'testing')

      get :show, :node_code => nodes(:first).code, :hostname => 'testing'
    }

    assert_equal num_hosts + 1, Host.count
  end

  def test_edit
    assert_routing 'host/edit/nodecode/hostname', {
      :controller => 'host', :action => 'edit', 
      :node_code => 'nodecode', :hostname => 'hostname'
    }

    assert_requires_login {
      get :edit, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }
    }

    assert_accepts_login(:arthur) {
      get :edit, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }

      assert_template 'edit'
      assert_not_nil assigns(:host)
      assert assigns(:host).valid?

      post :edit, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }

      assert_redirected_to(:action => 'show',
                           :node_code => nodes(:first).code,
                           :hostname => hosts(:first).name)

      get :show, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }
    }
  end

  def test_destroy
    assert_routing 'host/destroy/nodecode/hostname', {
      :controller => 'host', :action => 'destroy',
      :node_code => 'nodecode', :hostname => 'hostname'
    }

    assert_requires_login {
      get :destroy, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }
    }

    assert_not_nil nodes(:first).hosts.find_by_name(hosts(:first).name)

    assert_accepts_login(:arthur) {
      get :destroy, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }

      assert_redirected_to(:controller => 'node',
                           :action => 'show',
                           :code => nodes(:first).code)

      # TODO: figure out how to get an action from another controller
      get :show, {
        :node_code => nodes(:second).code, :hostname => hosts(:second).name
      }
    }

    assert_nil nodes(:first).hosts.find_by_name(hosts(:first).name)
  end
end
