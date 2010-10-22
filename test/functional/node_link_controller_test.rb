#--
# $Id: node_link_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'node_link_controller'

# Re-raise errors caught by the controller.
class NodeLinkController; def rescue_action(e) raise e end; end

class NodeLinkControllerTest < ActionController::TestCase
  fixtures :nodes, :node_links, :users

  def setup
    @controller = NodeLinkController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'node_link', {
      :controller => 'node_link', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'node_link/show/1', {
      :controller => 'node_link', :action => 'show', :id => '1'
    }

    assert_requires_login { get :show, :id => node_links(:first).id }

    assert_accepts_login(:arthur) {
      get :show, :id => node_links(:first).id

      assert_template 'show'
      assert_not_nil assigns(:node_link)
      assert assigns(:node_link).valid?
    }
  end

  def test_new
    assert_routing 'node_link/new', {
      :controller => 'node_link', :action => 'new'
    }

    assert_requires_login { get :new }

    num_node_links = NodeLink.count

    assert_accepts_login(:arthur) {
      get :new, :node_id => nodes(:first).id

      assert_template 'new'
      assert_not_nil assigns(:node_link)

      post :new, {
        :node_id => nodes(:first).id,
        :node_link => {
          :name => 'Testing',
          :application => 'webpage',
          :data => 'http://localhost/test',
          :active => true
        }
      }

      assert_redirected_to(:controller => 'node',
                           :action => 'show',
                           :code => nodes(:first).code)

      get :show, :id => nodes(:first).id
    }

    assert_equal num_node_links + 1, NodeLink.count
  end

  def test_edit
    assert_routing 'node_link/edit/1', {
      :controller => 'node_link', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit, :id => node_links(:first).id }

    assert_accepts_login(:arthur) {
      get :edit, :id => node_links(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:node_link)
      assert assigns(:node_link).valid?

      post :edit, :id => node_links(:first).id

      assert_redirected_to :action => 'show', :id => node_links(:first).id

      get :show, :id => node_links(:first).id
    }
  end

  def test_destroy
    assert_routing 'node_link/destroy/1', {
      :controller => 'node_link', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy, :id => node_links(:first).id }

    assert_not_nil NodeLink.find(node_links(:first).id)

    assert_accepts_login(:arthur) {
      get :destroy, :id => node_links(:first).id

      assert_redirected_to(:controller => 'node',
                           :action => 'show',
                           :code => node_links(:first).node.code)

      # TODO: figure out how to get an action from another controller
      get :show, :id => node_links(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      NodeLink.find(node_links(:first).id)
    }
  end
end
