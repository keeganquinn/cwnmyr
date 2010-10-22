# $Id: service_first_test.rb 2685 2006-05-31 05:31:07Z keegan $
# Copyright 2006 Keegan Quinn
#
# (Contrived) Example of how a service configuration script works.
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
  printf("%s\n\n", 'Prototype service configuration plugin')

  printf("Service code: %s\n", 'first_test')
  printf("Node code: %s\n", node['code'])
  printf("Host name: %s\n\n", host['hostname'])
end
