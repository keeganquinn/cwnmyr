#--
# $Id: node_comment_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'node_comment_controller'

# Re-raise errors caught by the controller.
class NodeCommentController; def rescue_action(e) raise e end; end

class NodeCommentControllerTest < ActionController::TestCase
  fixtures :zones, :nodes, :node_comments, :users

  def setup
    @controller = NodeCommentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'node_comment', {
      :controller => 'node_comment', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'node_comment/show/1', {
      :controller => 'node_comment', :action => 'show', :id => '1'
    }

    get :show, :id => node_comments(:first).id

    assert_template 'show'
    assert_not_nil assigns(:node_comment)
    assert assigns(:node_comment).valid?
  end

  def test_new
    assert_routing 'node_comment/new', {
      :controller => 'node_comment', :action => 'new'
    }

    assert_requires_login { get :new }

    num_node_comments = NodeComment.count

    assert_accepts_login(:arthur) {
      get :new, :node_id => nodes(:first).id

      assert_template 'new'
      assert_not_nil assigns(:node_comment)

      post :new, {
        :node_id => nodes(:first).id,
        :node_comment => {
          :subject => 'Testing',
          :body => 'Just testing',
          :rating => 0,
          :active => true
        }
      }

      assert_redirected_to(:controller => 'node',
                           :action => 'show',
                           :code => node_comments(:first).node.code)

      get :show, :id => node_comments(:first).id
    }

    assert_equal num_node_comments + 1, NodeComment.count
  end

  def test_edit
    assert_routing 'node_comment/edit/1', {
      :controller => 'node_comment', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => node_comments(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:node_comment)
      assert assigns(:node_comment).valid?

      post :edit, :id => node_comments(:first).id

      assert_redirected_to :action => 'show', :id => node_comments(:first).id

      get :show, :id => node_comments(:first).id
    }
  end

  def test_destroy
    assert_routing 'node_comment/destroy/1', {
      :controller => 'node_comment', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy }

    assert_not_nil NodeComment.find(node_comments(:first).id)

    assert_accepts_login(:arthur) {
      post :destroy, :id => node_comments(:first).id

      assert_redirected_to(:controller => 'node',
                           :action => 'show',
                           :code => node_comments(:first).node.code)

      # TODO: figure out how to get an action from another controller
      get :show, :id => node_comments(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      NodeComment.find(node_comments(:first).id)
    }
  end
end
