describe VerifyGeocodeService do
  subject(:service) { described_class }

  it 'reports nodes which were not geocoded' do
    node = create :node, address: '123 Nowhere Drive, Not A Real Place, Neptune'
    expect(service.new.call[0]).to(
      eq "#{node.id} #{node.code}: not geocoded: #{node.address}"
    )
  end

  it 'reports nodes which were placed out of range' do
    node = create :node, address: '34 Circle Terrace, Mason City, IA'
    expect(service.new.call[0]).to(
      eq "#{node.id} #{node.code}: location out of range: #{node.address}"
    )
  end
end
