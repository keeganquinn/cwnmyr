#--
# $Id: node_link.rb 361 2007-05-16 00:52:06Z keegan $
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

# A NodeLink instance represents a hypertext link which is related to
# a particular Node instance.
class NodeLink < ActiveRecord::Base
  default_scope :order => 'node_id, name ASC'

  belongs_to :node

  validates_presence_of :node_id
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 64
  validates_length_of :application, :minimum => 1
  validates_length_of :application, :maximum => 16
  validates_format_of :application, :with => %r{^[-a-zA-Z0-9]+$},
    :message => 'contains unacceptable characters'
  validates_length_of :data, :minimum => 1
  validates_length_of :data, :maximum => 256
  validates_format_of :data,
    :with => %r{https?://([-\w\.]+)+(:\d+)?(/([\w/_\.]*(\?\S+)?)?)?},
    :message => 'must be a valid HTTP URI.',
    :if => Proc.new { |o| o.data and o.data.size > 1 }
end
