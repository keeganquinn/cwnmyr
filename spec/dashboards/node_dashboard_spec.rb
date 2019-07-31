# frozen_string_literal: true

describe NodeDashboard do
  subject(:dashboard) { described_class }

  let(:node) { build_stubbed :node }

  it 'defines attribute types' do
    expect(dashboard.const_get(:ATTRIBUTE_TYPES).length).to eq(23)
  end

  it 'defines collection attributes' do
    expect(dashboard.const_get(:COLLECTION_ATTRIBUTES).length).to eq(5)
  end

  it 'defines show page attributes' do
    expect(dashboard.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(22)
  end

  it 'defines form attributes' do
    expect(dashboard.const_get(:FORM_ATTRIBUTES).length).to eq(17)
  end

  it '#display_resource returns a string' do
    expect(dashboard.new.display_resource(node)).to(
      match "^Node#{node.code} \\(#{node.id}\\)$"
    )
  end
end
