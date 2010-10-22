#--
# $Id: interface_point_controller_test.rb 2737 2006-06-10 06:22:30Z keegan $
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
require 'interface_point_controller'

# Re-raise errors caught by the controller.
class InterfacePointController; def rescue_action(e) raise e end; end

class InterfacePointControllerTest < ActionController::TestCase
  fixtures :zones, :interfaces, :interface_points, :users

  def setup
    @controller = InterfacePointController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'interface_point', {
      :controller => 'interface_point', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'interface_point/show/1', {
      :controller => 'interface_point', :action => 'show', :id => '1'
    }

    assert_requires_login { get :show, :id => 1 }

    assert_accepts_login(:arthur) {
      get :show, :id => 1

      assert_template 'show'
      assert_not_nil assigns(:interface_point)
      assert assigns(:interface_point).valid?
    }
  end

  def test_new
    assert_routing 'interface_point/new', {
      :controller => 'interface_point', :action => 'new'
    }

    assert_requires_login { get :new }

    num_interface_points = InterfacePoint.count

    assert_accepts_login(:arthur) {
      get :new, :interface_id => interfaces(:first).id

      assert_template 'new'
      assert_not_nil assigns(:interface_point)

      post :new, {
        :interface_id => interfaces(:first).id,
        :interface_point => {
          :latitude => 1.0,
          :longitude => 1.0,
          :height => 1.0,
          :error => 1.0,
          :description => 'Functional test'
        }
      }

      assert_redirected_to(:controller => 'interface',
                           :action => 'show',
                           :node_code => interfaces(:first).host.node.code,
                           :hostname => interfaces(:first).host.name,
                           :code => interfaces(:first).code)

      get :show, :id => 3
    }

    assert_equal num_interface_points + 1, InterfacePoint.count
  end

  def test_edit
    assert_routing 'interface_point/edit/1', {
      :controller => 'interface_point', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => 1

      assert_template 'edit'
      assert_not_nil assigns(:interface_point)
      assert assigns(:interface_point).valid?

      post :edit, :id => 1

      assert_redirected_to :action => 'show', :id => 1

      get :show, :id => 1
    }
  end

  def test_destroy
    assert_routing 'interface_point/destroy/1', {
      :controller => 'interface_point', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy, :id => interface_points(:first).id }

    assert_not_nil InterfacePoint.find(interface_points(:first).id)

    assert_accepts_login(:arthur) {
      post :destroy, :id => interface_points(:first).id

      assert_redirected_to(:controller => 'interface',
                           :action => 'show',
                           :node_code => interface_points(:first).interface.host.node.code,
                           :hostname => interface_points(:first).interface.host.name,
                           :code => interface_points(:first).interface.code)

      # TODO: figure out how to get an action from another controller
      get :show, :id => interface_points(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      InterfacePoint.find(interface_points(:first).id)
    }
  end
end
