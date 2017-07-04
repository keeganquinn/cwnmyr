include Warden::Test::Helpers
Warden.test_mode!

feature "Node index page", :devise do
  after(:each) do
    Warden.test_reset!
  end

  scenario "user is redirected" do
    visit nodes_path
    expect(current_path).to eq(root_path)
  end
end
