# frozen_string_literal: true

FactoryBot.define do
  factory :network do
    sequence(:name) { |n| "Test Type ##{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
