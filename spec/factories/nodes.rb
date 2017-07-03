FactoryGirl.define do
  factory :node do
    contact
    status
    user
    zone
    name { Faker::Company.name }
    address { "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state} #{Faker::Address.zip}" }
  end
end
