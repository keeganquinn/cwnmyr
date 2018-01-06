FactoryBot.define do
  factory :zone do
    sequence(:name) { |n| "Test Zone ##{n}" }
  end
end
