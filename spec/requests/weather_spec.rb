# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather', type: :request do
  describe 'POST /weather/current', vcr: { cassette_name: 'weather/current', record: :new_episodes } do
    let(:params_valid) { { weather: { token: SecureRandom.hex, location: Faker::Address.state } } }
    let(:params_invalid) { { weather: { token: '', location: '' } } }

    it 'POST Weather/current with status 201' do
      post '/weather/current', params: params_valid
      expect(response).to have_http_status(:created)
    end

    it 'POST Weather/current with status 202' do
      post '/weather/current', params: params_invalid
      expect(response).to have_http_status(:accepted)
    end
  end
end
