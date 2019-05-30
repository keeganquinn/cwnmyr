# frozen_string_literal: true

describe 'Device Property show action', type: :request do
  subject { response }

  context 'with a device property' do
    let(:device_property) { create :device_property }

    context 'when JSON format is requested' do
      before { get device_property_path(device_property, format: :json) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:json) }
      it { is_expected.to render_template('device_properties/show') }
    end

    context 'when XML format is requested' do
      before { get device_property_path(device_property, format: :xml) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:xml) }
      it { is_expected.to render_template('device_properties/show') }
    end
  end

  context 'without a device property' do
    context 'when JSON format is requested' do
      before { get device_property_path('123', format: :json) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:json) }
    end

    context 'when XML format is requested' do
      before { get device_property_path('123', format: :xml) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:xml) }
    end
  end
end
