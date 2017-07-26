# A User is a person who can log in to the system.
class User < ApplicationRecord
  has_paper_trail
  has_and_belongs_to_many :groups, uniq: true
  has_many :nodes
  has_many :user_links
  enum role: %i[user manager admin]

  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, allow_blank: true, case_sensitive: false
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      if: proc { |o| o.code && o.code.size > 1 }
  validates_uniqueness_of :name, allow_blank: true, case_sensitive: false
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email,
                      with: /\A([\w\-\.\#\$%&!?*\'=(){}|~_]+)
                            @([0-9a-zA-Z\-\.\#\$%&!?*\'=(){}|~]+)+\z/x,
                      message: 'must be a valid email address',
                      if: proc { |o| o.email && o.email.size > 1 }

  before_validation :set_defaults

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable

  def to_param
    return unless id
    code && [id, code].join('-') || id.to_s
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
    self.role ||= :user
  end
end
