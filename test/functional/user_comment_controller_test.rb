#--
# $Id: user_comment_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'user_comment_controller'

# Re-raise errors caught by the controller.
class UserCommentController; def rescue_action(e) raise e end; end

class UserCommentControllerTest < ActionController::TestCase
  fixtures :users, :user_comments

  def setup
    @controller = UserCommentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'user_comment', {
      :controller => 'user_comment', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'user_comment/show/1', {
      :controller => 'user_comment', :action => 'show', :id => '1'
    }

    get :show, :id => user_comments(:first).id

    assert_template 'show'
    assert_not_nil assigns(:user_comment)
    assert assigns(:user_comment).valid?
  end

  def test_new
    assert_routing 'user_comment/new', {
      :controller => 'user_comment', :action => 'new'
    }

    assert_requires_login { get :new, :user_id => users(:quentin).id }

    num_user_comments = UserComment.count

    assert_accepts_login(:arthur) {
      get :new, :user_id => users(:quentin).id

      assert_template 'new'
      assert_not_nil assigns(:user_comment)

      post :new, {
        :user_id => users(:quentin).id,
        :user_comment => {
          :subject => 'Functional test',
          :body => 'Just testing.'
        }
      }

      assert_redirected_to(:controller => 'user',
                           :action => 'show',
                           :login => users(:quentin).login)

      get :show, :id => user_comments(:first).id
    }

    assert_equal num_user_comments + 1, UserComment.count
  end

  def test_edit
    assert_routing 'user_comment/edit/1', {
      :controller => 'user_comment', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit, :id => user_comments(:first).id }

    assert_accepts_login(:arthur) {
      get :edit, :id => user_comments(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:user_comment)
      assert assigns(:user_comment).valid?

      post :edit, :id => user_comments(:first).id

      assert_redirected_to :action => 'show', :id => user_comments(:first).id

      get :edit, :id => user_comments(:first).id
    }
  end

  def test_destroy
    assert_routing 'user_comment/destroy/1', {
      :controller => 'user_comment', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy, :id => user_comments(:first).id }

    assert_not_nil UserComment.find(user_comments(:first).id)

    assert_accepts_login(:arthur) {
      get :destroy, :id => user_comments(:first).id

      assert_redirected_to :controller => 'welcome'

      # TODO: figure out how to get an action from another controller
      get :show, :id => user_comments(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      UserComment.find(user_comments(:first).id)
    }
  end
end
