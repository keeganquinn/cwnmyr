#--
# $Id: node_maintainer_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'node_maintainer_controller'

# Re-raise errors caught by the controller.
class NodeMaintainerController; def rescue_action(e) raise e end; end

class NodeMaintainerControllerTest < ActionController::TestCase
  fixtures :nodes, :node_maintainers, :users

  def setup
    @controller = NodeMaintainerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'node_maintainer', {
      :controller => 'node_maintainer', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'node_maintainer/show/1', {
      :controller => 'node_maintainer', :action => 'show', :id => '1'
    }

    get :show, :id => 1

    assert_template 'show'
    assert_not_nil assigns(:node_maintainer)
    assert assigns(:node_maintainer).valid?
  end

  def test_new
    assert_routing 'node_maintainer/new', {
      :controller => 'node_maintainer', :action => 'new'
    }

    assert_requires_login { get :new }

    num_node_maintainers = NodeMaintainer.count

    assert_accepts_login(:arthur) {
      get :new, :node_id => nodes(:first).id

      assert_template 'new'
      assert_not_nil assigns(:node_maintainer)

      post :new, {
        :node_id => nodes(:first).id,
        :node_maintainer => {
          :user_id => users(:arthur).id,
          :description => 'Just a test'
        }
      }

      assert_redirected_to(:controller => 'node',
                           :action => 'show',
                           :code => nodes(:first).code)

      get :show, :id => 3
    }

    assert_equal num_node_maintainers + 1, NodeMaintainer.count
  end

  def test_edit
    assert_routing 'node_maintainer/edit/1', {
      :controller => 'node_maintainer', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => 1

      assert_template 'edit'
      assert_not_nil assigns(:node_maintainer)
      assert assigns(:node_maintainer).valid?

      post :edit, :id => 1

      assert_redirected_to :action => 'show', :id => 1

      get :show, :id => 1
    }
  end

  def test_destroy
    assert_routing 'node_maintainer/destroy/1', {
      :controller => 'node_maintainer', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy, :id => node_maintainers(:first).id }

    assert_not_nil NodeMaintainer.find(node_maintainers(:first).id)

    assert_accepts_login(:arthur) {
      get :destroy, :id => node_maintainers(:first).id

      assert_redirected_to(:controller => 'node',
                           :action => 'show',
                           :code => nodes(:first).code)

      # TODO: figure out how to get an action from another controller
      get :show, :id => node_maintainers(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      NodeMaintainer.find(node_maintainers(:first).id)
    }
  end
end
