# frozen_string_literal: true

describe 'Zone image request', type: :request do
  subject { response }

  context 'without an image' do
    before { create :zone, default: true }

    context 'when image is requested' do
      before { get root_path(format: 'png') }

      it { is_expected.to have_http_status(:not_found) }
    end
  end

  context 'with an image' do
    before { create :zone, :with_image, default: true }

    context 'when image is requested' do
      before { get root_path(format: 'png') }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end

    context 'when resized image is requested' do
      before { get root_path(format: 'png', resize: '85x85') }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end
  end
end
