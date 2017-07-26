# A Contact is a person of interest related to one or more Nodes.
class Contact < ApplicationRecord
  has_paper_trail
  has_many :nodes

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      if: proc { |o| o.code.size > 1 }
  validates_length_of :name, minimum: 1
  validates_format_of :email,
                      with: /\A([\w\-\.\#\$%&!?*\'=(){}|~_]+)
                            @([0-9a-zA-Z\-\.\#\$%&!?*\'=(){}|~]+)+\z/x,
                      message: 'must be a valid email address',
                      if: proc { |o| o.email && o.email.size > 1 }

  before_validation :set_defaults

  def to_param
    return unless id
    [id, code].join('-')
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
