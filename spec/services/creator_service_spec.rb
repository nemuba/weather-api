# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Creator, type: :job do
  let(:attrs) { { token: SecureRandom.hex, location: Faker::Address.state } }

  describe '#call' do
    it 'success' do
      described_class.call(attrs)
      expect(GetJob).to have_enqueued_sidekiq_job(attrs[:token])
    end

    it 'error' do
      data = described_class.call({})
      expect(data.keys).to include(:error)
    end
  end

  describe '#show' do
    before do
      described_class.call(attrs)
    end

    it 'success' do
      data = described_class.show(attrs[:token])
      expect(data.keys).to include('data')
    end

    it 'error' do
      data = described_class.show(nil)
      expect(data.keys).to include(:error)
    end
  end
end
