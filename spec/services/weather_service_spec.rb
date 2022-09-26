# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather_service_spec.rb' do
  describe '#current', vcr: { cassette_name: 'weather/current', record: :new_episodes } do
    let(:location) { ['Sao Paulo', 'Tocantins', 'Minas Gerais'].sample }

    it 'success' do
      expect(WeatherService.current(location)).not_to be_empty
    end

    it 'error' do
      expect(WeatherService.current(nil).keys).to eql(%i[code message])
    end
  end
end
