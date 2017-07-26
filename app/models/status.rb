# Each Status instance represents a generalized state which might apply
# to any number of Node, Host or Interface instances.
class Status < ApplicationRecord
  has_paper_trail
  has_many :nodes
  has_many :hosts
  has_many :interfaces

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      if: proc { |o| o.code && o.code.size > 1 }
  validates_length_of :name, minimum: 1
  validates_length_of :color, minimum: 1

  before_validation :set_defaults

  def to_param
    return unless id
    [id, code].join('-')
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
