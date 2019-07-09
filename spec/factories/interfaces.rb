# frozen_string_literal: true

FactoryBot.define do
  factory :interface do
    network
    device
    sequence(:name) { |n| "Test Interface ##{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
