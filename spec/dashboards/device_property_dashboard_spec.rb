# frozen_string_literal: true

describe DevicePropertyDashboard do
  subject(:dashboard) { described_class }

  let(:device_property) { build_stubbed :device_property }

  it 'defines attribute types' do
    expect(dashboard.const_get(:ATTRIBUTE_TYPES).length).to eq(7)
  end

  it 'defines collection attributes' do
    expect(dashboard.const_get(:COLLECTION_ATTRIBUTES).length).to eq(4)
  end

  it 'defines show page attributes' do
    expect(dashboard.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(6)
  end

  it 'defines form attributes' do
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(4)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(device_property)).to(
      match "^Device Property ##{device_property.to_param}$"
    )
  end
end
