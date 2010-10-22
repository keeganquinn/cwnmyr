#--
# $Id: zones_controller_test.rb 765 2008-05-12 22:22:48Z keegan $
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

class ZonesControllerTest < ActionController::TestCase
  fixtures :users, :nodes, :hosts, :interfaces, :interface_points
  fixtures :statuses, :zones

  def test_index_routing
    assert_recognizes(
      { :controller => 'zones', :action => 'index' },
      'zones'
    )
  end

  def test_index
    get :index
    assert_template 'index'

    assert_kind_of Array, assigns(:zones)
  end

  def test_index_xml
    get_with :xml, :index
    assert_responded_with :xml

    assert_kind_of Array, assigns(:zones)    
  end

  def test_show_routing
    assert_recognizes(
      { :controller => 'zones', :action => 'show', :id => 'somewhere' },
      'zones/somewhere'
    )
  end

  def test_show_not_found
    get :show
    assert_redirected_to zones_path
  end

  def test_show
    get :show, :id => zones(:second).to_param
    assert_template 'show'

    assert assigns(:zone).valid?
  end

  def test_show_xml
    get_with :xml, :show, :id => zones(:second).to_param
    assert_responded_with :xml

    assert assigns(:zone).valid?
  end

  def test_new_routing
    assert_recognizes(
      { :controller => 'zones', :action => 'new' },
      'zones/new'
    )
  end

  def test_new_authorization
    assert_requires_login { get :new }
  end

  def test_new
    login_as :arthur

    get :new
    assert_template 'new'

    assert_kind_of Zone, assigns(:zone)
  end

  def test_new_rjs
    login_as :arthur

    xhr :get, :new
    assert_responded_with :js
    assert_template 'new'

    assert_kind_of Zone, assigns(:zone)
  end

  def test_edit_routing
    assert_recognizes(
      { :controller => 'zones', :action => 'edit', :id => 'somewhere' },
      'zones/somewhere/edit'
    )
  end

  def test_edit_authorization
    assert_requires_login { get :edit }
  end

  def test_edit_not_found
    login_as :arthur

    get :edit
    assert_redirected_to zones_path
  end

  def test_edit
    login_as :arthur

    get :edit, :id => zones(:first).to_param
    assert_template 'edit'

    assert assigns(:zone).valid?
  end

  def test_create_routing
    assert_recognizes(
      { :controller => 'zones', :action => 'create' },
      { :path => 'zones', :method => 'post' }
    )
  end

  def test_create_authorization
    assert_requires_login { post :create }
  end

  def test_create_invalid
    login_as :arthur

    assert_no_difference 'Zone.count' do
      post :create, :zone => { :code => 'invalid', :name => '' }
    end
    assert_template 'new'

    assert_not_nil assigns(:zone).errors.on(:name)
  end

  def test_create_invalid_xml
    login_as :arthur

    assert_no_difference 'Zone.count' do
      post_with :xml, :create, :zone => { :code => 'invalid', :name => '' }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:zone).errors.on(:name)
  end

  def test_create
    login_as :arthur

    assert_difference 'Zone.count' do
      post :create, :zone => { :code => '', :name => 'Test' }
    end
    assert_redirected_to zone_path(assigns(:zone))

    assert assigns(:zone).valid?
  end

  def test_create_xml
    login_as :arthur

    assert_difference 'Zone.count' do
      post_with :xml, :create, :zone => { :code => '', :name => 'Test' }
    end
    assert_response :created

    assert assigns(:zone).valid?
  end

  def test_update_routing
    assert_recognizes(
      { :controller => 'zones', :action => 'update', :id => 'somewhere' },
      { :path => 'zones/somewhere', :method => 'put' }
    )
  end

  def test_update_authorization
    assert_requires_login { put :update }
  end

  def test_update_not_found
    login_as :arthur

    put :update
    assert_redirected_to zones_path
  end

  def test_update_invalid
    login_as :arthur

    assert_no_change zones(:first), :updated_at do
      put :update, :id => zones(:first).to_param,
        :zone => { :name => '' }
    end
    assert_template 'edit'

    assert_not_nil assigns(:zone).errors.on(:name)
  end

  def test_update_invalid_xml
    login_as :arthur

    assert_no_change zones(:first), :updated_at do
      put_with :xml, :update, :id => zones(:first).to_param,
        :zone => { :name => '' }
    end
    assert_responded_with :xml

    assert_not_nil assigns(:zone).errors.on(:name)
  end

  def test_update
    login_as :arthur

    assert_change zones(:first), :updated_at do
      put :update, :id => zones(:first).to_param,
        :zone => { :name => 'Test' }
    end
    assert_redirected_to zone_path(zones(:first))

    assert assigns(:zone).valid?
  end

  def test_update_xml
    login_as :arthur

    assert_change zones(:first), :updated_at do
      put_with :xml, :update, :id => zones(:first).to_param,
        :zone => { :name => 'Test' }
    end
    assert_response :ok

    assert assigns(:zone).valid?
  end

  def test_destroy_routing
    assert_recognizes(
      { :controller => 'zones', :action => 'destroy', :id => 'somewhere' },
      { :path => 'zones/somewhere', :method => 'delete' }
    )
  end

  def test_destroy_authorization
    assert_requires_login { delete :destroy }
  end

  def test_destroy_not_found
    login_as :arthur

    delete :destroy
    assert_redirected_to zones_path
  end

  def test_destroy
    login_as :arthur

    assert_difference 'Zone.count', -1 do
      delete :destroy, :id => zones(:first).to_param
    end
    assert_redirected_to zones_path
  end

  def test_destroy_xml
    login_as :arthur

    assert_difference 'Zone.count', -1 do
      delete_with :xml, :destroy, :id => zones(:first).to_param
    end
    assert_response :ok
  end
end
