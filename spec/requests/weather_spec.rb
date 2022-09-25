# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather_spec.rb', type: :request do
  let(:params_valid) { { weather: { token: SecureRandom.hex, location: Faker::Address.state } } }
  let(:params_invalid) { { weather: { token: '', location: '' } } }

  describe 'POST /weather/current', vcr: { cassette_name: 'weather/current', record: :new_episodes } do
    it 'POST Weather/current with status 201' do
      post '/weather/current', params: params_valid
      expect(response).to have_http_status(:created)
    end

    it 'POST Weather/current with status 202' do
      post '/weather/current', params: params_invalid
      expect(response).to have_http_status(:accepted)
    end
  end

  describe 'GET /weather/current/result' do
    it 'Response with status 200' do
      get '/weather/current/result', params: { token: params_valid[:weather][:token] }
      expect(response).to have_http_status(:ok)
    end

    it 'Response with status 202' do
      get '/weather/current/result', params: { token: nil }
      expect(response).to have_http_status(:accepted)
    end
  end

  describe 'GET /weathers' do
    it 'Response with status 200' do
      get '/weathers'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /weathers/:id' do
    it 'Response with status 200' do
      weather = create(:weather)
      delete "/weathers/#{weather.id}"
      expect(response).to have_http_status(:ok)
    end
  end
end
