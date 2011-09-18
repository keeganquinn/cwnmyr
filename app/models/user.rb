#--
# user.rb: User model
# © 2011 Keegan Quinn
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

# An instance of the User model represents a sentient being of some kind
# who has been granted some degree of access to this system.
#
# HostLog, HostTypeComment, NodeComment, NodeLog, NodeMaintainer, Role,
# UserComment, UserLink, UserLog and ZoneMaintainer instances can all be
# associated with a User instance.
#
# Uses Devise as a basis for primary functionality.
class User < ActiveRecord::Base
  has_many :host_logs
  has_many :host_type_comments
  has_many :node_comments
  has_many :node_logs
  has_many :node_maintainers
  has_many :nodes, :through => :node_maintainers, :foreign_key => 'user_id'
  has_and_belongs_to_many :roles, :uniq => true
  has_many :comments, :class_name => 'UserComment'
  has_many :comments_on_others, :class_name => 'UserComment', :foreign_key => 'commenting_user_id'
  has_many :links, :class_name => 'UserLink'
  has_many :logs, :class_name => 'UserLog'
  has_many :zones, :through => :zone_maintainers
  has_many :zone_maintainers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  default_scope :order => 'username ASC'
  scope :with_profile, where('username IS NOT NULL')

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username

  validates_length_of :username, :within => 3..40, :allow_nil => true
  validates_uniqueness_of :username, :allow_nil => true
  validates_format_of :username, :with => /\A[A-Za-z0-9]+\Z/, :allow_nil => true

  # This method returns an Array of all User instances who have either
  # given this User a positive Comment or have received a positive
  # Comment from this User.
  def friends
    friends = []

    comments.find_all_by_rating(1).each do |positive_comment|
      unless friends.include? positive_comment.commenting_user
        friends.push positive_comment.commenting_user
      end
    end

    comments_on_others.find_all_by_rating(1).each do |positive_comment|
      unless friends.include? positive_comment.user
        friends.push positive_comment.user
      end
    end

    friends
  end

  # This method returns true if the User has a relationship with any Role
  # whose code matches one of the role_codes.
  def has_role?(*role_codes)
    roles.detect do |role| 
      role_codes.include?(role.code)
    end
  end

  # Returns a collection of Role records which are not associated with
  # this record.
  def other_roles
    Role.find(:all) - self.roles
  end

  # Generate a string for use as a URI parameter.
  def to_param
    "#{username.blank? ? id : username}"
  end

  # Find a User by a URI parameter.
  def self.find_by_param(param)
    self.find_by_username(param) || self.find(param)
  end
end
