describe 'Host Type show action', type: :request do
  subject { response }

  context 'with a host type' do
    let(:host_type) { create :host_type }

    context 'when JSON format is requested' do
      before { get host_type_path(host_type, format: :json) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:json) }
      it { is_expected.to render_template('host_types/show') }
    end

    context 'when XML format is requested' do
      before { get host_type_path(host_type, format: :xml) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:xml) }
      it { is_expected.to render_template('host_types/show') }
    end
  end

  context 'without a host type' do
    context 'when JSON format is requested' do
      before { get host_type_path('123', format: :json) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:json) }
    end

    context 'when XML format is requested' do
      before { get host_type_path('123', format: :xml) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:xml) }
    end
  end
end
