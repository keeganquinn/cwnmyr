#--
# $Id: statuses_controller_test.rb 765 2008-05-12 22:22:48Z keegan $
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

class StatusesControllerTest < ActionController::TestCase
  fixtures :roles, :roles_users, :statuses, :users

  def test_index_routing
    assert_recognizes(
      { :controller => 'statuses', :action => 'index' },
      'statuses'
    )
  end

  def test_index_authentication
    assert_requires_login { get :index }
  end

  def test_index_authorization
    assert_requires_login(:quentin) { get :index }
  end

  def test_index
    login_as :arthur

    get :index
    assert_template 'index'

    assert_kind_of Array, assigns(:statuses)
  end

  def test_index_xml
    login_as :arthur

    get_with :xml, :index
    assert_responded_with :xml

    assert_kind_of Array, assigns(:statuses)
  end

  def test_show_routing
    assert_recognizes(
      { :controller => 'statuses', :action => 'show', :id => 'something' },
      'statuses/something'
    )
  end

  def test_show_authentication
    assert_requires_login { get :show }
  end

  def test_show_authorization
    assert_requires_login(:quentin) { get :show }
  end

  def test_show_not_found
    login_as :arthur

    get :show
    assert_redirected_to statuses_path
  end

  def test_show
    login_as :arthur

    get :show, :id => statuses(:first).to_param
    assert_template 'show'

    assert assigns(:status).valid?
  end

  def test_show_xml
    login_as :arthur

    get_with :xml, :show, :id => statuses(:first).to_param
    assert_responded_with :xml

    assert assigns(:status).valid?
  end

  def test_new_routing
    assert_recognizes(
      { :controller => 'statuses', :action => 'new' },
      'statuses/new'
    )
  end

  def test_new_authentication
    assert_requires_login { get :new }
  end

  def test_new_authorization
    assert_requires_login(:quentin) { get :new }
  end

  def test_new
    login_as :arthur

    get :new
    assert_template 'new'

    assert_kind_of Status, assigns(:status)
  end

  def test_new_rjs
    login_as :arthur

    xhr :get, :new
    assert_responded_with :js
    assert_template 'new'

    assert_kind_of Status, assigns(:status)
  end

  def test_edit_routing
    assert_recognizes(
      { :controller => 'statuses', :action => 'edit', :id => 'something' },
      'statuses/something/edit'
    )
  end

  def test_edit_authentication
    assert_requires_login { get :edit }
  end

  def test_edit_authorization
    assert_requires_login(:quentin) { get :edit }
  end

  def test_edit_not_found
    login_as :arthur

    get :edit
    assert_redirected_to statuses_path
  end

  def test_edit
    login_as :arthur

    get :edit, :id => statuses(:first).to_param
    assert_template 'edit'

    assert assigns(:status).valid?
  end

  def test_create_routing
    assert_recognizes(
      { :controller => 'statuses', :action => 'create' },
      { :path => 'statuses', :method => 'post' }
    )
  end

  def test_create_authentication
    assert_requires_login { post :create }
  end

  def test_create_authorization
    assert_requires_login(:quentin) { post :create }
  end

  def test_create_invalid
    login_as :arthur

    assert_no_difference 'Status.count' do
      post :create, :status => { :code => 'invalid', :name => '' }
    end
    assert_template 'new'

    assert_not_nil assigns(:status).errors.on(:name)
  end

  def test_create_invalid_xml
    login_as :arthur

    assert_no_difference 'Status.count' do
      post_with :xml, :create, :status => { :code => 'invalid', :name => '' }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:status).errors.on(:name)
  end

  def test_create
    login_as :arthur

    assert_difference 'Status.count' do
      post :create, :status => {
        :code => 'functional_test',
        :name => 'Functional test',
        :description => 'Just a test status',
        :color => '00FF00',
        :expose => true
      }
    end
    assert_redirected_to status_path(assigns(:status))

    assert assigns(:status).valid?
  end

  def test_create_xml
    login_as :arthur

    assert_difference 'Status.count' do
      post_with :xml, :create, :status => {
        :code => 'functional_test',
        :name => 'Functional test',
        :description => 'Just a test status',
        :color => '00FF00',
        :expose => true
      }
    end
    assert_response :created

    assert assigns(:status).valid?
  end

  def test_update_routing
    assert_recognizes(
      { :controller => 'statuses', :action => 'update', :id => 'something' },
      { :path => 'statuses/something', :method => 'put' }
    )
  end

  def test_update_authentication
    assert_requires_login { put :update }
  end

  def test_update_authorization
    assert_requires_login(:quentin) { put :update }
  end

  def test_update_not_found
    login_as :arthur

    put :update
    assert_redirected_to statuses_path
  end

  def test_update_invalid
    login_as :arthur

    assert_no_change statuses(:first), :updated_at do
      put :update, :id => statuses(:first).to_param,
        :status => { :name => '' }
    end
    assert_template 'edit'

    assert_not_nil assigns(:status).errors.on(:name)
  end

  def test_update_invalid_xml
    login_as :arthur

    assert_no_change statuses(:first), :updated_at do
      put_with :xml, :update, :id => statuses(:first).to_param,
        :status => { :name => '' }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:status).errors.on(:name)
  end

  def test_update
    login_as :arthur

    assert_change statuses(:first), :updated_at do
      put :update, :id => statuses(:first).to_param,
        :status => { :name => 'Changed' }
    end
    assert_redirected_to status_path(statuses(:first))

    assert assigns(:status).valid?
  end

  def test_update_xml
    login_as :arthur

    assert_change statuses(:first), :updated_at do
      put_with :xml, :update, :id => statuses(:first).to_param,
        :status => { :name => 'Changed' }
    end
    assert_response :ok

    assert assigns(:status).valid?
  end

  def test_destroy_routing
    assert_recognizes(
      { :controller => 'statuses', :action => 'destroy', :id => 'something' },
      { :path => 'statuses/something', :method => 'delete' }
    )
  end

  def test_destroy_authentication
    assert_requires_login { delete :destroy }
  end

  def test_destroy_authorization
    assert_requires_login(:quentin) { delete :destroy }
  end

  def test_destroy_not_found
    login_as :arthur

    delete :destroy
    assert_redirected_to statuses_path
  end

  def test_destroy
    login_as :arthur

    assert_difference 'Status.count', -1 do
      delete :destroy, :id => statuses(:first).to_param
    end
    assert_redirected_to statuses_path
  end

  def test_destroy_xml
    login_as :arthur

    assert_difference 'Status.count', -1 do
      delete_with :xml, :destroy, :id => statuses(:first).to_param
    end
    assert_response :ok
  end
end
