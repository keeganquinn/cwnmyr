# frozen_string_literal: true

FactoryBot.define do
  factory :build_provider do
    name { Faker::Company.name }
    url { 'https://jenkins.company.com/job/yourjob' }
    mode { 'pass' }
  end
end
