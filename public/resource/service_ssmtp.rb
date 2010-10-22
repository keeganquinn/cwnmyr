# $Id: service_ssmtp.rb 2687 2006-05-31 06:22:48Z keegan $
# Copyright 2006 Keegan Quinn
#
# SSMTP service configuration script.
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
  # Construct /etc/ssmtp/ssmtp.conf
  ssmtp_conf_file = sprintf("root=postmaster\n")
  ssmtp_conf_file += sprintf("mailhub=mail.personaltelco.net\n")
  ssmtp_conf_file += sprintf("rewriteDomain=personaltelco.net\n")
  ssmtp_conf_file += sprintf("hostname=%s.node.personaltelco.net\n",
                             host['hostname'])

  begin
    ssmtp_conf_original = open("/etc/ssmtp/ssmtp.conf").read
  rescue
  end

  # Compare it with the current local copy of /etc/ssmtp/ssmtp.conf
  if ssmtp_conf_file != ssmtp_conf_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/ssmtp.conf", "w")
    fp.write(ssmtp_conf_file)
    fp.close
  end
end
