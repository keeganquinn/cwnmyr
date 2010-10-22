#--
# $Id: host_property_controller_test.rb 2753 2006-06-16 08:57:06Z keegan $
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
require 'host_property_controller'

# Re-raise errors caught by the controller.
class HostPropertyController; def rescue_action(e) raise e end; end

class HostPropertyControllerTest < ActionController::TestCase
  fixtures :zones, :hosts, :host_properties, :host_property_types, :users

  def setup
    @controller = HostPropertyController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'host_property', {
      :controller => 'host_property', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'host_property/show/1', {
      :controller => 'host_property', :action => 'show', :id => '1'
    }

    get :show, :id => host_properties(:first).id

    assert_template 'show'
    assert_not_nil assigns(:host_property)
    assert assigns(:host_property).valid?
  end

  def test_new
    assert_routing 'host_property/new', {
      :controller => 'host_property', :action => 'new'
    }

    assert_requires_login { get :new }

    num_host_properties = HostProperty.count

    assert_accepts_login(:arthur) {
      get :new, :host_id => hosts(:first).id

      assert_template 'new'
      assert_not_nil assigns(:host_property)

      post :new, {
        :host_id => hosts(:first).id,
        :host_property => {
          :host_property_type_id => host_property_types(:another).id,
          :value => 'Test value'
        }
      }

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => hosts(:first).node.code,
                           :hostname => hosts(:first).name)

      get :show, :id => host_properties(:first).id
    }

    assert_equal num_host_properties + 1, HostProperty.count
  end

  def test_edit
    assert_routing 'host_property/edit/1', {
      :controller => 'host_property', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => host_properties(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:host_property)
      assert assigns(:host_property).valid?

      post :edit, :id => host_properties(:first).id

      assert_redirected_to :action => 'show', :id => host_properties(:first).id

      get :show, :id => host_properties(:first).id
    }
  end

  def test_destroy
    assert_routing 'host_property/destroy/1', {
      :controller => 'host_property', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy }

    assert_not_nil HostProperty.find(host_properties(:first).id)

    assert_accepts_login(:arthur) {
      post :destroy, :id => host_properties(:first).id

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => hosts(:first).node.code,
                           :hostname => hosts(:first).name)

      # TODO: figure out how to get an action from another controller
      get :show, :id => host_properties(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      HostProperty.find(host_properties(:first).id)
    }
  end
end
