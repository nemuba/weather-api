# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Weather, type: :model do
  let(:weather) { build(:weather) }

  it 'be valid?' do
    expect(weather).to be_valid
  end

  it '#token be present?' do
    expect(weather.token).to be_present
  end

  it '#location be present?' do
    expect(weather.location).to be_present
  end

  it '#data be present?' do
    expect(weather.data).to be_present
  end

  it '#create' do
    expect { create(:weather) }.to change(described_class, :count).by(1)
  end
end
