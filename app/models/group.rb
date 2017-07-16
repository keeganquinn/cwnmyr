# A Group of Users may work together to manage Nodes as a team.
class Group < ApplicationRecord
  has_and_belongs_to_many :users, uniq: true

  validates_length_of :code, minimum: 1
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      if: proc { |o| o.code.size > 1 }
  validates_length_of :name, minimum: 1

  before_validation :set_defaults

  def to_param
    return unless id
    [id, code].join('-')
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
