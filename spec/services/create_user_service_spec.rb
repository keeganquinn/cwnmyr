describe CreateUserService do
  subject(:service) { described_class }

  let(:user) { service.new.call }

  it 'creates a valid user' do
    expect(user).to be_valid
  end

  it 'created user is not an admin' do
    expect(user).not_to be_admin
  end
end
