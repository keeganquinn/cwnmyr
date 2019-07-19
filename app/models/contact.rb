# frozen_string_literal: true

# A Contact is a person of interest related to one or more Nodes.
class Contact < ApplicationRecord
  has_paper_trail
  has_many :nodes
  belongs_to :user
  belongs_to :group, optional: true

  validates_presence_of :code
  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, case_sensitive: false
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true
  validates_presence_of :name
  validates_format_of :email,
                      with: /\A([\w\-\.\#\$%&!?*\'=(){}|~_]+)
                            @([0-9a-zA-Z\-\.\#\$%&!?*\'=(){}|~]+)+\z/x,
                      message: 'must be a valid email address',
                      allow_blank: true

  before_validation :set_defaults

  scope :ungrouped, -> { where(group_id: nil) }

  def to_param
    return unless id

    [id, code].join('-')
  end

  def set_defaults
    self.code = name.parameterize if code.blank? && name
  end
end
