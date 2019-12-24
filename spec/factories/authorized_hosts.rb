# frozen_string_literal: true

FactoryBot.define do
  factory :authorized_host do
    device
    name { "Test Authorized Host #{SecureRandom.uuid}" }
    comment { Faker::Lorem.paragraphs }
  end
end
