#--
# $Id: sessions_controller_test.rb 765 2008-05-12 22:22:48Z keegan $
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

class SessionsControllerTest < ActionController::TestCase
  fixtures :roles, :roles_users, :users

  def test_new_routing
    assert_recognizes(
      { :controller => 'sessions', :action => 'new' },
      'session/new'
    )
  end

  def test_new_authorized
    login_as :quentin

    get :new
    assert_redirected_to welcome_path
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_routing
    assert_recognizes(
      { :controller => 'sessions', :action => 'create' },
      { :path => 'session', :method => :post }
    )
  end

  def test_create_authorized
    login_as :quentin

    post :create
    assert_redirected_to welcome_path
  end

  def test_create_invalid
    post :create, :login => 'quentin', :password => 'bad password'
    assert_template 'new'

    assert_nil session[:user]
    assert_match 'fail', flash[:warning]
  end

  def test_create
    post :create, :login => 'quentin', :password => 'quentin'
    assert_redirected_to welcome_path

    assert_kind_of Integer, session[:user]
    assert_match 'success', flash[:notice]
  end

  def test_create_xhr
    xhr :post, :create, :login => 'quentin', :password => 'quentin'
    assert_responded_with :js
    assert_template 'layouts/_messages'

    assert_kind_of Integer, session[:user]
  end

  def test_create_xml
    post_with :xml, :create, :login => 'quentin', :password => 'quentin'
    assert_response :ok

    assert_kind_of Integer, session[:user]
    assert_match 'success', flash[:notice]
  end

  def test_create_with_activation_code
    assert users(:quentin).forgot_password

    assert_no_emails do
      get :create, :id => users(:quentin).activation_code
    end
    assert_redirected_to welcome_path

    assert_kind_of Integer, session[:user]
    assert_match 'account', flash[:notice]

    assert_equal users(:arthur), User.authenticate('arthur', 'arthur')
  end

  def test_create_with_return_to
    @request.session[:return_to] = '/some_path'

    post :create, :login => 'quentin', :password => 'quentin'
    assert_redirected_to '/some_path'

    assert_kind_of Integer, session[:user]
    assert_match 'success', flash[:notice]
  end

  def test_destroy
    login_as :quentin

    get :destroy
    assert_redirected_to welcome_path

    assert_nil session[:user]
    assert_match 'session', flash[:notice]
  end
end
