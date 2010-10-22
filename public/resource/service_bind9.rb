# $Id: service_bind9.rb 2687 2006-05-31 06:22:48Z keegan $
# Copyright 2006 Keegan Quinn
#
# Berkeley Internet Name Daemon version 9 configuration script.
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

  # Note upstream DNS servers
  upstream_dns = nil
  properties.each do |property|
    if property['key'] == 'upstream_dns'
      upstream_dns = property['value']
    end
  end


  # Construct /etc/bind/named.conf.options
  named_conf_file = sprintf("acl local {\n")
  named_conf_file += sprintf("\t127.0.0.1;\n")
  named_conf_file += sprintf("\t%s/%s;\n",
                             primary_interface['network'],
                             primary_interface['prefix'])
  named_conf_file += sprintf("};\n\n")

  named_conf_file += sprintf("options {\n")
  named_conf_file += sprintf("\tdirectory \"/var/cache/bind\";\n")
  if upstream_dns
    named_conf_file += sprintf("\tforwarders {\n")
    upstream_dns.split.each do |upstream_dns_address|
      named_conf_file += sprintf("\t\t%s;\n", upstream_dns_address)
    end
    named_conf_file += sprintf("\t};\n")
  end
  named_conf_file += sprintf("\tallow-transfer { none; };\n")
  named_conf_file += sprintf("\tallow-query { local; };\n")
  named_conf_file += sprintf("\tauth-nxdomain no;\n")
  named_conf_file += sprintf("\tnotify no;\n")
  named_conf_file += sprintf("};\n\n")

  named_conf_file += sprintf("logging {\n")
  named_conf_file += sprintf("\tcategory lame-servers { null; };\n")
  named_conf_file += sprintf("};\n\n")


  begin
    named_conf_original = open("/etc/bind/named.conf.options").read
  rescue
  end

  # Compare it with the current local copy of /etc/bind/named.conf.options
  if named_conf_file != named_conf_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/named.conf.options", "w")
    fp.write(named_conf_file)
    fp.close
  end
end
