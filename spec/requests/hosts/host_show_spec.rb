describe 'Host show action', type: :request do
  subject { response }

  context 'with a host' do
    let(:host) { create :host }

    context 'when JSON format is requested' do
      before { get host_path(host, format: :json) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:json) }
      it { is_expected.to render_template('hosts/show') }
    end

    context 'when XML format is requested' do
      before { get host_path(host, format: :xml) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to respond_with_content_type(:xml) }
      it { is_expected.to render_template('hosts/show') }
    end
  end

  context 'without a host' do
    context 'when JSON format is requested' do
      before { get host_path('123', format: :json) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:json) }
    end

    context 'when XML format is requested' do
      before { get host_path('123', format: :xml) }

      it { is_expected.to have_http_status(404) }
      it { is_expected.to respond_with_content_type(:xml) }
    end
  end
end
