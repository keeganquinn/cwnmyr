# frozen_string_literal: true

describe 'Zone image request', type: :request do
  subject { response }

  context 'without attached images' do
    before { create :zone, default: true }

    context 'when nav_logo is requested' do
      before { get root_path(format: 'png') }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when chromeicon_192 is requested' do
      before { get '/android-chrome-192x192.png' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when chromeicon_512 is requested' do
      before { get '/android-chrome-512x512.png' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when touchicon_180 is requested' do
      before { get '/apple-touch-icon.png' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when browserconfig is requested' do
      before { get '/browserconfig.xml' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:xml) }
    end

    context 'when favicon_png16 is requested' do
      before { get '/favicon-16x16.png' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when favicon_png32 is requested' do
      before { get '/favicon-32x32.png' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when favicon_ico is requested' do
      before { get '/favicon.ico' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when mstile_150 is requested' do
      before { get '/mstile-150x150.png' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when maskicon_svg is requested' do
      before { get '/safari-pinned-tab.svg' }

      it { is_expected.to have_http_status(:not_found) }
    end

    context 'when webmanifest is requested' do
      before { get '/site.webmanifest' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:json) }
    end
  end

  context 'with attached images' do
    before { create :zone, :with_images, default: true }

    context 'when nav_logo is requested' do
      before { get root_path(format: 'png') }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when resized nav_logo is requested' do
      before { get root_path(format: 'png', resize: '85x85') }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when chromeicon_192 is requested' do
      before { get '/android-chrome-192x192.png' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when chromeicon_512 is requested' do
      before { get '/android-chrome-512x512.png' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when touchicon_180 is requested' do
      before { get '/apple-touch-icon.png' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when browserconfig is requested' do
      before { get '/browserconfig.xml' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:xml) }
    end

    context 'when favicon_png16 is requested' do
      before { get '/favicon-16x16.png' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when favicon_png32 is requested' do
      before { get '/favicon-32x32.png' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when favicon_ico is requested' do
      before { get '/favicon.ico' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:ico) }
    end

    context 'when mstile_150 is requested' do
      before { get '/mstile-150x150.png' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when maskicon_svg is requested' do
      before { get '/safari-pinned-tab.svg' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:svg) }
    end

    context 'when webmanifest is requested' do
      before { get '/site.webmanifest' }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:json) }
    end
  end
end
