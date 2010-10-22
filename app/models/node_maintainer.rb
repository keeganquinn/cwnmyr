#--
# $Id: node_maintainer.rb 361 2007-05-16 00:52:06Z keegan $
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

# The NodeMaintainer model represents the association between a User
# instance and a Node instance.
class NodeMaintainer < ActiveRecord::Base
  default_scope :order => 'node_id, user_id DESC'

  belongs_to :node
  belongs_to :maintainer, :class_name => 'User', :foreign_key => 'user_id'

  validates_presence_of :node_id
  validates_presence_of :user_id
  validates_uniqueness_of :user_id, :scope => :node_id

  # This method returns a String suitable as an identifier on websites and
  # the like.
  def display_name
    description.blank? ? maintainer.login : maintainer.login + 
      ' (' + description + ')'
  end
end
