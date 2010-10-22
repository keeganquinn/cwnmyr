#--
# $Id: interface_controller_test.rb 2746 2006-06-11 01:36:32Z keegan $
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
require 'interface_controller'

# Re-raise errors caught by the controller.
class InterfaceController; def rescue_action(e) raise e end; end

class InterfaceControllerTest < ActionController::TestCase
  fixtures :hosts, :interfaces, :interface_points, :interface_types
  fixtures :zones, :nodes, :statuses, :users

  def setup
    @controller = InterfaceController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'interface', {
      :controller => 'interface', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'interface/show/nodecode/hostname/code', {
      :controller => 'interface', :action => 'show',
      :node_code => 'nodecode', :hostname => 'hostname', :code => 'code'
    }

    get :show, {
      :node_code => nodes(:first).code, :hostname => hosts(:first).name,
      :code => interfaces(:first).code
    }

    assert_template 'show'
    assert_not_nil assigns(:interface)
    assert assigns(:interface).valid?
  end

  def test_map
    assert_routing 'interface/map/1', {
      :controller => 'interface', :action => 'map', :id => '1'
    }

    get :map, :id => interfaces(:second).id
    assert_template 'map'
    assert_not_nil assigns(:interface)
    assert assigns(:interface).valid?

    assert_kind_of(String, assigns(:page_heading))
    assert_kind_of(GMap, assigns(:map))
  end

  def test_new
    assert_routing 'interface/new/nodecode/hostname', {
      :controller => 'interface', :action => 'new',
      :node_code => 'nodecode', :hostname => 'hostname'
    }

    assert_requires_login {
      get :new, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }
    }

    num_interfaces = Interface.count

    assert_accepts_login(:arthur) {
      get :new, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name
      }

      assert_template 'new'
      assert_not_nil assigns(:interface)

      post :new, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :interface => {
          :interface_type_id => interface_types(:first).id,
          :status_id => statuses(:first).id,
          :code => 'functional_test',
          :ipv4_masked_address => '192.168.168.1/24',
          :name => 'Functional test'
        }
      }

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => nodes(:first).code,
                           :hostname => hosts(:first).name)

      get :show, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :code => 'functional_test'
      }
    }

    assert_equal num_interfaces + 1, Interface.count
  end

  def test_edit
    assert_routing 'interface/edit/nodecode/hostname/code', {
      :controller => 'interface', :action => 'edit',
      :node_code => 'nodecode', :hostname => 'hostname', :code => 'code'
    }

    assert_requires_login {
      get :edit, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :code => interfaces(:first).code
      }
    }

    assert_accepts_login(:arthur) {
      get :edit, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :code => interfaces(:first).code
      }

      assert_template 'edit'
      assert_not_nil assigns(:interface)
      assert assigns(:interface).valid?

      post :edit, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :code => interfaces(:first).code
      }

      assert_redirected_to(:action => 'show',
                           :node_code => nodes(:first).code,
                           :hostname => hosts(:first).name,
                           :code => interfaces(:first).code)

      get :show, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :code => interfaces(:first).code
      }
    }
  end

  def test_destroy
    assert_routing 'interface/destroy/nodecode/hostname/code', {
      :controller => 'interface', :action => 'destroy',
      :node_code => 'nodecode', :hostname => 'hostname', :code => 'code'
    }

    assert_requires_login {
      get :destroy, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :code => interfaces(:first).code
      }
    }

    assert_not_nil hosts(:first).interfaces.find_by_code(interfaces(:first).code)

    assert_accepts_login(:arthur) {
      get :destroy, {
        :node_code => nodes(:first).code, :hostname => hosts(:first).name,
        :code => interfaces(:first).code
      }

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => nodes(:first).code,
                           :hostname => hosts(:first).name)

      # TODO: figure out how to get an action from another controller
      get :show, {
        :node_code => nodes(:second).code, :hostname => hosts(:second).name,
        :code => interfaces(:second).code
      }
    }

    assert_nil hosts(:first).interfaces.find_by_code(interfaces(:first).code)
  end

  def test_wireless
    # TODO implement this test
  end
end
