# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Weathers', type: :request do
  describe 'POST /weather/current', vcr: { cassette_name: 'weather/current', record: :new_episodes } do
    it 'POST Weather/current with status 200' do
      post '/weather/current', params: { location: 'Sao Paulo' }
      expect(response).to have_http_status(200)
    end

    it 'POST Weather/current with status 422' do
      post '/weather/current', params: { location: nil }
      body = JSON.parse(response.body)

      expect(response).to have_http_status(422)
      expect(body['code']).to eql(601)
      expect(body['message']).to eql('missing_query')
    end

    it 'POST Weather/current with current weather' do
      post '/weather/current', params: { location: 'Bahia' }
      body = JSON.parse(response.body)

      expect(body).to have_key('current')
      expect(body['current']).to be_kind_of(Hash)
      expect(body['current']).not_to be_empty
      expect(body['current']).to have_key('temperature')
    end
  end
end
