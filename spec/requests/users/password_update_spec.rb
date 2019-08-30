# frozen_string_literal: true

describe 'Password update action', type: :request do
  subject { response }

  before { put user_password_path }

  it { is_expected.to have_http_status(:unprocessable_entity) }
end
