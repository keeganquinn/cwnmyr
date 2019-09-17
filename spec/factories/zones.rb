# frozen_string_literal: true

FactoryBot.define do
  factory :zone do
    sequence(:name) { |n| "Test Zone ##{n}" }

    trait :with_image do
      transient do
        nav_logo_file do
          Rack::Test::UploadedFile.new 'app/assets/images/position.png',
                                       'image/png'
        end

        after :build do |zone, evaluator|
          zone.nav_logo.attach io: evaluator.nav_logo_file.open,
                               filename: evaluator.nav_logo_file.path
        end
      end
    end
  end
end
