# frozen_string_literal: true

describe 'Device conf action', type: :request do
  subject { response }

  let(:pub) { create :interface, code: 'pub' }
  let(:priv) { create :interface, code: 'priv' }
  let(:device) { create :device, interfaces: [pub, priv] }

  before { get conf_device_path(device, format: :json) }

  it { is_expected.to have_http_status(:ok) }
  it { is_expected.to respond_with_content_type(:json) }
  it { is_expected.to render_template('devices/conf') }
end
