FactoryGirl.define do
  factory :user_link do
    user
    name "Test Link"
    url "http://test.com"
  end
end
