#--
# $Id: host_log_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'host_log_controller'

# Re-raise errors caught by the controller.
class HostLogController; def rescue_action(e) raise e end; end

class HostLogControllerTest < ActionController::TestCase
  fixtures :zones, :hosts, :host_logs, :users

  def setup
    @controller = HostLogController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'host_log', {
      :controller => 'host_log', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'host_log/show/1', {
      :controller => 'host_log', :action => 'show', :id => '1'
    }

    get :show, :id => host_logs(:first).id

    assert_template 'show'
    assert_not_nil assigns(:host_log)
    assert assigns(:host_log).valid?
  end

  def test_new
    assert_routing 'host_log/new', {
      :controller => 'host_log', :action => 'new'
    }

    assert_requires_login { get :new, :host_id => hosts(:first).id }

    num_host_logs = HostLog.count

    assert_accepts_login(:arthur) {
      get :new, :host_id => hosts(:first).id

      assert_template 'new'
      assert_not_nil assigns(:host_log)

      post :new, {
        :host_id => hosts(:first).id,
        :host_log => {
          :subject => 'Testing',
          :body => 'Just testing',
          :active => true
        }
      }

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => hosts(:first).node.code,
                           :hostname => hosts(:first).name)

      get :show, :id => host_logs(:first).id
    }

    assert_equal num_host_logs + 1, HostLog.count
  end

  def test_edit
    assert_routing 'host_log/edit/1', {
      :controller => 'host_log', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => host_logs(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:host_log)
      assert assigns(:host_log).valid?

      post :edit, :id => host_logs(:first).id

      assert_redirected_to :action => 'show', :id => host_logs(:first).id

      get :show, :id => host_logs(:first).id
    }
  end

  def test_destroy
    assert_routing 'host_log/destroy/1', {
      :controller => 'host_log', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy, :id => host_logs(:first).id }

    assert_not_nil HostLog.find(host_logs(:first).id)

    assert_accepts_login(:arthur) {
      get :destroy, :id => host_logs(:first).id

      assert_redirected_to(:controller => 'host',
                           :action => 'show',
                           :node_code => host_logs(:first).host.node.code,
                           :hostname => host_logs(:first).host.name)

      # TODO: figure out how to get an action from another controller
      get :show, :id => host_logs(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      HostLog.find(host_logs(:first).id)
    }
  end
end
