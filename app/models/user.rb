class User < ApplicationRecord
  has_and_belongs_to_many :groups, uniq: true
  has_many :nodes
  has_many :user_links
  enum role: [:user, :manager, :admin]

  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, allow_blank: true, case_sensitive: false
  validates_format_of :code, with: %r{\A[-_a-zA-Z0-9]+\z},
    message: 'contains unacceptable characters',
    if: Proc.new { |o| o.code && o.code.size > 1 }
  validates_uniqueness_of :name, allow_blank: true, case_sensitive: false
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email,
    with: %r{\A([\w\-\.\#\$%&!?*\'=(){}|~_]+)@([0-9a-zA-Z\-\.\#\$%&!?*\'=(){}|~]+)+\z},
    message: 'must be a valid email address',
    if: Proc.new { |o| o.email && o.email.size > 1 }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable

  def to_param
    return nil if not id
    code and [id, code].join('-') or id.to_s
  end

  protected

  before_validation :set_defaults

  def set_defaults
    self.code = name.parameterize if code.blank? and name
    self.role ||= :user
  end
end
