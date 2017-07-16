# Each HostType instance represents a type of Host.  Commentary can
# be provided by means of HostTypeComment instances.
class HostType < ApplicationRecord
  has_many :hosts

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      if: proc { |o| o.code.size > 1 }
  validates_length_of :name, minimum: 1
  validates_length_of :name, maximum: 255

  before_validation :set_defaults

  def to_param
    return unless id
    [id, code].join('-')
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
