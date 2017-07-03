# Each HostType instance represents a type of Host.  Commentary can
# be provided by means of HostTypeComment instances.
class HostType < ApplicationRecord
  has_many :hosts

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code, with: %r{\A[-_a-zA-Z0-9]+\z},
    message: 'contains unacceptable characters',
    if: Proc.new { |o| o.code.size > 1 }
  validates_length_of :name, minimum: 1
  validates_length_of :name, maximum: 255

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
