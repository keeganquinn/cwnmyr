describe UserLink do
  subject(:user_link) { build_stubbed(:user_link) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:url) }

  it { is_expected.to validate_length_of(:name) }
  it { is_expected.to validate_length_of(:url) }

  it { is_expected.to be_valid }

  it '#to_param returns nil when unsaved' do
    user_link.id = nil
    expect(user_link.to_param).to be_nil
  end

  it '#to_param returns a string' do
    expect(user_link.to_param).to(
      match "^#{user_link.id}-#{user_link.name.parameterize}$"
    )
  end
end
