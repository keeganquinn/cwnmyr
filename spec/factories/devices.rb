# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    node
    sequence(:name) { |n| "test#{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
