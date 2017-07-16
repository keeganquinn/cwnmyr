describe HostPropertyDashboard do
  subject(:dashboard) { described_class }

  let(:host_property) { build_stubbed :host_property }

  it 'defines attribute types' do
    expect(dashboard.const_get(:ATTRIBUTE_TYPES).length).to eq(6)
  end

  it 'defines collection attributes' do
    expect(dashboard.const_get(:COLLECTION_ATTRIBUTES).length).to eq(3)
  end

  it 'defines show page attributes' do
    expect(dashboard.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(5)
  end

  it 'defines form attributes' do
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(3)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(host_property)).to(
      match "^Host Property ##{host_property.to_param}$"
    )
  end
end
