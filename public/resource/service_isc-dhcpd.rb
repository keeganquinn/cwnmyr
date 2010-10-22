# $Id: service_isc-dhcpd.rb 2687 2006-05-31 06:22:48Z keegan $
# Copyright 2006 Keegan Quinn
#
# ISC DHCP server configuration script.
#
# This is used as a plugin by ahservices.
#
#--
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

def configure_service(node, host, interfaces, properties)
  # Note primary and external interfaces
  primary_interface = nil
  external_interface = nil

  interfaces.each do |interface|
    primary_interface = interface if interface['primary']
    external_interface = interface if interface['external']
  end

  # Construct /etc/dhcpd.conf
  dhcpd_conf_file = sprintf("option domain-name \"personaltelco.net\";\n")
  dhcpd_conf_file += sprintf("default-lease-time 600;\n")
  dhcpd_conf_file += sprintf("max-lease-time 7200;\n\n")

  dhcpd_conf_file += sprintf("subnet %s netmask %s {\n",
                             primary_interface['network'],
                             primary_interface['netmask'])
  dhcpd_conf_file += sprintf("\trange %s %s;\n",
                             dhcp_range_start, dhcp_range_end)
  dhcpd_conf_file += sprintf("\toption broadcast-address %s;\n",
                             primary_interface['broadcast'])
  dhcpd_conf_file += sprintf("\toption routers %s;\n",
                             primary_interface['address'])
  dhcpd_conf_file += sprintf("\toption domain-name-servers %s;\n",
                             primary_interface['address'])
  dhcpd_conf_file += sprintf("}\n\n")


  begin
    dhcpd_conf_original = open("/etc/dhcpd.conf").read
  rescue
  end

  # Compare it with the current local copy of /etc/dhcpd.conf
  if dhcpd_conf_file != dhcpd_conf_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/dhcpd.conf", "w")
    fp.write(dhcpd_conf_file)
    fp.close
  end
end
