#--
# $Id: zone_maintainer_controller_test.rb 2665 2006-05-26 00:40:38Z keegan $
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
require 'zone_maintainer_controller'

# Re-raise errors caught by the controller.
class ZoneMaintainerController; def rescue_action(e) raise e end; end

class ZoneMaintainerControllerTest < ActionController::TestCase
  fixtures :users, :zones, :zone_maintainers

  def setup
    @controller = ZoneMaintainerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    assert_routing 'zone_maintainer', {
      :controller => 'zone_maintainer', :action => 'index'
    }

    assert_requires_login { get :index }
  end

  def test_show
    assert_routing 'zone_maintainer/show/1', {
      :controller => 'zone_maintainer', :action => 'show', :id => '1'
    }

    get :show, :id => 1

    assert_template 'show'
    assert_not_nil assigns(:zone_maintainer)
    assert assigns(:zone_maintainer).valid?
  end

  def test_new
    assert_routing 'zone_maintainer/new', {
      :controller => 'zone_maintainer', :action => 'new'
    }

    assert_requires_login { get :new }

    num_zone_maintainers = ZoneMaintainer.count

    assert_accepts_login(:arthur) {
      get :new, :zone_id => zones(:first).id

      assert_template 'new'
      assert_not_nil assigns(:zone_maintainer)

      post :new, {
        :zone_id => zones(:first).id,
        :zone_maintainer => {
          :user_id => users(:arthur).id,
          :description => 'Functional test'
        }
      }

      assert_redirected_to(:controller => 'zone',
                           :action => 'show',
                           :code => zones(:first).code)

      get :show, :id => 3
    }

    assert_equal num_zone_maintainers + 1, ZoneMaintainer.count
  end

  def test_edit
    assert_routing 'zone_maintainer/edit/1', {
      :controller => 'zone_maintainer', :action => 'edit', :id => '1'
    }

    assert_requires_login { get :edit }

    assert_accepts_login(:arthur) {
      get :edit, :id => 1

      assert_template 'edit'
      assert_not_nil assigns(:zone_maintainer)
      assert assigns(:zone_maintainer).valid?

      post :edit, :id => 1

      assert_redirected_to :action => 'show', :id => 1

      get :show, :id => 1
    }
  end

  def test_destroy
    assert_routing 'zone_maintainer/destroy/1', {
      :controller => 'zone_maintainer', :action => 'destroy', :id => '1'
    }

    assert_requires_login { get :destroy, :id => zone_maintainers(:first).id }

    assert_not_nil ZoneMaintainer.find(zone_maintainers(:first).id)

    assert_accepts_login(:arthur) {
      get :destroy, :id => zone_maintainers(:first).id

      assert_redirected_to(:controller => 'zone',
                           :action => 'show',
                           :code => zones(:first).code)

      # TODO: figure out how to get an action from another controller
      get :show, :id => zone_maintainers(:second).id
    }

    assert_raise(ActiveRecord::RecordNotFound) {
      ZoneMaintainer.find(zone_maintainers(:first).id)
    }
  end
end
