# Each Status instance represents a generalized state which might apply
# to any number of Node, Host or Interface instances.
class Status < ApplicationRecord
  has_many :nodes
  has_many :hosts
  has_many :interfaces

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code, with: %r{\A[-_a-zA-Z0-9]+\z},
    message: 'contains unacceptable characters',
    if: Proc.new { |o| o.code && o.code.size > 1 }
  validates_length_of :name, minimum: 1

  def to_param
    [id, code].join('-')
  end

  protected

  before_validation :set_defaults

  def set_defaults
    self.code = name.parameterize if code.blank? and name
  end
end
