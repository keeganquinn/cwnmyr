# frozen_string_literal: true

FactoryBot.define do
  factory :authorization do
    user
    provider { 'factory' }
    uid { SecureRandom.uuid }
    confirmed_at { Time.now }
  end
end
