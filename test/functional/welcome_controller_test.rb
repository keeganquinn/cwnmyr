#--
# $Id: welcome_controller_test.rb 765 2008-05-12 22:22:48Z keegan $
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

class WelcomeControllerTest < ActionController::TestCase
  def test_index_routing
    assert_routing '', :controller => 'welcome', :action => 'index'
  end

  def test_index
    get :index
    assert_template 'index'
  end
end
