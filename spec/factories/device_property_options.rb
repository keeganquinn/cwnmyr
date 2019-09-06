# frozen_string_literal: true

FactoryBot.define do
  factory :device_property_option do
    device_property_type
    sequence(:name) { |n| "Option #{n}" }
    sequence(:value) { |n| "value#{n}" }
  end
end
