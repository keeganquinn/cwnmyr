# frozen_string_literal: true

# An Event instance represents a public event happening at a specific time
# and place.
class Event < ApplicationRecord
  has_paper_trail

  belongs_to :user, optional: true
  belongs_to :group, optional: true
  has_one_attached :image

  validates_presence_of :name

  before_validation :set_defaults

  # Set default values.
  def set_defaults
    self.uuid ||= SecureRandom.uuid
  end
end
