# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService do
  describe '#current', vcr: { cassette_name: 'weather/current', record: :new_episodes } do
    let(:location) { ['Sao Paulo', 'Tocantins', 'Minas Gerais'].sample }

    it 'success' do
      expect(described_class.current(location)).not_to be_empty
      expect(described_class.current(location)).to be_kind_of(Hash)
      expect(described_class.current(location)).to have_key('location')
      expect(described_class.current(location)).to have_key('current')
    end

    it 'error' do
      expect(described_class.current(nil)).not_to be_empty
      expect(described_class.current(nil)).to be_kind_of(Hash)
      expect(described_class.current(nil)).to have_key(:code)
      expect(described_class.current(nil)).to have_key(:message)
    end
  end
end
