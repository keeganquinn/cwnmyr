# frozen_string_literal: true

# A Contact is a person of interest related to one or more Nodes.
class Contact < ApplicationRecord
  has_paper_trail
  has_many :nodes
  belongs_to :user, optional: true
  belongs_to :group, optional: true

  validates_presence_of :code
  validates_length_of :code, maximum: 64
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true
  validates_presence_of :name

  before_validation :set_defaults

  scope :ungrouped, -> { where(group_id: nil) }

  # Canonical identifier.
  def to_param
    return unless id

    [id, code].join('-')
  end

  # Set default values.
  def set_defaults
    self.code = name.parameterize if code.blank? && name
    self.uuid ||= SecureRandom.uuid
  end
end
