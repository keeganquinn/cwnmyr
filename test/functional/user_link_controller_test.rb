#--
# $Id: user_link_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'user_link_controller'

# Re-raise errors caught by the controller.
class UserLinkController; def rescue_action(e) raise e end; end

class UserLinkControllerTest < ActionController::TestCase
  fixtures :users, :user_links

  def setup
    @controller = UserLinkController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'user_link', {
      :controller => 'user_link', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'user_link/show/1', {
      :controller => 'user_link', :action => 'show', :id => '1'
    }

    assert_requires_login { get :show, :id => 1 }

    assert_accepts_login(:arthur) {
      get :show, :id => 1

      assert_template 'show'
      assert_not_nil assigns(:user_link)
      assert assigns(:user_link).valid?
    }
  end

  def test_new
    assert_routing 'user_link/new', {
      :controller => 'user_link', :action => 'new'
    }

    assert_requires_login { get :new }

    num_user_links = UserLink.count

    assert_accepts_login(:arthur) {
      get :new

      assert_template 'new'
      assert_not_nil assigns(:user_link)

      post :new, :user_link => {
        :name => 'Functional test',
        :application => 'test',
        :data => 'http://localhost/test',
        :active => true
      }

      assert_redirected_to :controller => 'welcome'

      get :show, :id => 3
    }

    assert_equal num_user_links + 1, UserLink.count
  end

  def test_edit
    assert_routing 'user_link/edit/1', {
      :controller => 'user_link', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:quentin) {
      get :edit, :id => 1

      assert_template 'edit'
      assert_not_nil assigns(:user_link)
      assert assigns(:user_link).valid?

      post :edit, :id => 1

      assert_redirected_to :action => 'show', :id => 1

      get :show, :id => 1
    }
  end

  def test_destroy
    assert_routing 'user_link/destroy/1', {
      :controller => 'user_link', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy }

    assert_not_nil UserLink.find(1)

    assert_accepts_login(:quentin) {
      post :destroy, :id => 1

      assert_redirected_to :controller => 'welcome'

      # TODO: figure out how to get an action from another controller
      get :show, :id => 2
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      UserLink.find(1)
    }
  end
end
