#--
# $Id: configuration_controller_test.rb 765 2008-05-12 22:22:48Z keegan $
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

class ConfigurationControllerTest < ActionController::TestCase
  fixtures :hosts, :host_properties, :host_property_types, :host_services
  fixtures :host_types, :interfaces, :nodes, :services, :zones

  def test_index_routing
    assert_routing 'configuration',
      :controller => 'configuration', :action => 'index'
  end

  def test_index
    get :index
    assert_template 'index'
  end

  def test_dns_zone_external_routing
    assert_routing 'configuration/dns_zone_external',
      :controller => 'configuration', :action => 'dns_zone_external'
  end

  def test_dns_zone_external
    get :dns_zone_external
    assert_responded_with :txt
    assert_template 'dns_zone_external'
  end

  def test_dns_zone_internal_routing
    assert_routing 'configuration/dns_zone_internal',
      :controller => 'configuration', :action => 'dns_zone_internal'
  end

  def test_dns_zone_internal
    get :dns_zone_internal
    assert_responded_with :txt
    assert_template 'dns_zone_internal'
  end

  def test_smokeping_external_routing
    assert_routing 'configuration/smokeping_external',
      :controller => 'configuration', :action => 'smokeping_external'
  end

  def test_smokeping_external
    get :smokeping_external
    assert_responded_with :txt
    assert_template 'smokeping_external'
  end

  def test_smokeping_internal_routing
    assert_routing 'configuration/smokeping_internal',
      :controller => 'configuration', :action => 'smokeping_internal'
  end

  def test_smokeping_internal
    get :smokeping_internal
    assert_responded_with :txt
    assert_template 'smokeping_internal'
  end

  def test_nagios_external_routing
    assert_routing 'configuration/nagios_external',
      :controller => 'configuration', :action => 'nagios_external'
  end

  def test_nagios_external
    get :nagios_external
    assert_responded_with :txt
    assert_template 'nagios_external'
  end

  def test_nagios_internal_routing
    assert_routing 'configuration/nagios_internal',
      :controller => 'configuration', :action => 'nagios_internal'
  end

  def test_nagios_internal
    get :nagios_internal
    assert_responded_with :txt
    assert_template 'nagios_internal'
  end
end
