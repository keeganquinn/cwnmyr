#--
# $Id: configuration_controller.rb 410 2007-06-27 16:15:24Z keegan $
# Copyright 2004-2009 Keegan Quinn
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

# This controller allows the generation of configuration files.
class ConfigurationController < ApplicationController
  # Display a listing of available configuration files.
  def index
  end

  # This action can be used to download a BIND DNS zone representing
  # all hosts with external (Internet-facing) Interface instances.
  def dns_zone_external
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a BIND DNS zone representing
  # all hosts with internal Interface instances.
  def dns_zone_internal
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Smokeping configuration file
  # representing all hosts with external (Internet-facing) Interface
  # instances.
  def smokeping_external
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Smokeping configuration file
  # representing all hosts with internal Interface instances.
  def smokeping_internal
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Nagios configuration file
  # representing all hosts with external (Internet-facing) Interface
  # instances.
  def nagios_external
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Nagios configuration file
  # representing all hosts with internal Interface instances.
  def nagios_internal
    response.content_type = 'text/plain'
    render :layout => false
  end
end
