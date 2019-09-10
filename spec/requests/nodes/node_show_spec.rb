# frozen_string_literal: true

describe 'Node show action', type: :request do
  subject { response }

  context 'without an image' do
    let(:node) { create :node }

    context 'when image is requested' do
      before { get node_path(node, format: :png) }

      it { is_expected.to have_http_status(:not_found) }
    end
  end

  context 'with an image' do
    let(:node) { create :node, :with_image }

    context 'when image is requested' do
      before { get node_path(node, format: :png) }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to respond_with_content_type(:png) }
    end
  end
end
