#--
# $Id: host_type_comment_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'host_type_comment_controller'

# Re-raise errors caught by the controller.
class HostTypeCommentController; def rescue_action(e) raise e end; end

class HostTypeCommentControllerTest < ActionController::TestCase
  fixtures :host_types, :host_type_comments, :users

  def setup
    @controller = HostTypeCommentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'host_type_comment', {
      :controller => 'host_type_comment', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'host_type_comment/show/1', {
      :controller => 'host_type_comment', :action => 'show', :id => '1'
    }

    get :show, :id => host_type_comments(:first).id

    assert_template 'show'
    assert_not_nil assigns(:host_type_comment)
    assert assigns(:host_type_comment).valid?
  end

  def test_new
    assert_routing 'host_type_comment/new', {
      :controller => 'host_type_comment', :action => 'new'
    }

    assert_requires_login { get :new }

    num_host_type_comments = HostTypeComment.count

    assert_accepts_login(:arthur) {
      get :new, :host_type_id => host_types(:first).id

      assert_template 'new'
      assert_not_nil assigns(:host_type_comment)

      post :new, {
        :host_type_id => host_types(:first).id,
        :host_type_comment => {
          :subject => 'Testing',
          :body => 'Just testing',
          :rating => 0,
          :active => true
        }
      }

      assert_redirected_to(:controller => 'host_type',
                           :action => 'show',
                           :code => host_type_comments(:first).host_type.code)

      get :show, :id => host_type_comments(:first).id
    }

    assert_equal num_host_type_comments + 1, HostTypeComment.count
  end

  def test_edit
    assert_routing 'host_type_comment/edit/1', {
      :controller => 'host_type_comment', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => host_type_comments(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:host_type_comment)
      assert assigns(:host_type_comment).valid?

      post :edit, :id => host_type_comments(:first).id

      assert_redirected_to :action => 'show', :id => host_type_comments(:first).id

      get :show, :id => host_type_comments(:first).id
    }
  end

  def test_destroy
    assert_routing 'host_type_comment/destroy/1', {
      :controller => 'host_type_comment', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy }

    assert_not_nil HostTypeComment.find(host_type_comments(:first).id)

    assert_accepts_login(:arthur) {
      post :destroy, :id => host_type_comments(:first).id

      assert_redirected_to(:controller => 'host_type',
                           :action => 'show',
                           :code => host_type_comments(:first).host_type.code)

      # TODO: figure out how to get an action from another controller
      get :show, :id => host_type_comments(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      HostTypeComment.find(host_type_comments(:first).id)
    }
  end
end
