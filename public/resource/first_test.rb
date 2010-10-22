# $Id: first_test.rb 2685 2006-05-31 05:31:07Z keegan $
# Copyright 2006 Keegan Quinn
#
# (Contrived) Example of how a host configuration script works.
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
  printf("%s\n\n", 'Prototype host configuration plugin')

  printf("NODE=%s\n", node['code'])
  printf("LOCATION=%s\n", node['name'])
  printf("CONTACT=%s\n\n", node['contact'])

  printf("BOX_NAME=%s\n", host['hostname'])
  printf("BOX_DOMAIN=%s\n", "node.personaltelco.net")
  printf("BOX_FQDN=%s\n\n", host['hostname'] + ".node.personaltelco.net")

  interfaces.each do |interface|
    printf("IF_%s is EXTERNAL\n", interface['code']) if interface['external']
    printf("IF_%s is PRIMARY\n", interface['code']) if interface['primary']

    printf("IF_%s_ADDRESS=%s\n", interface['code'], interface['address'])
    printf("IF_%s_NETADDRESS=%s\n", interface['code'], interface['network'])
    printf("IF_%s_NETMASK=%s\n", interface['code'], interface['netmask'])
    printf("IF_%s_BROADCAST=%s\n\n", interface['code'], interface['broadcast'])
  end

  properties.each do |property|
    printf("PROP_%s=%s\n\n", property['key'], property['value'])
  end
end
