# frozen_string_literal: true

describe 'Device show action', type: :request do
  subject { response }

  context 'with a device' do
    let(:device) { create :device }

    context 'when JSON format is requested' do
      before { get device_path(device, format: :json) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:json) }
      it { is_expected.to render_template('devices/show') }
    end

    context 'when XML format is requested' do
      before { get device_path(device, format: :xml) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:xml) }
      it { is_expected.to render_template('devices/show') }
    end
  end

  context 'without a device' do
    context 'when JSON format is requested' do
      before { get device_path('123', format: :json) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:json) }
    end

    context 'when XML format is requested' do
      before { get device_path('123', format: :xml) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:xml) }
    end
  end
end
