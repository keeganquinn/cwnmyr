# $Id: service_nocatauth.rb 2687 2006-05-31 06:22:48Z keegan $
# Copyright 2006 Keegan Quinn
#
# NoCatAuth captive portal configuration script.
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

  # Construct /etc/nocatauth/gateway/nocat.conf
  nocat_conf_file = sprintf("Verbosity\t0\n")
  nocat_conf_file += sprintf("GatewayName\tthe Personal Telco Project\n")
  nocat_conf_file += sprintf("GatewayMode\tOpen\n")
  nocat_conf_file += sprintf("GatewayLog\t/var/log/nocat.log\n")
  nocat_conf_file += sprintf("LoginTimeout\t86400\n")
  nocat_conf_file += sprintf("HomePage\thttp://www.personaltelco.net\n")
  nocat_conf_file += sprintf("DocumentRoot\t" +
                               "/usr/share/nocatauth/gateway/htdocs\n")
  nocat_conf_file += sprintf("SplashForm\tsplash.html\n")
  nocat_conf_file += sprintf("StatusForm\tstatus.html\n")
  nocat_conf_file += sprintf("TrustedGroups\tAny\n")
  nocat_conf_file += sprintf("InternalDevice\t%s\n", primary_interface['code'])


  begin
    nocat_conf_original = open("/etc/nocatauth/gateway/nocat.conf").read
  rescue
  end

  # Compare it with the current local copy of /etc/nocatauth/gateway/nocat.conf
  if nocat_conf_file != nocat_conf_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/nocat.conf", "w")
    fp.write(nocat_conf_file)
    fp.close
  end
end
