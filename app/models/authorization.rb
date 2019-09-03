# frozen_string_literal: true

# An Authorization represents a successful authentication from a
# remote provider.
class Authorization < ApplicationRecord
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |new_auth|
      new_auth.provider = auth.provider
      new_auth.uid = auth.uid
    end
  end
end
