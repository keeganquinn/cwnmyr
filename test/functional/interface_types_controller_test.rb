#--
# $Id: interface_types_controller_test.rb 765 2008-05-12 22:22:48Z keegan $
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

class InterfaceTypesControllerTest < ActionController::TestCase
  fixtures :interface_types, :roles, :roles_users, :users

  def test_index_routing
    assert_recognizes(
      { :controller => 'interface_types', :action => 'index' },
      'interface_types'
    )
  end

  def test_index
    get :index
    assert_template 'index'

    assert_kind_of Array, assigns(:interface_types)
  end

  def test_index_xml
    get_with :xml, :index
    assert_responded_with :xml

    assert_kind_of Array, assigns(:interface_types)
  end

  def test_show_routing
    assert_recognizes(
      { :controller => 'interface_types', :action => 'show', :id => 'something' },
      'interface_types/something'
    )
  end

  def test_show_not_found
    get :show
    assert_redirected_to interface_types_path
  end

  def test_show
    get :show, :id => interface_types(:first).to_param
    assert_template 'show'

    assert assigns(:interface_type).valid?
  end

  def test_new_routing
    assert_recognizes(
      { :controller => 'interface_types', :action => 'new' },
      'interface_types/new'
    )
  end

  def test_new_authorization
    assert_requires_login { get :new }
  end

  def test_new
    login_as :arthur

    get :new
    assert_template 'new'

    assert_kind_of InterfaceType, assigns(:interface_type)
  end

  def test_edit_routing
    assert_recognizes(
      { :controller => 'interface_types', :action => 'edit', :id => 'something' },
      'interface_types/something/edit'
    )
  end

  def test_edit_authorization
    assert_requires_login { get :edit }
  end

  def test_edit_not_found
    login_as :arthur

    get :edit
    assert_redirected_to interface_types_path
  end

  def test_edit
    login_as :arthur

    get :edit, :id => interface_types(:first).to_param
    assert_template 'edit'

    assert assigns(:interface_type).valid?
  end

  def test_create_routing
    assert_recognizes(
      { :controller => 'interface_types', :action => 'create' },
      { :path => 'interface_types', :method => 'post' }
    )
  end

  def test_create_authorization
    assert_requires_login { post :create }
  end

  def test_create_invalid
    login_as :arthur

    assert_no_difference 'InterfaceType.count' do
      post :create, :interface_type => { :name => '' }
    end
    assert_template 'new'

    assert_not_nil assigns(:interface_type).errors.on(:name)
  end

  def test_create_invalid_xml
    login_as :arthur

    assert_no_difference 'InterfaceType.count' do
      post_with :xml, :create, :interface_type => { :name => '' }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:interface_type).errors.on(:name)
  end

  def test_create
    login_as :arthur

    assert_difference 'InterfaceType.count' do
      post :create, :interface_type => { :name => 'Test' }
    end
    assert_redirected_to interface_type_path(assigns(:interface_type))

    assert assigns(:interface_type).valid?
  end

  def test_create_xml
    login_as :arthur

    assert_difference 'InterfaceType.count' do
      post_with :xml, :create, :interface_type => { :name => 'Test' }
    end
    assert_response :created

    assert assigns(:interface_type).valid?
  end

  def test_update_routing
    assert_recognizes(
      { :controller => 'interface_types', :action => 'update', :id => 'something' },
      { :path => 'interface_types/something', :method => 'put' }
    )
  end

  def test_update_authorization
    assert_requires_login { put :update }
  end

  def test_update_not_found
    login_as :arthur

    put :update
    assert_redirected_to interface_types_path
  end

  def test_update_invalid
    login_as :arthur

    assert_no_change interface_types(:first), :updated_at do
      put :update, :id => interface_types(:first).to_param,
        :interface_type => { :name => '' }
    end
    assert_template 'edit'

    assert_not_nil assigns(:interface_type).errors.on(:name)
  end

  def test_update_invalid_xml
    login_as :arthur

    assert_no_change interface_types(:first), :updated_at do
      put_with :xml, :update, :id => interface_types(:first).to_param,
        :interface_type => { :name => '' }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:interface_type).errors.on(:name)
  end

  def test_update
    login_as :arthur

    assert_change interface_types(:first), :updated_at do
      put :update, :id => interface_types(:first).to_param,
        :interface_type => { :name => 'Test' }
    end
    assert_redirected_to interface_type_path(interface_types(:first))

    assert assigns(:interface_type).valid?
  end

  def test_update_xml
    login_as :arthur

    assert_change interface_types(:first), :updated_at do
      put_with :xml, :update, :id => interface_types(:first).to_param,
        :interface_type => { :name => 'Test' }
    end
    assert_response :ok

    assert assigns(:interface_type).valid?
  end

  def test_destroy_routing
    assert_recognizes(
      { :controller => 'interface_types', :action => 'destroy', :id => 'something' },
      { :path => 'interface_types/something', :method => 'delete' }
    )
  end

  def test_destroy_authorization
    assert_requires_login { delete :destroy }
  end

  def test_destroy_not_found
    login_as :arthur

    delete :destroy
    assert_redirected_to interface_types_path
  end

  def test_destroy
    login_as :arthur

    assert_difference 'InterfaceType.count', -1 do
      delete :destroy, :id => interface_types(:first).to_param
    end
    assert_redirected_to interface_types_path
  end

  def test_destroy_xml
    login_as :arthur

    assert_difference 'InterfaceType.count', -1 do
      delete_with :xml, :destroy, :id => interface_types(:first).to_param
    end
    assert_response :ok
  end
end
