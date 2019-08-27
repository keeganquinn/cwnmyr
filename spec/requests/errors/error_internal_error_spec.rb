# frozen_string_literal: true

describe 'Error internal_error action', type: :request do
  subject { response }

  context 'when HTML format is requested' do
    before { get '/500' }

    it { is_expected.to have_http_status(:internal_server_error) }
    it { is_expected.to render_template('errors/internal_error') }
  end

  context 'when JSON format is requested' do
    before { get '/500.json' }

    it { is_expected.to have_http_status(:internal_server_error) }
    it { is_expected.to respond_with_content_type(:json) }
  end

  context 'when XML format is requested' do
    before { get '/500.xml' }

    it { is_expected.to have_http_status(:internal_server_error) }
    it { is_expected.to respond_with_content_type(:xml) }
  end
end
