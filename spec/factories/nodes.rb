FactoryGirl.define do
  factory :node do
    contact
    status
    user
    zone
    name { "#{Faker::Company::name}" }
  end
end
