FactoryGirl.define do
  factory :host do
    node
    sequence(:name) { |n| "test#{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
