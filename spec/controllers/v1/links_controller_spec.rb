# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'links API', type: :request do

  # Add links
  let!(:links) { create_list(:link, 10) }
  let!(:link) { links.last }
  let!(:link_id) { link.id }

  # Test suite for GET /links
  describe 'GET /links' do
    # make HTTP get request before each example
    before { get '/links', params: {} }
    # json method is a custom method defined in support/requests_spec_helper.rb
    it 'returns links' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
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
  describe 'POST /links' do
    # valid payload
    let(:valid_attributes) { { slug: 'test', url: 'www.google.com' } }

    context 'when the request is valid' do
      before { post '/links', params: valid_attributes, headers: headers }

      it 'creates a link' do
        expect(json['slug']).to eq('test')
        expect(json['url']).to eq('http://www.google.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the slug is taken' do
      let(:link) { create(:link, slug: 'test') }
      before { post '/links', params: valid_attributes, headers: headers }

      it 'creates a link with new slug' do
        expect(json['slug'][0..3]).to eq('test')
        expect(json['url']).to eq('http://www.google.com')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { url: nil } }
      before { post '/links', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to eq(['url', "can't be blank"])
      end
    end
  end

  # Test suite for PUT /links/:id
  describe 'PUT /links/:id' do
    let!(:valid_attributes) { { url: 'www.yahoo.com' } }

    context 'when the record exists' do
      before { put "/links/#{link_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(json['url']).to eq('http://www.yahoo.com')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /links/:id
  describe 'DELETE /links/:id' do
    before { delete "/links/#{link_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end
  end
end