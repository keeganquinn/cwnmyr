# frozen_string_literal: true

describe 'Omniauth Facebook callback', type: :request do
  subject { response }

  let(:current_user) { create :user }

  describe 'successful authentication with email provided' do
    before do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '12345678',
        info: { email: 'spec@basslin.es' }
      )
      post user_facebook_omniauth_callback_path
    end

    it { is_expected.to have_http_status(:found) }
  end

  describe 'successful authentication when already logged in' do
    before do
      login_as current_user
      post user_facebook_omniauth_callback_path
    end

    it { is_expected.to have_http_status(:found) }
  end

  describe 'failed authentication' do
    before { post user_facebook_omniauth_callback_path }

    it { is_expected.to have_http_status(:found) }
  end
end
