# frozen_string_literal: true

FactoryBot.define do
  factory :ahoy_event, class: Ahoy::Event do
    visit { create :ahoy_visit }
    user
  end
end
