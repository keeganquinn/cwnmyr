# frozen_string_literal: true

describe 'Error unacceptable action', type: :request do
  subject { response }

  context 'when HTML format is requested' do
    before { get '/422' }

    it { is_expected.to have_http_status(:unprocessable_entity) }
    it { is_expected.to render_template('errors/unacceptable') }
  end

  context 'when JSON format is requested' do
    before { get '/422.json' }

    it { is_expected.to have_http_status(:unprocessable_entity) }
    it { is_expected.to respond_with_content_type(:json) }
  end

  context 'when XML format is requested' do
    before { get '/422.xml' }

    it { is_expected.to have_http_status(:unprocessable_entity) }
    it { is_expected.to respond_with_content_type(:xml) }
  end
end
