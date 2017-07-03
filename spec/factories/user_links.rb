FactoryGirl.define do
  factory :user_link do
    user
    sequence(:name) { |n| "Test Link ##{n}" }
    url "http://test.com"
  end
end
