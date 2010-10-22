#--
# $Id: interface_test.rb 2750 2006-06-11 12:35:31Z keegan $
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

require 'test_helper'

class InterfaceTest < ActiveSupport::TestCase
  fixtures :hosts, :interfaces, :interface_types, :nodes
  fixtures :statuses, :wireless_interfaces

  def setup
    @interface = Interface.new

    @interface.host = hosts(:first)
    @interface.type = interface_types(:first)
    @interface.status = statuses(:first)
    @interface.code = 'unittest'
    @interface.ipv4_masked_address = '10.14.18.22/26'
    @interface.ipv6_masked_address = '2001:618:400:3d7c::1/64'
  end

  def test_create_read_update_delete
    @interface.save

    print @interface.errors.full_messages
    assert(@interface.save)

    read_interface = hosts(:first).interfaces.find_by_code 'unittest'

    assert_equal(@interface.status, read_interface.status)

    @interface.name = 'Unit test'

    assert(@interface.save)

    assert(@interface.destroy)
  end

  def test_associations
    assert_kind_of(Host, interfaces(:first).host)
    assert_kind_of(InterfaceType, interfaces(:first).type)
    assert_kind_of(Status, interfaces(:first).status)
    assert_kind_of(Array, interfaces(:first).points)
    assert_kind_of(Array, interfaces(:first).properties)
    assert_kind_of(WirelessInterface, interfaces(:second).wireless_interface)
  end

  def test_validates_presence_of_host_id
    @interface.host = nil
    assert !@interface.save
  end

  def test_validates_presence_of_interface_type_id
    @interface.type = nil
    assert !@interface.save
  end

  def test_validates_presence_of_status_id
    @interface.status = nil
    assert !@interface.save
  end

  def test_validates_length_of_code
    @interface.code = ''
    assert !@interface.save
  end

  def test_validates_format_of_code
    @interface.code = 'unit test'
    assert !@interface.save
  end

  def test_validates_address_ipv4
    @interface.ipv4_masked_address = nil
    assert !@interface.save

    @interface.ipv4_masked_address = '10.11.12'
    assert !@interface.save

    @interface.ipv4_masked_address = '1000.999.998.997/1000'
    assert !@interface.save
  end

  def test_validates_address_ipv6
    @interface.ipv6_masked_address = '10.11.12'
    assert !@interface.save

    @interface.ipv6_masked_address = '2001:618:400:3d7c::1/129'
    assert !@interface.save
  end

  def test_validates_format_of_mac
    @interface.mac = '001122334455'
    assert !@interface.save
  end

  def test_validates_length_of_name
    @interface.name = 'This is much too long a name for an interface. ' +
      'Interface names are limited to 255 characters, although this ' +
      'particular restriction is rather arbitrary.  This is intended ' +
      'to help keep displays clean.'
    assert !@interface.save
  end

  def test_display_name
    assert_equal('(first_test) First test', interfaces(:first).display_name)
  end

  def test_ipv4_address
    assert_equal('192.168.1.1', interfaces(:first).ipv4_address)
  end

  def test_ipv4_prefix
    assert_equal("24", interfaces(:first).ipv4_prefix)
  end

  def test_ipv4_calculated_subnet
    assert_kind_of(Ipv4Calculator::Subnet,
                   interfaces(:first).ipv4_calculated_subnet)
  end

  def test_ipv4_network
    assert_equal('192.168.1.0', interfaces(:first).ipv4_network)
  end

  def test_ipv4_netmask
    assert_equal('255.255.255.0', interfaces(:first).ipv4_netmask)
  end

  def test_ipv4_broadcast
    assert_equal('192.168.1.255', interfaces(:first).ipv4_broadcast)
  end

  def test_ipv4_static_address?
    assert(interfaces(:first).ipv4_static_address?)
  end

  def test_ipv4_neighbors
    assert_equal([], interfaces(:first).ipv4_neighbors)

    # This could probably be tested better.
  end

  def test_ipv6_static_address?
    assert_raise NotImplementedError do
      interfaces(:first).ipv6_static_address?
    end
  end

  def test_ipv6_neighbors
    assert_raise NotImplementedError do
      interfaces(:first).ipv6_neighbors
    end
  end

  def test_average_point
    assert_nil interfaces(:first).average_point
  end
end
