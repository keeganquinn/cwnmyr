FactoryBot.define do
  factory :interface_type do
    sequence(:name) { |n| "Test Type ##{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
