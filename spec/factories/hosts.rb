FactoryGirl.define do
  factory :host do
    node
    status
    sequence(:name) { |n| "test#{n}" }
  end
end
