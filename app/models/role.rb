#--
# $Id: role.rb 447 2007-06-29 11:42:51Z keegan $
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

# The Role model provides the basis of a system which allows for different
# User instances to be granted varying degrees of administrative power.
class Role < ActiveRecord::Base
  default_scope :order => 'name ASC'

  has_and_belongs_to_many :users, :uniq => true

  validates_length_of :code, :minimum => 1
  validates_length_of :code, :maximum => 64
  validates_uniqueness_of :code
  validates_format_of :code, :with => %r{^[-_a-zA-Z0-9]+$},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |o| o.code.size > 1 }
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 255

  # A special identifier for an administrative Role.
  def self.manager
    'ManageConfig'
  end

  # Find a Role record based on an identifier from a request parameter.
  def self.find_by_param(*args)
    find_by_code *args
  end

  # This method returns an identifier for use in generating request
  # parameters.
  def to_param
    self.code
  end

  # Converts the value of the +name+ attribute into a link-friendly
  # String instance.
  def stripped_name
    self.name.gsub(/<[^>]*>/,'').to_url
  end

  protected

  before_validation_on_create :set_defaults

  # Set default values.
  def set_defaults
    self.code = self.stripped_name if self.code.blank?
  end
end
