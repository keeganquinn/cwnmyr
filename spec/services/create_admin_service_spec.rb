# frozen_string_literal: true

describe CreateAdminService do
  subject(:service) { described_class }

  let(:admin) { service.new.call }

  it 'creates a valid user' do
    expect(admin).to be_valid
  end

  it 'created user is an admin' do
    expect(admin).to be_admin
  end

  it 'returns existing admin if there is one' do
    existing = create :user, :admin
    result = service.new.call
    expect(result).to eq existing
  end
end
