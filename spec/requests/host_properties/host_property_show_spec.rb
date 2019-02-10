# frozen_string_literal: true

describe 'Host Property show action', type: :request do
  subject { response }

  context 'with a host property' do
    let(:host_property) { create :host_property }

    context 'when JSON format is requested' do
      before { get host_property_path(host_property, format: :json) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:json) }
      it { is_expected.to render_template('host_properties/show') }
    end

    context 'when XML format is requested' do
      before { get host_property_path(host_property, format: :xml) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:xml) }
      it { is_expected.to render_template('host_properties/show') }
    end
  end

  context 'without a host property' do
    context 'when JSON format is requested' do
      before { get host_property_path('123', format: :json) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:json) }
    end

    context 'when XML format is requested' do
      before { get host_property_path('123', format: :xml) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:xml) }
    end
  end
end
