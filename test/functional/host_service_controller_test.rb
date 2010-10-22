#--
# $Id: host_service_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'host_service_controller'

# Re-raise errors caught by the controller.
class HostServiceController; def rescue_action(e) raise e end; end

class HostServiceControllerTest < ActionController::TestCase
  fixtures :zones, :hosts, :host_services, :services, :users

  def setup
    @controller = HostServiceController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'host_service', {
      :controller => 'host_service', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'host_service/show/1', {
      :controller => 'host_service', :action => 'show', :id => '1'
    }

    get :show, :id => host_services(:first).id

    assert_template 'show'
    assert_not_nil assigns(:host_service)
    assert assigns(:host_service).valid?
  end

  def test_new
    assert_routing 'host_service/new', {
      :controller => 'host_service', :action => 'new'
    }

    assert_requires_login { get :new }

    num_host_services = HostService.count

    assert_accepts_login(:arthur) {
      get :new, :host_id => hosts(:first).id

      assert_template 'new'
      assert_not_nil assigns(:host_service)

      post :new, {
        :host_id => hosts(:first).id,
        :host_service => {
          :service_id => services(:second).id
        }
      }

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => hosts(:first).node.code,
                           :hostname => hosts(:first).name)

      get :show, :id => host_services(:first).id
    }

    assert_equal num_host_services + 1, HostService.count
  end

  def test_edit
    assert_routing 'host_service/edit/1', {
      :controller => 'host_service', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit, :id => host_services(:first).id }

    assert_accepts_login(:arthur) {
      get :edit, :id => host_services(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:host_service)
      assert assigns(:host_service).valid?

      post :edit, :id => host_services(:first).id

      assert_redirected_to :action => 'show', :id => host_services(:first).id

      get :show, :id => host_services(:first).id
    }
  end

  def test_destroy
    assert_routing 'host_service/destroy/1', {
      :controller => 'host_service', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy }

    assert_not_nil HostService.find(host_services(:first).id)

    assert_accepts_login(:arthur) {
      post :destroy, :id => host_services(:first).id

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => host_services(:first).host.node.code,
                           :hostname => host_services(:first).host.name)

      # TODO: figure out how to get an action from another controller
      get :show, :id => host_services(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      HostService.find(host_services(:first).id)
    }
  end
end
