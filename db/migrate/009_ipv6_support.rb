#--
# $Id: 009_ipv6_support.rb 508 2007-07-18 16:47:44Z keegan $
# Copyright 2006-2007 Keegan Quinn
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

class InterfaceStub < ActiveRecord::Base
  set_table_name "interfaces"
end

class Ipv6Support < ActiveRecord::Migration
  def self.up
    add_column(:interfaces, :ipv6_masked_address, :string, :limit => 64)
    add_column(:interfaces, :ipv4_masked_address, :string, :limit => 20)

    InterfaceStub.find(:all).each do |interface|
      interface.ipv4_masked_address = interface.address
      interface.save
    end

    remove_column(:interfaces, :address)
  end

  def self.down
    add_column(:interfaces, :address, :string, :limit => 20)

    InterfaceStub.find(:all).each do |interface|
      interface.address = interface.ipv4_masked_address
      interface.save
    end

    remove_column(:interfaces, :ipv4_masked_address)
    remove_column(:interfaces, :ipv6_masked_address)
  end
end
