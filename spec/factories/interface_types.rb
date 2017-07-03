FactoryGirl.define do
  factory :interface_type do
    sequence(:name) { |n| "Test Type ##{n}" }
  end
end
