# frozen_string_literal: true

describe 'Group show page', type: :feature do
  let(:current_user) { create :user }
  let(:group) { create :group, users: [current_user] }

  before do
    login_as current_user
    visit group_path(group)
  end

  it { expect(page).to have_content group.name }
end
