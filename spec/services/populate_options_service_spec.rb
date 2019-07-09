# frozen_string_literal: true

describe PopulateOptionsService do
  subject(:service) { described_class }

  let!(:records) { service.new.call }

  it 'returns records' do
    expect(records).not_to be_empty
  end

  it 'creates group records' do
    expect(Group.count).to be_positive
  end

  it 'creates device type records' do
    expect(DeviceType.count).to be_positive
  end

  it 'creates network records' do
    expect(Network.count).to be_positive
  end

  it 'creates status records' do
    expect(Status.count).to be_positive
  end

  it 'creates zone records' do
    expect(Zone.count).to be_positive
  end
end
