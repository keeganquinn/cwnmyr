FactoryGirl.define do
  factory :status do
    sequence(:name) { |n| "Test Status ##{n}" }
  end
end
