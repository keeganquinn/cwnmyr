#--
# $Id: user_log.rb 361 2007-05-16 00:52:06Z keegan $
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

# Each UserLog instance represents a personal log entry made by a User.
class UserLog < ActiveRecord::Base
  default_scope :order => 'user_id, updated_at DESC'

  belongs_to :user

  validates_presence_of :user_id
  validates_length_of :subject, :minimum => 1
  validates_length_of :subject, :maximum => 255
  validates_length_of :body, :minimum => 1
end
