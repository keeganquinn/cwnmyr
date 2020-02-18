# frozen_string_literal: true

# An Authorization represents an authorization context that has been
# established with a remote provider or service.
class Authorization < ApplicationRecord
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  # Locate an Authorization from a provided set of OmniAuth credentials.
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |new_auth|
      new_auth.provider = auth.provider
      new_auth.uid = auth.uid
      new_auth.confirmed_at = Time.now
    end
  end
end
