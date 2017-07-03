class Contact < ApplicationRecord
  has_many :nodes

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code, with: %r{\A[-_a-zA-Z0-9]+\z},
    message: 'contains unacceptable characters',
    if: Proc.new { |o| o.code.size > 1 }
  validates_length_of :name, minimum: 1
  validates_format_of :email,
    with: %r{\A([\w\-\.\#\$%&!?*\'=(){}|~_]+)@([0-9a-zA-Z\-\.\#\$%&!?*\'=(){}|~]+)+\z},
    message: 'must be a valid email address',
    if: Proc.new { |o| o.email && o.email.size > 1 }

  def to_param
    return nil if not id
    [id, code].join('-')
  end

  protected

  before_validation :set_defaults

  def set_defaults
    self.code = name.parameterize if code.blank? and name
  end
end
