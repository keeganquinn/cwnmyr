#--
# $Id: host_service.rb 361 2007-05-16 00:52:06Z keegan $
# Copyright 2004-2007 Keegan Quinn
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

# Each HostService instance represents a relationship between a Host
# instance and a Service instance.
class HostService < ActiveRecord::Base
  default_scope :order => 'host_id, service_id DESC'

  belongs_to :host
  belongs_to :service

  validates_presence_of :host_id
  validates_presence_of :service_id
  validates_uniqueness_of :service_id, :scope => :host_id
end
