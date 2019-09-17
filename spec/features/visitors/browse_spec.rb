# frozen_string_literal: true

describe 'Browse page', type: :feature do
  let(:zone) { create :zone, :with_image, default: true }
  let!(:node) { create :node, zone: zone }

  before { visit browse_path }

  it { expect(page).to have_content node.name }
end
