# frozen_string_literal: true

FactoryBot.define do
  factory :device_build do
    build_provider
    device
    device_type

    title { Faker::Company.name }
    url { 'https://jenkins.company.com/job/yourjob/builds/123' }
  end
end
