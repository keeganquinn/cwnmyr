FactoryBot.define do
  factory :contact do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    email { "#{name.parameterize}@example.com" }
    phone { Faker::PhoneNumber.phone_number }
  end
end
