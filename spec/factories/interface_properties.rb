FactoryBot.define do
  factory :interface_property do
    interface
    sequence(:key) { |n| "key#{n}" }
    sequence(:value) { |n| "value#{n}" }
  end
end
