FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Test Tag ##{n}" }
  end
end
