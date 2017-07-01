FactoryGirl.define do
  factory :interface do
    interface_type
    status
    host
    sequence(:name) { |n| "Test Interface ##{n}" }
  end
end
