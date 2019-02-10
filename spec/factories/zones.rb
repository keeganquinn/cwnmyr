# frozen_string_literal: true

FactoryBot.define do
  factory :zone do
    sequence(:name) { |n| "Test Zone ##{n}" }
  end
end
