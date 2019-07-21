# frozen_string_literal: true

describe 'Device Type index action', type: :request do
  subject { response }

  context 'when JSON format is requested' do
    before { get device_types_path(format: :json) }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to respond_with_content_type(:json) }
    it { is_expected.to render_template('device_types/index') }
  end

  context 'when XML format is requested' do
    before { get device_types_path(format: :xml) }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to respond_with_content_type(:xml) }
    it { is_expected.to render_template('device_types/index') }
  end
end
