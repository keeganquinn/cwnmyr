# frozen_string_literal: true

describe AuthorizedHostDashboard do
  subject(:dashboard) { described_class }

  let(:authorized_host) { build_stubbed :authorized_host }

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
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(6)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(authorized_host)).to(
      match "^Authorized Host ##{authorized_host.to_param}$"
    )
  end
end
