#--
# $Id: users_controller_test.rb 765 2008-05-12 22:22:48Z keegan $
# Copyright 2004-2008 Keegan Quinn
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

class UsersControllerTest < ActionController::TestCase
  fixtures :roles, :roles_users, :users

  def setup
    ActionMailer::Base.deliveries.clear
  end

  def test_index_routing
    assert_recognizes(
      { :controller => 'users', :action => 'index' },
      'users'
    )
  end

  def test_index
    get :index
    assert_template 'index'

    assert_kind_of Array, assigns(:users)
  end

  def test_index_xml
    get_with :xml, :index
    assert_responded_with :xml

    assert_kind_of Array, assigns(:users)
  end

  def test_show_routing
    assert_recognizes(
      { :controller => 'users', :action => 'show', :id => 'someone' },
      'users/someone'
    )
  end

  def test_show_not_found
    get :show
    assert_redirected_to users_path
  end

  def test_show
    get :show, :id => users(:arthur).to_param
    assert_template 'show'

    assert assigns(:user).valid?
  end

  def test_show_xml
    get_with :xml, :show, :id => users(:arthur).to_param
    assert_responded_with :xml

    assert assigns(:user).valid?
  end

  def test_new_routing
    assert_recognizes(
      { :controller => 'users', :action => 'new' },
      'users/new'
    )
  end

  def test_new
    get :new
    assert_template 'new'

    assert_kind_of User, assigns(:user)
  end

  def test_new_authorized
    login_as :quentin

    get :new
    assert_redirected_to welcome_path
  end

  def test_edit_routing
    assert_recognizes(
      { :controller => 'users', :action => 'edit', :id => 'someone' },
      'users/someone/edit'
    )
  end

  def test_edit_authorization
    get :edit
    assert_redirected_to users_path
  end

  def test_edit_unauthorized
    login_as :quentin

    get :edit, :id => users(:arthur).to_param
    assert_redirected_to welcome_path
  end

  def test_edit
    login_as :arthur

    get :edit, :id => users(:arthur).to_param
    assert_template 'edit'

    assert assigns(:user).valid?
  end

  def test_create_routing
    assert_recognizes(
      { :controller => 'users', :action => 'create' },
      { :path => 'users', :method => 'post' }
    )
  end

  def test_create_invalid
    assert_no_difference 'User.count' do
      post :create, :user => {
        :login => 'quire',
        :password => 'quire',
        :password_confirmation => 'quire'
      }
    end
    assert_template 'new'

    assert_not_nil assigns(:user).errors.on(:email)
  end

  def test_create_invalid_xml
    assert_no_difference 'User.count' do
      post_with :xml, :create, :user => {
        :login => 'quire',
        :password => 'quire',
        :password_confirmation => 'quire'
      }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:user).errors.on(:email)
  end

  def test_create
    assert_no_emails

    assert_difference 'User.count' do
      post :create, :user => {
        :login => 'quire',
        :email => 'quire@example.com', 
        :password => 'quire',
        :password_confirmation => 'quire'
      }
    end
    assert_redirected_to welcome_path

    assert assigns(:user).valid?
    assert_emails 1
  end

  def test_create_xml
    assert_no_emails

    assert_difference 'User.count' do
      post_with :xml, :create, :user => {
        :login => 'quire',
        :email => 'quire@example.com', 
        :password => 'quire',
        :password_confirmation => 'quire'
      }
    end
    assert_response :created

    assert_emails 1
  end

  def test_update_routing
    assert_recognizes(
      { :controller => 'users', :action => 'update', :id => 'someone' },
      { :path => 'users/someone', :method => 'put' }
    )
  end

  def test_update_authorization
    put :update
    assert_redirected_to users_path
  end

  def test_update_unauthorized
    login_as :quentin

    assert_no_change users(:arthur), :updated_at do
      put :update, :id => users(:arthur).to_param
    end
    assert_redirected_to welcome_path
  end

  def test_update_not_found
    login_as :arthur

    put :update
    assert_redirected_to users_path
  end

  def test_update_invalid
    login_as :arthur

    assert_no_change users(:arthur), :updated_at do
      put :update, :id => users(:arthur).to_param,
        :user => { :email => 'a' }
    end
    assert_template 'edit'

    assert_not_nil assigns(:user).errors.on(:email)
  end

  def test_update_invalid_xml
    login_as :arthur

    assert_no_change users(:arthur), :updated_at do
      put_with :xml, :update, :id => users(:arthur).to_param,
        :user => { :email => 'a' }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:user).errors.on(:email)
  end

  def test_update
    login_as :arthur

    assert_no_change users(:arthur), :crypted_password do
      put :update, :id => users(:arthur).to_param,
        :user => { :displayname => 'something' }
    end
    assert_redirected_to user_path(users(:arthur))

    assert assigns(:user).valid?
  end

  def test_update_xml
    login_as :arthur

    assert_no_change users(:arthur), :crypted_password do
      put_with :xml, :update, :id => users(:arthur).to_param,
        :user => { :displayname => 'something' }
    end
    assert_response :ok

    assert assigns(:user).valid?
  end

  def test_update_password
    login_as :arthur

    put :update, :id => users(:arthur).to_param, :user => {
      :password => 'blarfloogle',
      :password_confirmation => 'blarfloogle'
    }
    assert_redirected_to user_path(users(:arthur))

    assert assigns(:user).valid?
  end

  def test_destroy_routing
    assert_recognizes(
      { :controller => 'users', :action => 'destroy', :id => 'someone' },
      { :path => 'users/someone', :method => 'delete' }
    )
  end

  def test_destroy_authorization
    delete :destroy
    assert_redirected_to users_path
  end

  def test_destroy_unauthorized
    login_as :quentin

    assert_no_difference 'User.count' do
      delete :destroy, :id => users(:arthur).to_param
    end
    assert_redirected_to welcome_path
  end

  def test_destroy_not_found
    login_as :arthur

    delete :destroy
    assert_redirected_to users_path
  end

  def test_destroy
    login_as :quentin

    assert_difference 'User.count', -1 do
      delete :destroy, :id => users(:quentin).to_param
    end
    assert_redirected_to welcome_path
  end

  def test_destroy_xml
    login_as :quentin

    assert_difference 'User.count', -1 do
      delete_with :xml, :destroy, :id => users(:quentin).to_param
    end
    assert_response :ok
  end

  def test_destroy_manager
    login_as :arthur

    assert_difference 'User.count', -1 do
      delete :destroy, :id => users(:quentin).to_param
    end
    assert_redirected_to users_path
  end

  def test_destroy_manager_xml
    login_as :arthur

    assert_difference 'User.count', -1 do
      delete_with :xml, :destroy, :id => users(:quentin).to_param
    end
    assert_response :ok
  end

  def test_comments_routing
    assert_recognizes(
      { :controller => 'users', :action => 'comments', :id => 'someone' },
      'users/someone/comments'
    )
  end

  def test_comments_invalid
    get :comments
    assert_redirected_to users_path
  end

  def test_comments
    get :comments, :id => users(:arthur).to_param
    assert_responded_with :xml
    assert_template 'comments'

    assert assigns(:user).valid?
  end

  def test_logs_routing
    assert_recognizes(
      { :controller => 'users', :action => 'logs', :id => 'someone' },
      'users/someone/logs'
    )
  end

  def test_logs_invalid
    get :logs
    assert_redirected_to users_path
  end

  def test_logs
    get :logs, :id => users(:arthur).to_param
    assert_responded_with :xml
    assert_template 'logs'

    assert assigns(:user).valid?
  end

  def test_foaf_routing
    assert_recognizes(
      { :controller => 'users', :action => 'foaf', :id => 'someone' },
      'users/someone/foaf'
    )
  end

  def test_foaf_invalid
    get :foaf
    assert_redirected_to users_path
  end

  def test_foaf
    get :foaf, :id => users(:arthur).to_param
    assert_responded_with :xml
    assert_template 'foaf'

    assert assigns(:user).valid?
  end

  def test_role_routing
    assert_recognizes(
      { :controller => 'users', :action => 'role', :id => 'someone' },
      'users/someone/role'
    )
  end

  def test_role_authorization
    post :role
    assert_redirected_to users_path
  end

  def test_role_invalid
    login_as :quentin

    post :role, :id => users(:arthur).to_param
    assert_redirected_to welcome_path
  end

  def test_role
    login_as :arthur

    assert_difference 'users(:quentin).roles.count' do
      post :role, :id => users(:quentin).to_param,
        :role => roles(:manage).to_param
      assert_redirected_to user_path(users(:quentin))
      assert_match 'push', flash[:notice]
    end

    assert assigns(:user).valid?
  end

  def test_role_xhr
    login_as :arthur

    assert_difference 'users(:quentin).roles.count' do
      xhr :post, :role, :id => users(:quentin).to_param,
        :role => roles(:manage).to_param
      assert_responded_with :js
      assert_template 'role'
    end

    assert assigns(:user).valid?
  end

  def test_role_xml
    login_as :arthur

    assert_difference 'users(:quentin).roles.count' do
      post_with :xml, :role, :id => users(:quentin).to_param,
        :role => roles(:manage).to_param
      assert_response :ok
      assert_match 'push', flash[:notice]
    end

    assert assigns(:user).valid?
  end

  def test_role_delete
    login_as :arthur

    assert_difference 'users(:quentin).roles.count', -1 do
      post :role, :id => users(:quentin).to_param,
        :role => users(:quentin).roles.first.to_param
      assert_redirected_to user_path(users(:quentin))
      assert_match 'delete', flash[:message]
    end

    assert assigns(:user).valid?
  end

  def test_role_delete_xhr
    login_as :arthur

    assert_difference 'users(:quentin).roles.count', -1 do
      xhr :post, :role, :id => users(:quentin).to_param,
        :role => users(:quentin).roles.first.to_param
      assert_responded_with :js
      assert_template 'role'
    end

    assert assigns(:user).valid?
  end

  def test_role_delete_xml
    login_as :arthur

    assert_difference 'users(:quentin).roles.count', -1 do
      post_with :xml, :role, :id => users(:quentin).to_param,
        :role => users(:quentin).roles.first.to_param
      assert_response :ok
      assert_match 'delete', flash[:message]
    end

    assert assigns(:user).valid?
  end

  def test_role_missing
    login_as :arthur

    assert_no_difference 'users(:quentin).roles.count' do
      post :role, :id => users(:quentin).to_param
    end
    assert_redirected_to user_path(users(:quentin))

    assert assigns(:user).valid?
    assert_match 'fail', flash[:warning]
  end

  def test_role_missing_xhr
    login_as :arthur

    assert_no_difference 'users(:quentin).roles.count' do
      xhr :post, :role, :id => users(:quentin).to_param
    end
    assert_responded_with :js
    assert_template 'layouts/_messages'

    assert assigns(:user).valid?
  end

  def test_role_missing_xml
    login_as :arthur

    assert_no_difference 'users(:quentin).roles.count' do
      post_with :xml, :role, :id => users(:quentin).to_param
    end
    assert_responded_with :xml

    assert assigns(:user).valid?
    assert_match 'fail', flash[:warning]
  end

  def test_forgot_routing
    assert_recognizes(
      { :controller => 'users', :action => 'forgot', :id => 'someone' },
      'users/someone/forgot'
    )
  end

  def test_forgot_invalid
    get :forgot
    assert_redirected_to users_path
  end

  def test_forgot
    assert_no_emails

    assert_change users(:arthur), :activation_code do
      get :forgot, :id => users(:arthur).to_param
    end
    assert_redirected_to user_path(users(:arthur))

    assert assigns(:user).valid?
    assert_emails 1
  end

  def test_forgot_xml
    assert_no_emails

    assert_change users(:arthur), :activation_code do
      get_with :xml, :forgot, :id => users(:arthur).to_param
    end
    assert_response :ok

    assert assigns(:user).valid?
    assert_emails 1
  end
end
