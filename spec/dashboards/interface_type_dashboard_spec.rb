describe InterfaceTypeDashboard do
  subject(:dashboard) { described_class }

  let(:interface_type) { build_stubbed :interface_type }

  it 'defines attribute types' do
    expect(dashboard.const_get(:ATTRIBUTE_TYPES).length).to eq(7)
  end

  it 'defines collection attributes' do
    expect(dashboard.const_get(:COLLECTION_ATTRIBUTES).length).to eq(2)
  end

  it 'defines show page attributes' do
    expect(dashboard.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(4)
  end

  it 'defines form attributes' do
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(3)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(interface_type)).to(
      match "^Interface Type ##{interface_type.to_param}$"
    )
  end
end
