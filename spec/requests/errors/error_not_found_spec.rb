# frozen_string_literal: true

describe 'Error not_found action', type: :request do
  subject { response }

  context 'when HTML format is requested' do
    before { get '/404' }

    it { is_expected.to have_http_status(:not_found) }
    it { is_expected.to render_template('errors/not_found') }
  end

  context 'when JSON format is requested' do
    before { get '/404.json' }

    it { is_expected.to have_http_status(:not_found) }
    it { is_expected.to respond_with_content_type(:json) }
  end

  context 'when XML format is requested' do
    before { get '/404.xml' }

    it { is_expected.to have_http_status(:not_found) }
    it { is_expected.to respond_with_content_type(:xml) }
  end
end
