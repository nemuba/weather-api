# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService do
  describe '#current', vcr: { cassette_name: 'weather/current', record: :new_episodes } do
    let(:location) { ['Sao Paulo', 'Tocantins', 'Minas Gerais'].sample }

    it 'success' do
      expect(described_class.current(location)).not_to be_empty
    end

    it 'error' do
      expect(described_class.current(nil).keys).to eql(%i[code message])
    end
  end
end
