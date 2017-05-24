# A Zone instance represents a physical area at a large scale.  It serves
# as an organizational aid and the heirarchial root of the system when
# browsing in the user interface.
#
# Node and ZoneMaintainer instances are dependencies.
class Zone < ApplicationRecord
  default_scope { order('name ASC') }

  scope :exposed, -> { where(expose: true) }

  has_many :nodes

  validates_length_of :code, :minimum => 1
  validates_length_of :code, :maximum => 64
  validates_uniqueness_of :code
  validates_format_of :code, :with => %r{\A[-_a-zA-Z0-9]+\z},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |zone| zone.code && zone.code.size > 1 }
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 64

  def to_param
    [id, code].join('-')
  end

  protected

  before_validation :set_defaults, :on => :create

  def set_defaults
    self.code = name.parameterize if code.blank? and name
  end
end
