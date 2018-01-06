FactoryBot.define do
  factory :interface do
    interface_type
    host
    sequence(:name) { |n| "Test Interface ##{n}" }
    body { Faker::Lorem.paragraphs }
  end
end
