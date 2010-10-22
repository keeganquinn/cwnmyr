#--
# $Id: host_configuration.rb 2738 2006-06-10 08:35:28Z keegan $
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

class HostConfiguration < ActionWebService::Struct
  member :created_at, :int
  member :updated_at, :int
  member :hostname, :string
  member :type, :string
  member :primary_ipv4_address, :string
  member :external_ipv4_address, :string
  member :top_level_hostname, :boolean

  def self.from_host(host)
    primary_ipv4_address = nil
    external_ipv4_address = nil

    if host.primary_interface
      primary_ipv4_address = host.primary_interface.ipv4_address
    end

    if host.external_interface
      external_ipv4_address = host.external_interface.ipv4_address
    end

    content = {
      :created_at => host.created_at.to_i,
      :updated_at => host.updated_at.to_i,
      :hostname => host.name,
      :type => host.type.code,
      :primary_ipv4_address => primary_ipv4_address,
      :external_ipv4_address => external_ipv4_address,
      :top_level_hostname => host.top_level_hostname
    }

    return self.new(content)
  end
end
