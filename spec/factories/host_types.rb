FactoryGirl.define do
  factory :host_type do
    sequence(:name) { |n| "Test Type ##{n}" }
  end
end
