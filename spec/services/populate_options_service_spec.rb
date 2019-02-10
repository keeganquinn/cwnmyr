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

  it 'creates host type records' do
    expect(HostType.count).to be_positive
  end

  it 'creates interface type records' do
    expect(InterfaceType.count).to be_positive
  end

  it 'creates status records' do
    expect(Status.count).to be_positive
  end

  it 'creates zone records' do
    expect(Zone.count).to be_positive
  end
end
