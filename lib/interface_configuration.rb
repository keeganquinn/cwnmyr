#--
# $Id: interface_configuration.rb 2738 2006-06-10 08:35:28Z keegan $
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

class InterfaceConfiguration < ActionWebService::Struct
  member :created_at, :int
  member :updated_at, :int
  member :code, :string
  member :ipv4_address, :string
  member :ipv4_network, :string
  member :ipv4_netmask, :string
  member :ipv4_broadcast, :string
  member :primary, :boolean
  member :external, :boolean
end
