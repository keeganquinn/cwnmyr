# frozen_string_literal: true

describe 'Device build_config action', type: :request do
  subject { response }

  let(:device_type) { create :device_type, config: 'KEY=value' }
  let(:device) { create :device, device_type: device_type }

  before { get build_config_device_path(device) }

  it { is_expected.to have_http_status(:ok) }
  it { is_expected.to respond_with_content_type(:text) }
end
