# frozen_string_literal: true

describe 'Device update action', type: :request do
  subject { response }

  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }
  let(:device) { create :device, node: node }

  before { login_as current_user }

  describe 'valid JSON request' do
    before { put device_path(device, format: :json, device: { name: 'spec' }) }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to respond_with_content_type(:json) }
  end

  describe 'invalid JSON request' do
    before { put device_path(device, format: :json, device: { name: '' }) }

    it { is_expected.to have_http_status(:unprocessable_entity) }
    it { is_expected.to respond_with_content_type(:json) }
  end

  describe 'invalid XML request' do
    before { put device_path(device, format: :xml, device: { name: '' }) }

    it { is_expected.to have_http_status(:unprocessable_entity) }
    it { is_expected.to respond_with_content_type(:xml) }
  end
end
