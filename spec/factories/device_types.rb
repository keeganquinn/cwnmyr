# frozen_string_literal: true

FactoryBot.define do
  factory :device_type do
    sequence(:name) { |n| "Test Type ##{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
