FactoryBot.define do
  factory :user do
    confirmed_at { Time.now }
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    email { "#{name.parameterize}@example.com" }
    password { 'please123' }
    body { Faker::Lorem.paragraphs }

    trait :admin do
      role { 'admin' }
    end
  end
end
