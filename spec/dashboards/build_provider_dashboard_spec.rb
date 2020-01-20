# frozen_string_literal: true

describe BuildProviderDashboard do
  subject(:dashboard) { described_class }

  let(:build_provider) { build_stubbed :build_provider }

  it 'defines attribute types' do
    expect(dashboard.const_get(:ATTRIBUTE_TYPES).length).to eq(12)
  end

  it 'defines collection attributes' do
    expect(dashboard.const_get(:COLLECTION_ATTRIBUTES).length).to eq(4)
  end

  it 'defines show page attributes' do
    expect(dashboard.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(11)
  end

  it 'defines form attributes' do
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(7)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(build_provider)).to(
      match "^Build Provider ##{build_provider.id}$"
    )
  end
end
