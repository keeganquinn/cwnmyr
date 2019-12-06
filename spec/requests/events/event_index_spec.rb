# frozen_string_literal: true

describe 'Event API request', type: :request do
  subject { response }

  before { get events_path(format: 'json') }

  it { is_expected.to have_http_status(:ok) }
  it { is_expected.to respond_with_content_type(:json) }
end
