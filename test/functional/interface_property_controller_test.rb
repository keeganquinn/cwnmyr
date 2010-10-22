#--
# $Id: interface_property_controller_test.rb 2753 2006-06-16 08:57:06Z keegan $
# Copyright 2006 Keegan Quinn
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
require 'interface_property_controller'

# Re-raise errors caught by the controller.
class InterfacePropertyController; def rescue_action(e) raise e end; end

class InterfacePropertyControllerTest < ActionController::TestCase
  fixtures :zones, :users
  fixtures :interfaces, :interface_properties, :interface_property_types

  def setup
    @controller = InterfacePropertyController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'interface_property', {
      :controller => 'interface_property', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'interface_property/show/1', {
      :controller => 'interface_property', :action => 'show', :id => '1'
    }

    get :show, :id => interface_properties(:first).id

    assert_template 'show'
    assert_not_nil assigns(:interface_property)
    assert assigns(:interface_property).valid?
  end

  def test_new
    assert_routing 'interface_property/new', {
      :controller => 'interface_property', :action => 'new'
    }

    assert_requires_login { get :new }

    num_interface_properties = InterfaceProperty.count

    assert_accepts_login(:arthur) {
      get :new, :interface_id => interfaces(:first).id

      assert_template 'new'
      assert_not_nil assigns(:interface_property)

      post :new, {
        :interface_id => interfaces(:first).id,
        :interface_property => {
          :interface_property_type_id => interface_property_types(:another).id,
          :value => 'Test value'
        }
      }

      assert_redirected_to(:controller => 'interface',
                           :action => 'show',
                           :node_code => interfaces(:first).host.node.code,
                           :hostname => interfaces(:first).host.name,
                           :code => interfaces(:first).code)

      get :show, :id => interface_properties(:first).id
    }

    assert_equal num_interface_properties + 1, InterfaceProperty.count
  end

  def test_edit
    assert_routing 'interface_property/edit/1', {
      :controller => 'interface_property', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => interface_properties(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:interface_property)
      assert assigns(:interface_property).valid?

      post :edit, :id => interface_properties(:first).id

      assert_redirected_to(:action => 'show',
                           :id => interface_properties(:first).id)

      get :show, :id => interface_properties(:first).id
    }
  end

  def test_destroy
    assert_routing 'interface_property/destroy/1', {
      :controller => 'interface_property', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy }

    assert_not_nil InterfaceProperty.find(interface_properties(:first).id)

    assert_accepts_login(:arthur) {
      post :destroy, :id => interface_properties(:first).id

      assert_redirected_to(:controller => 'interface',
                           :action => 'show',
                           :node_code => interfaces(:first).host.node.code,
                           :hostname => interfaces(:first).host.name,
                           :code => interfaces(:first).code)

      # TODO: figure out how to get an action from another controller
      get :show, :id => interface_properties(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      InterfaceProperty.find(interface_properties(:first).id)
    }
  end
end
