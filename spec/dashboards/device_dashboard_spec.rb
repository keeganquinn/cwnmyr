# frozen_string_literal: true

describe DeviceDashboard do
  subject(:dashboard) { described_class }

  let(:device) { build_stubbed :device }

  it 'defines attribute types' do
    expect(dashboard.const_get(:ATTRIBUTE_TYPES).length).to eq(9)
  end

  it 'defines collection attributes' do
    expect(dashboard.const_get(:COLLECTION_ATTRIBUTES).length).to eq(3)
  end

  it 'defines show page attributes' do
    expect(dashboard.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(8)
  end

  it 'defines form attributes' do
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(4)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(device)).to(
      match "^Device ##{device.to_param}$"
    )
  end
end
