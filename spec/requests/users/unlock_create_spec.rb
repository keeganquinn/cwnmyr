# frozen_string_literal: true

describe 'Unlock create action', type: :request do
  subject { response }

  before { post user_unlock_path }

  it { is_expected.to have_http_status(:unprocessable_entity) }
end
