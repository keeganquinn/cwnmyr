FactoryGirl.define do
  factory :node do
    contact
    status
    user
    zone
    name { Faker::Company.name }
    body { Faker::Lorem.paragraphs }
    address '709 W 27th St., Vancouver, WA 98660'
    notes { Faker::Lorem.paragraphs }
  end
end
