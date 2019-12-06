# frozen_string_literal: true

def png_image
  Rack::Test::UploadedFile.new 'app/assets/images/position.png', 'image/png'
end

FactoryBot.define do
  factory :zone do
    sequence(:name) { |n| "Test Zone ##{n}" }

    trait :with_images do
      transient do
        nav_logo { png_image }
        chromeicon_192 { png_image }
        chromeicon_512 { png_image }
        touchicon_180 { png_image }
        favicon_png16 { png_image }
        favicon_png32 { png_image }
        mstile_150 { png_image }

        favicon_ico do
          Rack::Test::UploadedFile.new 'spec/support/favicon.ico',
                                       'image/vnd.microsoft.icon'
        end

        maskicon_svg do
          Rack::Test::UploadedFile.new 'spec/support/maskicon.svg',
                                       'image/svg'
        end

        after :build do |zone, evaluator|
          zone.nav_logo.attach io: evaluator.nav_logo.open,
                               filename: evaluator.nav_logo.path
          zone.chromeicon_192.attach io: evaluator.chromeicon_192.open,
                                     filename: evaluator.chromeicon_192.path
          zone.chromeicon_512.attach io: evaluator.chromeicon_512.open,
                                     filename: evaluator.chromeicon_512.path
          zone.touchicon_180.attach io: evaluator.touchicon_180.open,
                                    filename: evaluator.touchicon_180.path
          zone.favicon_png16.attach io: evaluator.favicon_png16.open,
                                    filename: evaluator.favicon_png16.path
          zone.favicon_png32.attach io: evaluator.favicon_png32.open,
                                    filename: evaluator.favicon_png32.path
          zone.favicon_ico.attach io: evaluator.favicon_ico.open,
                                  filename: evaluator.favicon_ico.path
          zone.mstile_150.attach io: evaluator.mstile_150.open,
                                 filename: evaluator.mstile_150.path
          zone.maskicon_svg.attach io: evaluator.maskicon_svg.open,
                                   filename: evaluator.maskicon_svg.path
        end
      end
    end
  end
end
