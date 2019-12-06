# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    user
    group
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraphs }
  end
end
