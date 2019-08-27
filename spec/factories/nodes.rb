# frozen_string_literal: true

FactoryBot.define do
  factory :node do
    contact
    status
    user
    zone
    group
    name { Faker::Company.name }
    live_date { Date.today }
    body { Faker::Lorem.paragraphs }
    address { '709 W 27th St., Vancouver, WA 98660' }
    hours { Faker::Lorem.sentence }
    notes { Faker::Lorem.paragraphs }
    website { 'https://quinn.tk/' }
    rss { 'https://quinn.tk/feed.rss' }
    twitter { 'keeganquinn' }
    wiki { 'https://quinn.tk/' }

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
