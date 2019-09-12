# frozen_string_literal: true

FactoryBot.define do
  factory :interface do
    network
    device
    name { "Test Interface #{SecureRandom.uuid}" }
    body { Faker::Lorem.paragraphs }
  end
end
