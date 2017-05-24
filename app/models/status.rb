# Each Status instance represents a generalized state which might apply
# to any number of Node, Host or Interface instances.
class Status < ApplicationRecord
  default_scope { order('name ASC') }

  has_many :nodes
  has_many :hosts
  has_many :interfaces

  validates_length_of :code, :minimum => 1
  validates_length_of :code, :maximum => 64
  validates_uniqueness_of :code
  validates_format_of :code, :with => %r{\A[-_a-zA-Z0-9]+\z},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |o| o.code && o.code.size > 1 }
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 64

  # Find a Status record based on an identifier from a request parameter.
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

  before_validation_on_create :set_defaults

  # Set default values.
  def set_defaults
    self.code = self.stripped_name if self.code.blank?
  end
end
