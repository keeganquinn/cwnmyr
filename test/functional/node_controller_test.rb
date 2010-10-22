#--
# $Id: node_controller_test.rb 2746 2006-06-11 01:36:32Z keegan $
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
require 'node_controller'

# Re-raise errors caught by the controller.
class NodeController; def rescue_action(e) raise e end; end

class NodeControllerTest < ActionController::TestCase
  fixtures :nodes, :statuses, :users, :zones

  def setup
    @controller = NodeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'node', { :controller => 'node', :action => 'index' }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'node/show/code', {
      :controller => 'node', :action => 'show', :code => 'code'
    }

    get :show, :code => nodes(:second).code

    assert_template 'show'
    assert_not_nil assigns(:node)
    assert assigns(:node).valid?

    assert_kind_of(String, assigns(:page_heading))
    assert_kind_of(String, assigns(:head_content))
    assert_kind_of(GMap, assigns(:map))
  end

  def test_new
    assert_routing 'node/new', { :controller => 'node', :action => 'new' }

    assert_requires_login { get :new, :zone_code => zones(:first).code }

    num_nodes = Node.count

    assert_accepts_login(:arthur) {
      get :new, :zone_code => zones(:first).code

      assert_template 'new'
      assert_not_nil assigns(:node)

      post :new, {
        :zone_code => zones(:first).code,
        :node => {
          :status_id => statuses(:first).id,
          :code => 'testing',
          :name => 'Testing node'
        }
      }

      assert_redirected_to(:controller => 'zone',
                           :action => 'show',
                           :code => zones(:first).code)

      get :show, :code => 'testing'
    }

    assert_equal num_nodes + 1, Node.count
  end

  def test_edit
    assert_routing 'node/edit/code', {
      :controller => 'node', :action => 'edit', :code => 'code'
    }

    assert_requires_login { get :edit, :code => nodes(:first).code }

    assert_accepts_login(:arthur) {
      get :edit, :code => nodes(:first).code

      assert_template 'edit'
      assert_not_nil assigns(:node)
      assert assigns(:node).valid?

      post :edit, :code => nodes(:first).code

      assert_redirected_to :action => 'show', :code => nodes(:first).code

      get :show, :code => nodes(:first).code
    }
  end

  def test_destroy
    assert_routing 'node/destroy/code', {
      :controller => 'node', :action => 'destroy', :code => 'code'
    }

    assert_requires_login { get :destroy, :code => nodes(:first).code }

    assert_not_nil Node.find_by_code(nodes(:first).code)

    assert_accepts_login(:arthur) {
      get :destroy, :code => nodes(:first).code

      assert_redirected_to(:controller => 'zone',
                           :action => 'show',
                           :code => zones(:first).code)

      # TODO: figure out how to get an action from another controller
      get :show, :code => nodes(:second).code
    }

    assert_nil Node.find_by_code(nodes(:first).code)
  end
end
