# frozen_string_literal: true

describe 'Confirmation create action', type: :request do
  subject { response }

  before { post user_confirmation_path }

  it { is_expected.to have_http_status(:unprocessable_entity) }
end
