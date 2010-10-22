#--
# $Id: user.rb 856 2009-10-24 02:09:55Z keegan $
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

# An instance of the User model represents a sentient being of some kind
# who has been granted some degree of access to this system.
#
# HostLog, HostTypeComment, NodeComment, NodeLog, NodeMaintainer, Role,
# UserComment, UserLink, UserLog and ZoneMaintainer instances can all be
# associated with a User instance.
#
# This class also provides authentication services including password
# encryption and email account confirmation.
class User < ActiveRecord::Base
  default_scope :order => 'login ASC'

  has_many :host_logs
  has_many :host_type_comments
  has_many :node_comments
  has_many :node_logs
  has_many :node_maintainers
  has_many :nodes, :through => :node_maintainers, :foreign_key => 'user_id'
  has_and_belongs_to_many :roles, :uniq => true
  has_many :comments, :class_name => 'UserComment'
  has_many :comments_on_others, {
    :class_name => 'UserComment', :foreign_key => 'commenting_user_id'
  }
  has_many :links, :class_name => 'UserLink'
  has_many :logs, :class_name => 'UserLog'
  has_many :zones, :through => :zone_maintainers
  has_many :zone_maintainers

  # Unencrypted password.
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 5..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email
  validates_format_of       :login, :with => /\A[A-Za-z0-9]+\Z/

  validates_as_email_address :email

  before_create :make_activation_code
  before_save :encrypt_password

  after_create :first_user_setup

  # Find a User record based on an identifier from a request parameter.
  def self.find_by_param(*args)
    find_by_login *args
  end

  # Authenticates a User by their login and unencrypted password.
  # Returns the authenticated User instance or +nil+.
  def self.authenticate(login, password)
    u = find :first, :conditions =>
      [ 'login = ? AND crypted_password IS NOT NULL', login ]

    u && u.authenticated?(password) ? u : nil
  end

  # Encrypt some data. Returns the encrypted data.
  def encrypt(data)
    self.salt ||= Digest::SHA1.hexdigest("--#{Time.now}--#{login}--")

    Digest::SHA1.hexdigest("--#{self.salt}--#{data}--")
  end

  # Activates this User in the database.
  #
  # A confirmation email will be sent automatically if the
  # <tt>send_email</tt> flag is set.
  def activate(send_email = true)
    @activated = send_email
    update_attributes :activated_at => Time.now, :activation_code => nil
  end

  # Marks this User as having forgotten their password.
  def forgot_password
    @forgot = true
    self.make_activation_code
    self.save false
  end

  # Returns +true+ if the User has just been activated.
  def recently_activated?
    @activated
  end

  # Returns +true+ if the User has just been marked as having
  # forgotten their password.
  def recently_forgot?
    @forgot
  end

  # Returns +true+ if the password can be used to authenticate this User.
  def authenticated?(password)
    crypted_password == encrypt(password)
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

  # This method returns an identifier for use in generating request
  # parameters.
  def to_param
    self.login
  end

  # If both +firstname+ and +lastname+ attributes are present, this method
  # returns a String containing those attributes combined.  Otherwise,
  # +nil+ is returned.
  def fullname
    return if self.firstname.blank? or self.lastname.blank?

    "#{firstname} #{lastname}"
  end

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

  protected

  # Encrypt the value of the plaintext password attribute and store the
  # result in the crypted_password attribute.
  def encrypt_password
    return if password.blank?
    self.crypted_password = encrypt(password)
  end

  # Returns true if the User has not yet set a password.
  def password_required?
    crypted_password.blank? or not password.blank?
  end

  # Generate an activation code and store the result in the activation_code
  # attribute.
  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest("--#{Time.now}--#{salt}--")
  end

  # Check if this is the first account in the database and setup accordingly.
  def first_user_setup
    return unless User.count == 1

    # Find or create the default role for configuration management.
    role = Role.find_by_code('ManageConfig')
    role ||= Role.create({
      :code => 'ManageConfig',
      :name => 'Manage configuration'
    })

    # Add the first user to the default role.
    self.roles.push role
  end
end

