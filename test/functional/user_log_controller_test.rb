#--
# $Id: user_log_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'user_log_controller'

# Re-raise errors caught by the controller.
class UserLogController; def rescue_action(e) raise e end; end

class UserLogControllerTest < ActionController::TestCase
  fixtures :users, :user_logs

  def setup
    @controller = UserLogController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'user_log', {
      :controller => 'user_log', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'user_log/show/1', {
      :controller => 'user_log', :action => 'show', :id => '1'
    }

    get :show, :id => user_logs(:first).id

    assert_template 'show'
    assert_not_nil assigns(:user_log)
    assert assigns(:user_log).valid?
  end

  def test_new
    assert_routing 'user_log/new', {
      :controller => 'user_log', :action => 'new'
    }

    assert_requires_login { get :new }

    num_user_logs = UserLog.count

    assert_accepts_login(:arthur) {
      get :new

      assert_template 'new'
      assert_not_nil assigns(:user_log)

      post :new, :user_log => {
        :subject => 'Functional test',
        :body => 'Just testing.'
      }

      assert_redirected_to :controller => 'welcome'

      get :show, :id => 3
    }

    assert_equal num_user_logs + 1, UserLog.count
  end

  def test_edit
    assert_routing 'user_log/edit/1', {
      :controller => 'user_log', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit, :id => user_logs(:first).id }

    assert_accepts_login(:quentin) {
      get :edit, :id => user_logs(:first).id

      assert_template 'edit'
      assert_not_nil assigns(:user_log)
      assert assigns(:user_log).valid?

      post :edit, :id => user_logs(:first).id

      assert_redirected_to :action => 'show', :id => user_logs(:first).id

      get :show, :id => user_logs(:first).id
    }
  end

  def test_destroy
    assert_routing 'user_log/destroy/1', {
      :controller => 'user_log', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy, :id => user_logs(:first).id }

    assert_not_nil UserLog.find(user_logs(:first).id)

    assert_accepts_login(:quentin) {
      get :destroy, :id => user_logs(:first).id

      assert_redirected_to :controller => 'welcome'

      # TODO: figure out how to get an action from another controller
      get :show, :id => user_logs(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      UserLog.find(user_logs(:first).id)
    }
  end
end
