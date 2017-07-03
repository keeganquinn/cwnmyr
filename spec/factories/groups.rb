FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Test Group ##{n}" }
  end
end
