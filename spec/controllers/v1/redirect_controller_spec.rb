# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::RedirectsController, type: :request do

  let!(:link) { create(:link) }

  # Test suite for GET /links/:slug
  describe 'GET /s/:slug' do
    let!(:link_slug) { link.slug }

    before { get "/s/#{link_slug}", headers: headers }

    context 'when the record exists' do
      it 'returns the link' do
        expect(response).to redirect_to %r{\Ahttp://www.google.com}
      end

      it 'returns status code 200' do
        expect(link.reload.clicked).to eq(1)
        # expect response to be a redirect
        expect(response).to have_http_status(302)
      end
    end

    context 'when the record does not exist' do
      let(:link_slug) { '12345' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Sorry, link not found./)
      end
    end
  end
end
