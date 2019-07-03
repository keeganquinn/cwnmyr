# frozen_string_literal: true

describe 'Node Link show page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:node_link) { create :node_link, node: node }

  before do
    login_as current_user
    visit node_link_path(node_link)
  end

  it { expect(page).to have_content node_link.name }
end
