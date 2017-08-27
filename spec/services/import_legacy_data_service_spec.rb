describe ImportLegacyDataService do
  subject(:service) { described_class }

  let!(:nodes) { service.new.call }

  it 'returns nodes' do
    expect(nodes).not_to be_empty
  end

  it 'creates node records' do
    expect(Node.count).to be_positive
  end
end
