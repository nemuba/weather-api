# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Weathers', type: :request do
  describe 'POST /weather/current', vcr: { cassette_name: 'weather/current', record: :new_episodes } do
    let(:params_valid) { { weather: { token: SecureRandom.hex, location: Faker::Address.state } } }
    let(:params_invalid) { { weather: { token: '', location: '' } } }

    it 'POST Weather/current with status 201' do
      post '/weather/current', params: params_valid
      expect(response).to have_http_status(201)
    end

    it 'POST Weather/current with status 202' do
      post '/weather/current', params: params_invalid
      body = JSON.parse(response.body)

      expect(response).to have_http_status(202)
      expect(body['error']).to eql('error')
      expect(body['message']).to eql('missing_params: [:token, :location]')
    end
  end
end
