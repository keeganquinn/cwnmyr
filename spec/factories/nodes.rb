# frozen_string_literal: true

FactoryBot.define do
  factory :node do
    contact
    status
    user
    zone
    name { Faker::Company.name }
    body { Faker::Lorem.paragraphs }
    address { '709 W 27th St., Vancouver, WA 98660' }
    notes { Faker::Lorem.paragraphs }

    trait :with_image do
      transient do
        logo_file do
          Rack::Test::UploadedFile.new 'app/assets/images/position.png',
                                       'image/png'
        end

        after :build do |node, evaluator|
          node.logo.attach io: evaluator.logo_file.open,
                           filename: evaluator.logo_file.path
        end
      end
    end
  end
end
