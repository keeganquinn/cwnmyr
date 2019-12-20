# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    node
    device_properties { build_list :device_property, 2 }
    sequence(:name) { |n| "test#{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
