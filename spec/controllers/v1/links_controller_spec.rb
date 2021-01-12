# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'links API', type: :request do

  # Add links
  let!(:links) { create_list(:link, 10) }
  let!(:link) { links.last }

  # Test suite for GET /links
  describe 'GET /links' do
    # make HTTP get request before each example
    before { get '/links', params: {} }

    it 'returns links' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /links/:slug
  describe 'GET /s/:slug' do
    let(:link_slug) { link.slug }

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

  # Test suite for POST /links
  # describe 'POST /links' do
  #   # valid payload
  #   let(:valid_attributes) { { slug: 'learn', url: 'google.com' }.to_json }
  #
  #   context 'when the request is valid' do
  #     before { post '/links', params: valid_attributes, headers: headers }
  #
  #     it 'creates a link' do
  #       debugger
  #       expect(JSON.parse(response.body)['slug']).to eq('learn')
  #       expect(JSON.parse(response.body)['url']).to eq('google.com')
  #     end
  #
  #     it 'returns status code 201' do
  #       expect(response).to have_http_status(201)
  #     end
  #   end

  #   context 'when the request is invalid' do
  #     let(:invalid_attributes) { { name: nil }.to_json }
  #     before { post '/links', params: invalid_attributes, headers: headers }
  #
  #     it 'returns status code 422' do
  #       expect(response).to have_http_status(422)
  #     end
  #
  #     it 'returns a validation failure message' do
  #       expect(json['message'])
  #           .to match(/Validation failed: Name can't be blank/)
  #     end
  #   end
  # end
  #
  # # Test suite for PUT /links/:id
  # describe 'PUT /links/:id' do
  #   let(:valid_attributes) { { name: 'Shopping' }.to_json }
  #
  #   context 'when the record exists' do
  #     before { put "/links/#{link_id}", params: valid_attributes, headers: headers }
  #
  #     it 'updates the record' do
  #       expect(response.body).to be_empty
  #     end
  #
  #     it 'returns status code 204' do
  #       expect(response).to have_http_status(204)
  #     end
  #   end
  # end
  #
  # # Test suite for DELETE /links/:id
  # describe 'DELETE /links/:id' do
  #   before { delete "/links/#{link_id}", params: {}, headers: headers }
  #
  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  # end
end