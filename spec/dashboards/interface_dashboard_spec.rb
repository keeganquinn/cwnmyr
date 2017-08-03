describe InterfaceDashboard do
  subject(:dashboard) { described_class }

  let(:interface) { build_stubbed :interface }

  it 'defines attribute types' do
    expect(dashboard.const_get(:ATTRIBUTE_TYPES).length).to eq(27)
  end

  it 'defines collection attributes' do
    expect(dashboard.const_get(:COLLECTION_ATTRIBUTES).length).to eq(4)
  end

  it 'defines show page attributes' do
    expect(dashboard.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(26)
  end

  it 'defines form attributes' do
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(23)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(interface)).to(
      match "^Interface ##{interface.to_param}$"
    )
  end
end
