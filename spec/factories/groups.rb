FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Test Group ##{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
