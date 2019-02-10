# frozen_string_literal: true

FactoryBot.define do
  factory :node_link do
    node
    sequence(:name) { |n| "Test Link ##{n}" }
    url { 'http://test.com' }
  end
end
