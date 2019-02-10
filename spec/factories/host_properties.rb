# frozen_string_literal: true

FactoryBot.define do
  factory :host_property do
    host
    sequence(:key) { |n| "key#{n}" }
    sequence(:value) { |n| "value#{n}" }
  end
end
