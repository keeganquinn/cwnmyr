describe CreateAdminService do
  subject(:service) { described_class }

  let(:admin) { service.new.call }

  it 'creates a valid user' do
    expect(admin).to be_valid
  end

  it 'created user is an admin' do
    expect(admin).to be_admin
  end
end
