# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "Test Group ##{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
