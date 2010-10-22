# $Id: cab.rb 2686 2006-05-31 06:12:39Z keegan $
# Copyright 2006 Keegan Quinn
#
# Clone Army Box base configuration script.
#
# This is used as a plugin by ahconfig.
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

def configure(node, host, interfaces, properties)
  # Note primary and external interfaces
  primary_interface = nil
  external_interface = nil

  interfaces.each do |interface|
    primary_interface = interface if interface['primary']
    external_interface = interface if interface['external']
  end

  # Note default route and kernel modules
  default_route = nil
  kernel_modules = nil
  properties.each do |property|
    if property['key'] == 'default_route'
      default_route = property['value'].split("/")[0]
    elsif property['key'] == 'kernel_modules'
      kernel_modules = property['value']
    end
  end


  # Construct /etc/hosts
  hosts_file = sprintf("127.0.0.1\tlocalhost\n\n")

  hosts_file += sprintf("%s\t%s.node.personaltelco.net\t%s\n\n",
                        primary_interface['address'],
                        host['hostname'], host['hostname'])

  hosts_file += sprintf("::1\tip6-localhost\tip6-loopback\n")
  hosts_file += sprintf("fe00::0\tip6-localnet\n")
  hosts_file += sprintf("ff00::0\tip6-mcastprefix\n")
  hosts_file += sprintf("ff02::1\tip6-allnodes\n")
  hosts_file += sprintf("ff02::2\tip6-allrouters\n")
  hosts_file += sprintf("ff02::3\tip6-allhosts\n\n")

  begin
    hosts_original = open("/etc/hosts").read
  rescue
  end

  # Compare it with the current local copy of /etc/hosts
  if hosts_file != hosts_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/hosts", "w")
    fp.write(hosts_file)
    fp.close
  end


  # Construct /etc/network/interfaces
  interfaces_file = sprintf("auto lo\niface lo inet loopback\n\n")

  interfaces.each do |interface|
    if interface['address'] == interface['network']
      interfaces_file += sprintf("auto %s\niface %s inet dhcp\n\n",
                                 interface['code'], interface['code'])
    else
      interfaces_file += sprintf("auto %s\niface %s inet static\n",
                                 interface['code'], interface['code'])
      interfaces_file += sprintf("\taddress %s\n", interface['address'])
      interfaces_file += sprintf("\tnetwork %s\n", interface['network'])
      interfaces_file += sprintf("\tnetmask %s\n", interface['netmask'])
      interfaces_file += sprintf("\tbroadcast %s\n", interface['broadcast'])

      if interface['external']
        interfaces_file += sprintf("\tgateway %s\n", default_route)
      end

      interfaces_file += "\n"
    end
  end

  begin
    interfaces_original = open("/etc/network/interfaces").read
  rescue
  end

  # Compare it with the current local copy of /etc/network/interfaces
  if interfaces_file != interfaces_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/interfaces", "w")
    fp.write(interfaces_file)
    fp.close
  end

  # Construct /etc/modules
  modules_file = sprintf("ide-cd\nide-disk\nide-generic\n")
  modules_file += kernel_modules if kernel_modules

  begin
    modules_original = open("/etc/modules").read
  rescue
  end

  # Compare it with the current local copy of /etc/modules
  if modules_file != modules_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/modules", "w")
    fp.write(modules_file)
    fp.close
  end


  # Construct /etc/motd
  motd_file = sprintf("%s\n", `uname -a`)

  motd_file += sprintf("Adhocracy-managed host: %s\nNode code: %s\n",
                       host['hostname'], node['code'])

  begin
    motd_original = open("/etc/motd").read
  rescue
  end

  # Compare it with the current local copy of /etc/motd
  if motd_file != motd_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/motd", "w")
    fp.write(motd_file)
    fp.close
  end
end
