#--
# $Id: zone.rb 453 2007-07-05 11:07:07Z keegan $
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


# A Zone instance represents a physical area at a large scale.  It serves
# as an organizational aid and the heirarchial root of the system when
# browsing in the user interface.
#
# Node and ZoneMaintainer instances are dependencies.
class Zone < ActiveRecord::Base
  default_scope { order('name ASC') }

  scope :exposed, -> { where(expose: true) }

  has_many :nodes
  has_many :maintainers, :class_name => 'ZoneMaintainer'

  validates_length_of :code, :minimum => 1
  validates_length_of :code, :maximum => 64
  validates_uniqueness_of :code
  validates_format_of :code, :with => %r{\A[-_a-zA-Z0-9]+\z},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |zone| zone.code && zone.code.size > 1 }
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 64

  # Looks up an active flagged Zone instance by the provided +code+.
  def self.find_active_by_code(code)
    self.find(:first, :conditions => ["code = ? AND expose = ?", code, true])
  end

  # Find a Zone record based on an identifier from a request parameter.
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

  # TODO FIXME before_validation_on_create :set_defaults

  # Set default values.
  def set_defaults
    self.code = self.stripped_name if self.code.blank?
  end
end
