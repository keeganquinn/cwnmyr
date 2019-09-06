# frozen_string_literal: true

FactoryBot.define do
  factory :device_property_type do
    sequence(:code) { |n| "prop#{n}" }
    name { "Property #{code}" }
    value_type { :config }
  end
end
