# frozen_string_literal: true

describe 'Device Type show action', type: :request do
  subject { response }

  context 'with a device type' do
    let(:device_type) { create :device_type }

    context 'when JSON format is requested' do
      before { get device_type_path(device_type, format: :json) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:json) }
      it { is_expected.to render_template('device_types/show') }
    end

    context 'when XML format is requested' do
      before { get device_type_path(device_type, format: :xml) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:xml) }
      it { is_expected.to render_template('device_types/show') }
    end
  end

  context 'without a device type' do
    context 'when JSON format is requested' do
      before { get device_type_path('123', format: :json) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:json) }
    end

    context 'when XML format is requested' do
      before { get device_type_path('123', format: :xml) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:xml) }
    end
  end
end
