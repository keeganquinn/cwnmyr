# frozen_string_literal: true

describe 'Device destroy action', type: :request do
  subject { response }

  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }

  before { login_as current_user }

  describe 'valid JSON request' do
    before { delete device_path(device, format: :json) }

    it { is_expected.to have_http_status(:no_content) }
  end
end
