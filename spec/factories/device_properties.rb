# frozen_string_literal: true

FactoryBot.define do
  factory :device_property do
    device_property_type
    sequence(:value) { |n| "value#{n}" }
  end
end
