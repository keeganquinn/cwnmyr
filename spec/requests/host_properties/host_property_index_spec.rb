describe 'Host Property index action', type: :request do
  subject { response }

  context 'when JSON format is requested' do
    before { get host_properties_path(format: :json) }

    it { is_expected.to have_http_status(302) }
    it { is_expected.to redirect_to(root_path) }
  end

  context 'when XML format is requested' do
    before { get host_properties_path(format: :xml) }

    it { is_expected.to have_http_status(302) }
    it { is_expected.to redirect_to(root_path) }
  end
end
