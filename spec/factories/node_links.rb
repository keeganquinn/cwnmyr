FactoryGirl.define do
  factory :node_link do
    node
    name "Test Link"
    url "http://test.com"
  end
end
