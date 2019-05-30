# frozen_string_literal: true

FactoryBot.define do
  factory :device_property do
    device
    sequence(:key) { |n| "key#{n}" }
    sequence(:value) { |n| "value#{n}" }
  end
end
