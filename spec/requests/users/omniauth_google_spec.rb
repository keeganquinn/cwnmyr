# frozen_string_literal: true

describe 'Omniauth Google callback', type: :request do
  subject { response }

  let(:current_user) { create :user }

  describe 'successful authentication with email provided' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '12345678',
        info: { email: 'spec@basslin.es' }
      )
      get user_google_oauth2_omniauth_callback_path
    end

    it { is_expected.to have_http_status(:found) }
  end

  describe 'successful authentication with email not provided' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '12345678'
      )
      get user_google_oauth2_omniauth_callback_path
    end

    it { is_expected.to have_http_status(:found) }
  end

  describe 'successful authentication when already logged in' do
    before do
      login_as current_user
      get user_google_oauth2_omniauth_callback_path
    end

    it { is_expected.to have_http_status(:found) }
  end

  describe 'failed authentication' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      get user_google_oauth2_omniauth_callback_path
    end

    it { is_expected.to have_http_status(:found) }
  end
end
